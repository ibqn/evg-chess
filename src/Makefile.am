include $(top_srcdir)/Makefile.decl

lib_LTLIBRARIES = \
	libevg-@EVG_API_MAJOR_VERSION@.la \
	$(NULL)

libevg_@EVG_API_MAJOR_VERSION@_la_SOURCES = \
    enums.vala \
    move.vala \
    game.vala \
    game-store.vala \
    position.vala \
	config.vapi \
    $(NULL)

libevg_@EVG_API_MAJOR_VERSION@_la_VALAFLAGS = \
    --target-glib 2.38 \
	-H evg.h --vapi evg-@EVG_API_VERSION@.vapi \
	-h evg-internals.h \
	--internal-vapi evg-internals-@EVG_API_VERSION@.vapi \
	--library evg-@EVG_API_VERSION@ --gir Evg-@EVG_API_VERSION@.gir \
	--pkg gio-2.0 \
	$(VALAFLAGS) \
	$(NULL)

libevg_@EVG_API_MAJOR_VERSION@_la_CPPFLAGS = \
	$(LIBEVG_CFLAGS) \
	-DGETTEXT_PACKAGE=\""$(GETTEXT_PACKAGE)"\" \
    -DEVGLOCALEDIR=\""$(localedir)"\" \
    -DEVGDATADIR=\""$(datadir)"\" \
	$(NULL)

libevg_@EVG_API_MAJOR_VERSION@_la_LIBADD = \
	$(LIBEVG_LIBS) \
	$(NULL)

libevg_@EVG_API_MAJOR_VERSION@_la_LDFLAGS = \
	-version-info $(LIBEVG_LT_VERSION) \
	-no-undefined \
	$(NULL)

evgincludedir = $(includedir)/evg-@EVG_API_VERSION@

evginclude_HEADERS = \
	evg.h \
	$(NULL)

vapidir = $(datadir)/vala/vapi

dist_vapi_DATA = \
	evg-@EVG_API_VERSION@.vapi \
	$(NULL)

if HAVE_INTROSPECTION
girdir = @INTROSPECTION_GIRDIR@

gir_DATA = \
	Evg-@EVG_API_VERSION@.gir \
	$(NULL)

typelibdir = @INTROSPECTION_TYPELIBDIR@

typelib_DATA = \
	Evg-@EVG_API_VERSION@.typelib \
	$(NULL)

# Extract dlname from libfolks.la; see bug #658002.
# This is what g-ir-scanner does.
libevg_dlname = \
	`$(SED) -nE "s/^dlname='([A-Za-z0-9.+-]+)'/\1/p" libevg-@EVG_API_MAJOR_VERSION@.la` \
	$(NULL)

INTROSPECTION_COMPILER_ARGS= \
	-l $(libevg_dlname) \
	$(NULL)

Evg-@EVG_API_VERSION@.typelib: Evg-@EVG_API_VERSION@.gir
	@INTROSPECTION_COMPILER@ $(INTROSPECTION_COMPILER_ARGS) -o $@ $^
endif

Evg-@EVG_API_VERSION@.gir evg-internals-@EVG_API_VERSION@.vapi evg-@EVG_API_VERSION@.vapi: libevg-@EVG_API_MAJOR_VERSION@.la

bin_PROGRAMS = \
    evg-chess \
    $(NULL)

test_move_SOURCES = \
    test-move.vala \
	enums.vala \
    move.vala \
    position.vala \
    game.vala \
    game-store.vala \
	config.vapi \
	$(NULL)

evg_chess_BUILT_SOURCES = evg-resources.c

evg_chess_VALA_SOURCES = \
    application.vala \
    window.vala \
    board.vala \
    main.vala \
    $(NULL)

evg_chess_SOURCES = \
    $(evg_chess_BUILT_SOURCES) \
    $(evg_chess_VALA_SOURCES) \
    evg-@EVG_API_VERSION@.vapi \
    config.vapi \
    $(NULL)

resource_files = $(shell $(GLIB_COMPILE_RESOURCES) --generate-dependencies --sourcedir=$(top_srcdir)/data $(top_srcdir)/data/evg-chess.gresource.xml)
evg-resources.c: $(top_srcdir)/data/evg-chess.gresource.xml $(resource_files)
	$(AM_V_GEN) $(GLIB_COMPILE_RESOURCES) --target=$@ --sourcedir=$(top_srcdir)/data --generate-source $<

evg_chess_LDFLAGS = \
    $(EVG_LIBS) \
    $(NULL)

evg_chess_CFLAGS = \
    $(EVG_CFLAGS) \
    $(LIBEVG_CFLAGS) \
    -Wall \
    $(NULL)

evg_chess_LDADD = \
    $(LIBEVG_LIBS) \
    $(srcdir)/libevg-@EVG_API_MAJOR_VERSION@.la \
    $(NULL)

evg_chess_CPPFLAGS = \
    -I$(top_srcdir)/src \
    -DGETTEXT_PACKAGE=\""$(GETTEXT_PACKAGE)"\" \
    -DEVGLOCALEDIR=\""$(localedir)"\" \
    -DEVGDATADIR=\""$(datadir)"\" \
    $(NULL)

AM_VALAFLAGS = \
    --target-glib 2.38 \
    --enable-experimental \
    --pkg gio-2.0 \
    --pkg gtk+-3.0 \
    --pkg librsvg-2.0 \
    --gresources  $(top_srcdir)/data/evg-chess.gresource.xml \
    $(NULL)

EXTRA_DIST = \
    $(resource_files) \
    $(NULL)

CLEANFILES = \
    $(patsubst %.vala,%.c,$(filter %.vala, $(SOURCES))) \
    *_vala.stamp \
    $(NULL)

-include $(top_srcdir)/git.mk
