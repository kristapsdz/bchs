#include <err.h>
#include <stdint.h>
#include <stdlib.h>
#include <kcgi.h>

int 
main(void) 
{
	struct kreq r;
	const char *page = "index";

	if (KCGI_OK != khttp_parse(&r, NULL, 0, &page, 1, 0))
		errx(EXIT_FAILURE, "khttp_parse");

	if (-1 == pledge("stdio", NULL)) 
		err(EXIT_FAILURE, "pledge");

	khttp_head(&r, kresps[KRESP_STATUS], 
		"%s", khttps[KHTTP_200]);
	khttp_head(&r, kresps[KRESP_CONTENT_TYPE], 
		"%s", kmimetypes[r.mime]);
	khttp_body(&r);
	khttp_puts(&r, "Hello, haters!\n");

	khttp_free(&r);
	return(EXIT_SUCCESS);
}
