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

public class Evg.Application : Gtk.Application {
    private static bool print_version;
    private const OptionEntry[] option_entries = {
        { "version", 'v', 0, OptionArg.NONE, ref print_version, N_("Print version information and exit"), null },
        { null },
    };

    private Window? window;

    public Application  () {
        Object (application_id: "org.evg.chess");

        window = null;
    }

    protected override void activate () {
        if (window == null) {
            window = new Window (this);
        }
        window.present ();
    }

    protected override bool local_command_line ([CCode (array_length = false, array_null_terminated = true)] ref unowned string[] arguments, out int exit_status) {
        var option_context = new OptionContext (_("- Evg Chess App"));

        option_context.add_main_entries (option_entries, Config.GETTEXT_PACKAGE);
        option_context.add_group (Gtk.get_option_group (true));

        // Workaround related to bug report https://bugzilla.gnome.org/show_bug.cgi?id=642885
        unowned string[] args = arguments;

        try {
            option_context.parse (ref args);
        } catch (OptionError e) {
            message ("Parsing of option arguments failed due to: \"%s\"", e.message);
            exit_status = 1;
            return true;
        }

        if (print_version) {
            print ("%s %s\n", Environment.get_application_name (), Config.PACKAGE_VERSION);
            exit_status = 0;
            return true;
        }

        return base.local_command_line (ref arguments, out exit_status);
    }
}

