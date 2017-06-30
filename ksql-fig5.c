int
main(void)
{
	struct kreq r;
	const char *pages = "index";

	if (KCGI_OK != khttp_parse(&r, NULL, 0, &pages, 1, 0))
		errx(EXIT_FAILURE, "khttp_parse");

	if (NULL == (r.arg = db_open("/data/foo.db")))
		errx(EXIT_FAILURE, "db_open");

	if (-1 == pledge("stdio", NULL))
		err(EXIT_FAILURE, "pledge");

	/* Perform actions. */

	db_close(r.arg);
	khttp_free(&r);
	return(EXIT_SUCCESS);
}
