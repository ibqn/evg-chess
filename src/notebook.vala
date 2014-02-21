 /*
  * Copyright (c) 2014 Evgeny Bobkin <evgen.ibqn@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  *
  * This program is distributed in the hope that it will be useful, but
  * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
  * for more details.
  *
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, write to the Free Software Foundation,
  * Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */

namespace Evg {
    class Tab : Object {
        private Gtk.Widget context;

        public Tab (Gtk.Widget widget) {
            context = widget;
        }

        public Gtk.Widget get_context () {
            return context;
        }
    }

    public class Notebook : Gtk.Notebook {
        private uint tab_num;

        construct {
            tab_num = 0;

            set_show_border (false);
            set_scrollable (true);
        
            page_removed.connect ((child, page_num) => {
                set_show_tabs (get_n_pages () > 1);
                tab_num --;
            });

            page_added.connect ((child, page_num) => {
                set_show_tabs (get_n_pages () > 1);
                tab_num ++;
                set_current_page (-1);
                // tab borders are drawn only if tabs are reorderble
                set_tab_reorderable (child, true);
            });
        }

        public int insert_tab (Gtk.Widget widget, int position) {
            var tab = new Tab (widget);
            var tab_label = new TabLabel (tab);
            tab_label.set_title ("Board %u".printf (tab_num));
            // should be visible, otherwise the tab will not be displayed
            widget.show_all ();

            tab_label.close_clicked.connect ((tab) => {
                var page = tab.get_context ();
                int num = page_num (page);
                remove_page (num);
            });

            return insert_page (widget, tab_label, position);
        }
    }

    [GtkTemplate (ui = "/org/evg/chess/ui/tab-label.ui")]
    class TabLabel : Gtk.Box {
        [GtkChild]
        private CloseButton close_button;
        [GtkChild]
        private Gtk.Label label;    
        private Tab context;

        public signal void close_clicked (Tab context);

        public TabLabel (Tab widget) {
            context = widget;
        }

        public void set_title (string title) {
            label.set_text (title);
        }

        construct {
            close_button.clicked.connect (() => {
                close_clicked (context); 
            });
        }
    }

    [GtkTemplate (ui = "/org/evg/chess/ui/close-button.ui")]
    class CloseButton : Gtk.Button {
        construct {
            var css_provider = new Gtk.CssProvider ();
            try {
                var file = File.new_for_uri ("resource:///org/evg/chess/css/close-button.css");
                css_provider.load_from_file (file);
            } catch (Error e) {
                warning ("loading css: %s", e.message);
            }
            get_style_context ().add_provider (css_provider,
                                               Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        }
    }
}
