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
  * with this program; if not, write to the Free Software Foundation,
  * Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */

public class Evg.Application : Gtk.Application {
    private const OptionEntry[] option_entries = {
        { "version", 'v', 0, OptionArg.NONE, null, N_("Print version information and exit"), null },
        { null },
    };

    private Window? window;

    public Application  () {
        Object (application_id: "org.evg.chess");

        add_main_option_entries (option_entries);

        window = null;
    }

    protected override void activate () {
        if (window == null) {
            window = new Window (this);
        }
        window.present ();
    }

    protected override void startup () {
        base.startup ();

        var css_provider = new Gtk.CssProvider ();
            try {
                var file = File.new_for_uri ("resource:///org/evg/chess/css/evg-chess.css");
                css_provider.load_from_file (file);
            } catch (Error e) {
                warning ("loading css: %s", e.message);
            }
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (),
                                                      css_provider,
                                                      Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
    }

    protected override int handle_local_options (GLib.VariantDict options) {
        if (options.contains ("version")) {
            print ("%s %s\n", Environment.get_application_name (), Config.PACKAGE_VERSION);
            return 0;
        }

        return -1;
    }
}

