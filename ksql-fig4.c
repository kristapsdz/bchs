int
main(void)
{
	struct ksql	*sql;
	struct ksqlstmt	*stmt;
	size_t		 i;
	char		 buf[64];
	uint32_t	 val;

	if ((sql = ksql_alloc_child(NULL, NULL, NULL)) == NULL)
		errx(EXIT_FAILURE, "ksql_alloc_child");

	if (pledge("stdio", NULL) == -1)
		err(EXIT_FAILURE, "pledge");

	ksql_open(sql, "test.db");

	ksql_stmt_alloc(sql, &stmt, "INSERT INTO "
		"test (foo,bar) VALUES (?,?)", 1);
	for (i = 0; i < 10; i++) {
		val = arc4random();
		snprintf(buf, sizeof(buf), "%" PRIu32, val);
		ksql_bind_int(stmt, 0, val);
		ksql_bind_str(stmt, 1, buf);
		ksql_stmt_step(stmt);
		ksql_stmt_reset(stmt);
	}
	ksql_stmt_free(stmt);
	ksql_close(sql);
	ksql_free(sql);

	return EXIT_SUCCESS;
}
