/*  $Id$ */
#include <sys/queue.h>

#include <inttypes.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#include <kcgi.h>
#include <ksql.h>
#include <kcgijson.h>

#include "kwebapp.db.h"

enum  page {
  PAGE_HOME,
  PAGE_LOGIN,
  PAGE_LOGOUT,
  PAGE__MAX
};

static const char *const pages[PAGE__MAX] = {
  "home", /* PAGE_HOME */
  "login", /* PAGE_LOGIN */
  "logout", /* PAGE_LOGOUT */
};

/*
 * Fill out all HTTP secure headers.
 * Use the existing document's MIME type.
 */
static void
http_alloc(struct kreq *r, enum khttp code)
{

  khttp_head(r, kresps[KRESP_STATUS], 
    "%s", khttps[code]);
  khttp_head(r, kresps[KRESP_CONTENT_TYPE], 
    "%s", kmimetypes[r->mime]);
  khttp_head(r, "X-Content-Type-Options", "nosniff");
  khttp_head(r, "X-Frame-Options", "DENY");
  khttp_head(r, "X-XSS-Protection", "1; mode=block");
}

/*
 * Fill out all headers with http_alloc() then start the HTTP document
 * body (no more headers after this point!)
 */
static void
http_open(struct kreq *r, enum khttp code)
{

  http_alloc(r, code);
  khttp_body(r);
}

/*
 * Emit an empty JSON document.
 */
static void
json_emptydoc(struct kreq *r)
{
  struct kjsonreq   req;

  kjson_open(&req, r);
  kjson_obj_open(&req);
  kjson_obj_close(&req);
  kjson_close(&req);
}

/*
 * Login a given user by their identifier.
 * Set the session cookie to expire in one year.
 * Return 400 on bad credentials or missing fields.
 * Return 200 on success.
 */
static void
sendlogin(struct kreq *r)
{
  int64_t     sid, token;
  struct kpair  *kpi, *kpp;
  char     buf[64];
  struct user  *pp;
  time_t     t = time(NULL);

  if ((kpi = r->fieldmap[VALID_USER_EMAIL]) == NULL ||
      (kpp = r->fieldmap[VALID_USER_HASH]) == NULL) {
    http_open(r, KHTTP_400);
    json_emptydoc(r);
    return;
  } 

  pp = db_user_get_creds(r->arg, 
    kpi->parsed.s, kpp->parsed.s);

  if (pp == NULL) {
    http_open(r, KHTTP_400);
    json_emptydoc(r);
    return;
  }

  token = arc4random();
  sid = db_sess_insert(r->arg, pp->id, token);
  kutil_epoch2str(t + 60 * 60 * 24 * 365, buf, sizeof(buf));

  http_alloc(r, KHTTP_200);
  khttp_head(r, kresps[KRESP_SET_COOKIE],
    "%s=%" PRId64 "; secure; "
    "HttpOnly; path=/; expires=%s",
    valid_keys[VALID_SESS_TOKEN].name, token, buf);
  khttp_head(r, kresps[KRESP_SET_COOKIE],
    "%s=%" PRId64 "; secure; "
    "HttpOnly; path=/; expires=%s", 
    valid_keys[VALID_SESS_ID].name, sid, buf);
  khttp_body(r);
  json_emptydoc(r);
  db_user_free(pp);
}

/*
 * Homepage for users.
 * Returns 403 if not logged in or not in experiment state.
 * Returns 200 otherwise with empty document.
 */
static void
sendhome(struct kreq *r, const struct sess *u)
{
  struct kjsonreq   req;

  http_open(r, KHTTP_200);
  kjson_open(&req, r);
  kjson_obj_open(&req);
  json_sess_obj(&req, u);
  kjson_obj_close(&req);
  kjson_close(&req);
}

static void
sendlogout(struct kreq *r, const struct sess *us)
{
  char     buf[32];

  kutil_epoch2str(0, buf, sizeof(buf));
  http_alloc(r, KHTTP_200);
  khttp_head(r, kresps[KRESP_SET_COOKIE],
    "%s=; path=/; secure; HttpOnly; expires=%s", 
    valid_keys[VALID_SESS_TOKEN].name, buf);
  khttp_head(r, kresps[KRESP_SET_COOKIE],
    "%s=; path=/; secure; HttpOnly; expires=%s", 
    valid_keys[VALID_SESS_ID].name, buf);
  khttp_body(r);
  json_emptydoc(r);
  db_sess_delete_id(r->arg, us->id);
}

int
main(void)
{
  struct kreq   r;
  enum kcgi_err   er;
  struct sess  *us = NULL;

  /* Log into a separate logfile (not system log). */

  kutil_openlog(LOGFILE);

  /* Actually parse HTTP document. */

  er = khttp_parse(&r, valid_keys, VALID__MAX, 
    pages, PAGE__MAX, PAGE_HOME);

  if (er != KCGI_OK)
    return EXIT_FAILURE;

  /* Necessary pledge for SQLite. */

  if (pledge("stdio rpath cpath wpath flock fattr", NULL) == -1) {
    khttp_free(&r);
    return EXIT_FAILURE;
  }

  /*
   * Front line of defence: make sure we're a proper method, make
   * sure we're a page, make sure we're a JSON file.
   */

  if (r.method != KMETHOD_GET && 
      r.method != KMETHOD_POST) {
    http_open(&r, KHTTP_405);
    khttp_free(&r);
    return EXIT_SUCCESS;
  } else if (r.page == PAGE__MAX|| 
             r.mime != KMIME_APP_JSON) {
    http_open(&r, KHTTP_404);
    khttp_puts(&r, "Page not found.");
    khttp_free(&r);
    return EXIT_SUCCESS;
  }

  r.arg = db_open(DATADIR "/" DATABASE);
  if (r.arg == NULL) {
    http_open(&r, KHTTP_500);
    json_emptydoc(&r);
    khttp_free(&r);
    return EXIT_SUCCESS;
  }

  if (r.page == PAGE_HOME) {
    if (r.cookiemap[VALID_SESS_ID] != NULL &&
        r.cookiemap[VALID_SESS_TOKEN] != NULL)
      us = db_sess_get_creds(r.arg, 
        r.cookiemap[VALID_SESS_TOKEN]->parsed.i,
        r.cookiemap[VALID_SESS_ID]->parsed.i);
    if (us == NULL) {
      http_open(&r, KHTTP_403);
      json_emptydoc(&r);
      db_close(r.arg);
      khttp_free(&r);
      return EXIT_SUCCESS;
    }
  }

  switch (r.page) {
  case PAGE_HOME:
    sendhome(&r, us);
    break;
  case PAGE_LOGIN:
    sendlogin(&r);
    break;
  case PAGE_LOGOUT:
    sendlogout(&r, us);
    break;
  default:
    abort();
  }

  db_sess_free(us);
  db_close(r.arg);
  khttp_free(&r);
  return EXIT_SUCCESS;
}
