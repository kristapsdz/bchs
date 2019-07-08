int
main(void)
{
	struct kreq r;
	const char *pages = "index";

	if (khttp_parse(&r, NULL, 0, &pages, 1, 0) != KCGI_OK)
		errx(EXIT_FAILURE, "khttp_parse");

	if ((r.arg = db_open("/data/foo.db")) == NULL)
		errx(EXIT_FAILURE, "db_open");

	if (pledge("stdio", NULL) == -1)
		err(EXIT_FAILURE, "pledge");

	/* Perform actions in a sandbox. */

	db_close(r.arg);
	khttp_free(&r);
	return EXIT_SUCCESS;
}
