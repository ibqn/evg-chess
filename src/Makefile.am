bin_PROGRAMS = \
	test_move

test_move_SOURCES = \
    test_move.vala \
	enums.vala \
    move.vala \
    position.vala \
	config.vapi

AM_LDFLAGS = \
	$(EVG_LIBS)

AM_CFLAGS = \
	$(EVG_CFLAGS) \
	-Wall

AM_CPPFLAGS = 


AM_VALAFLAGS = \
    --target-glib=2.38 \
    --enable-experimental 
    
CLEANFILES = \
	$(patsubst %.vala,%.c,$(filter %.vala, $(SOURCES))) \
	*_vala.stamp

-include $(top_srcdir)/git.mk
