#if defined(__linux__)
# define _GNU_SOURCE /* memmem */
#endif
#if defined(__NetBSD__)
# define _OPENBSD_SOURCE /* reallocarray */
#endif
#if defined(__sun)
# ifndef _XOPEN_SOURCE /* SunOS already defines this */
#  define _XOPEN_SOURCE /* IllumOS for XPGx */
# endif
# define _XOPEN_SOURCE_EXTENDED 1 /* XPG4v2 */
# ifndef __EXTENSIONS__ /* SunOS already defines this */
#  define __EXTENSIONS__ /* reallocarray */
# endif
#endif

int
main(void)
{
	char	*tmp;
	size_t	 nm = 100, sz = 100;
#if defined(__linux__)
	/* FIXME: multiplication overflow test */
	tmp = realloc(NULL, nm * sz);
#else
	tmp = reallocarray(NULL, nm, sz);
#endif
	return memmem(tmp, nm * sz, "foo", 3) == NULL;
}
