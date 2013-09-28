pieces_themes_files = \
    pieces/classic/bb.svg \
    pieces/classic/bn.svg \
    pieces/classic/bq.svg \
    pieces/classic/wb.svg \
    pieces/classic/wn.svg \
    pieces/classic/wq.svg \
    pieces/classic/bk.svg \
    pieces/classic/bp.svg \
    pieces/classic/br.svg \
    pieces/classic/wk.svg \
    pieces/classic/wp.svg \
    pieces/classic/wr.svg \
    $(NULL)

EXTRA_DIST = \
    $(pieces_themes_files) \
    evg-chess.gresource.xml

install-icons:
	for icon in $(pieces_themes_files); do \
		THEME=`echo $$icon | cut -d/ -f2`; \
		ICONFILE=`echo $$icon | cut -d/ -f3`; \
		mkdir -p $(DESTDIR)$(datadir)/evg-chess/pieces/$$THEME; \
		$(INSTALL_DATA) $(srcdir)/$$icon $(DESTDIR)$(datadir)/evg-chess/pieces/$$THEME/$$ICONFILE; \
	done

uninstall-icons:
	-for icon in $(public_icons); do \
		THEME=`echo $$icon | cut -d/ -f2`; \
		ICONFILE=`echo $$icon | cut -d/ -f3`; \
		rm -f $(DESTDIR)$(datadir)/evg-chess/pieces/$$THEME/$$ICONFILE; \
	done

install-data-local: install-icons
uninstall-local: uninstall-icons


-include $(top_srcdir)/git.mk
