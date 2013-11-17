include $(top_srcdir)/Makefile.decl

ACLOCAL_AMFLAGS = ${ACLOCAL_FLAGS} -I m4

SUBDIRS = data po src tests

MAINTAINERCLEANFILES = \
    $(GITIGNORE_MAINTAINERCLEANFILES_TOPLEVEL) \
    $(GITIGNORE_MAINTAINERCLEANFILES_MAKEFILE_IN) \
    ABOUT-NLS \
	config.rpath \
	m4 \
	$(VALA_SOURCES:.vala=.c) \
	*.stamp \
	*~ \
	*/*~ \
	*/*/*~

-include $(top_srcdir)/git.mk
