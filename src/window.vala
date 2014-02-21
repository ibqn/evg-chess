 /*
  * Copyright (c) 2013 Evgeny Bobkin <evgen.ibqn@gmail.com>
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
  * with GNOME Maps; if not, write to the Free Software Foundation,
  * Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */

[GtkTemplate (ui = "/org/evg/chess/ui/window.ui")]
public class Evg.Window : Gtk.ApplicationWindow {
    [GtkChild]
    private Evg.Notebook notebook;
    private const GLib.ActionEntry[] action_entries = {
        { "new-tab", new_tab_callback },
    };

    public Window (Application app) {
        Object (application: app);

        add_action_entries (action_entries, this);

        new_tab_callback ();

        show_all ();
    }

    private void new_tab_callback () {
        var board = new Evg.Board ();
        notebook.insert_tab (board, -1);
    }
}

