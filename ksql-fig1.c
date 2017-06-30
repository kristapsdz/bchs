/*
 * Required to create database temporary files, read and write from
 * them, and perform file-system operations (flock and fattr).
 */

if (pledge("stdio rpath cpath wpath flock fattr", NULL) == -1)
	err(EXIT_FAILURE, "pledge");
