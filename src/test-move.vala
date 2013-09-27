using Evg;

void main (string[] args) {
    Intl.bindtextdomain (Config.GETTEXT_PACKAGE, Config.EVGLOCALEDIR);
    Intl.bind_textdomain_codeset (Config.GETTEXT_PACKAGE, "UTF-8");
    Intl.textdomain (Config.GETTEXT_PACKAGE);

    Gtk.init (ref args);

    Move move = Move ();
    move.set_piece (PieceType.WHITE_PAWN);
    move.set_from (SquareType.E2);
    move.set_to (SquareType.E4);
    
    stdout.printf ("Moving %s\n", move.get_piece ().to_string ());
    stdout.printf ("from %s to %s\n", move.get_from ().to_string (), 
                                      move.get_to ().to_string ());

    move.set_piece (PieceType.BLACK_KNIGHT);
    move.set_from (SquareType.G8);
    move.set_to (SquareType.F6);

    stdout.printf ("Moving %s\n", move.get_piece ().to_string ());
    stdout.printf ("from %s to %s\n", move.get_from ().to_string (), 
                                      move.get_to ().to_string ());

    stdout.printf ("color: %s\n", ColorType.BLACK.to_string ());
}
