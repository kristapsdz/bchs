#include <err.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>

#include <kcgi.h>
#include <kcgijson.h>

int
main(void)
{
  struct kreq r;
  struct kjsonreq req;
  const char *page = "index";

  if (khttp_parse(&r, NULL, 0, &page, 1, 0) != KCGI_OK)
    return EXIT_FAILURE;

  if (pledge("stdio", NULL) == -1) 
    err(EXIT_FAILURE, "pledge");

  khttp_head(&r, kresps[KRESP_STATUS], 
    "%s", khttps[KHTTP_200]);
  khttp_head(&r, kresps[KRESP_CONTENT_TYPE], 
    "%s", kmimetypes[r.mime]);
  khttp_body(&r);
  kjson_open(&req, &r);
  kjson_obj_open(&req);
  kjson_putstringp(&req, "greeting", "hello, world");
  kjson_obj_close(&req);
  kjson_close(&req);
  khttp_free(&r);
  return EXIT_SUCCESS;
}
