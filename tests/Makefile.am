include $(top_srcdir)/Makefile.decl

noinst_PROGRAMS = $(TEST_PROGS)

TEST_PROGS += tests

tests_SOURCES = \
    testcase.vala \
    testmain.vala \
    testmove.vala \
    $(NULL)

tests_DEPENDENCIES = \
    $(top_srcdir)/src/evg-1.0.vapi \
    $(NULL)

tests_VALAFLAGS = \
    --basedir $(top_srcdir) \
    --vapidir $(top_srcdir)/src \
    --pkg evg-1.0 \
    --pkg posix \
    $(VALAFLAGS) \
    $(NULL)

tests_CPPFLAGS = \
    -I$(top_srcdir)/src \
    $(LIBEVG_CFLAGS) \
    $(NULL)

tests_LDADD = \
    $(LIBEVG_LIBS) $(top_srcdir)/src/libevg-1.la \
    $(NULL)

-include $(top_srcdir)/git.mk
