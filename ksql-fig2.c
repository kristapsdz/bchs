if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd) == -1)
	err(EXIT_FAILURE, "socketpair");

if ((pid = fork()) == -1)
	err(EXIT_FAILURE, "fork");

if (pid == 0) {
	close(fd[1]);
	/*
	 * Required to create database temporary files, read and write
	 * from them, and perform file-system operations (flock and
	 * fattr).
	 */
	if (pledge("stdio rpath cpath wpath flock fattr", NULL) == -1)
		err(EXIT_FAILURE, "pledge");
	/* Exchange data with master over fd[0]. */
	exit(EXIT_SUCCESS);
}

close(fd[0]);
/* Exchange data with database over fd[1]. */
if (pledge("stdio", NULL) == -1)
	err(EXIT_FAILURE, "pledge");
