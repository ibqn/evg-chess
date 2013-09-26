bin_PROGRAMS = \
	test-move

test_move_SOURCES = \
    test-move.vala \
	enums.vala \
    move.vala \
    position.vala \
	config.vapi

AM_LDFLAGS = \
	$(EVG_LIBS)

AM_CFLAGS = \
	$(EVG_CFLAGS) \
	-Wall

AM_CPPFLAGS = \
    -DGETTEXT_PACKAGE=\""$(GETTEXT_PACKAGE)"\"


AM_VALAFLAGS = \
    --target-glib=2.38 \
    --enable-experimental 
    
CLEANFILES = \
	$(patsubst %.vala,%.c,$(filter %.vala, $(SOURCES))) \
	*_vala.stamp

-include $(top_srcdir)/git.mk
