bin_PROGRAMS = \
    test-move \
    evg-chess

test_move_SOURCES = \
    test-move.vala \
	enums.vala \
    move.vala \
    position.vala \
	config.vapi

BUILT_SOURCES = evg-resources.c

evg_chess_SOURCES = \
    $(BUILT_SOURCES) \
    enums.vala \
    move.vala \
    position.vala \
    application.vala \
    window.vala \
    main.vala \
    config.vapi

resource_files = $(shell $(GLIB_COMPILE_RESOURCES) --generate-dependencies --sourcedir=$(top_srcdir)/data $(top_srcdir)/data/evg-chess.gresource.xml)
evg-resources.c: $(top_srcdir)/data/evg-chess.gresource.xml $(resource_files)
	$(AM_V_GEN) $(GLIB_COMPILE_RESOURCES) --target=$@ --sourcedir=$(top_srcdir)/data --generate-source $<

AM_LDFLAGS = \
    $(EVG_LIBS)

AM_CFLAGS = \
    $(EVG_CFLAGS) \
    -Wall

AM_CPPFLAGS = \
    -DGETTEXT_PACKAGE=\""$(GETTEXT_PACKAGE)"\" \
    -DEVGLOCALEDIR=\""$(localedir)"\"

AM_VALAFLAGS = \
    --target-glib 2.38 \
    --enable-experimental \
    --pkg gio-2.0 \
    --pkg gtk+-3.0 \
    --gresources  $(top_srcdir)/data/evg-chess.gresource.xml

EXTRA_DIST = \
    $(resource_files)

CLEANFILES = \
    $(patsubst %.vala,%.c,$(filter %.vala, $(SOURCES))) \
    *_vala.stamp

-include $(top_srcdir)/git.mk
