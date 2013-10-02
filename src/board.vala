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

public class Evg.Board : Gtk.DrawingArea {
    private Position? position;

    private Cairo.ImageSurface temp_surface;
    private int surface_size;

    private double board_size; 
    private double square_size;
    private double x_origin;
    private double y_origin;
    private int width;
    private int height;

    private double ratio;

    private bool flip_board;
    private int selected_square;

    public Board () {
        set_size_request (200, 200);
        add_events (Gdk.EventMask.BUTTON_PRESS_MASK | Gdk.EventMask.SCROLL_MASK);

        surface_size = 100;
		temp_surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 12 * surface_size, surface_size);

        string file = "%s%s.svg";
        string folder = Path.build_path (Path.DIR_SEPARATOR_S, Config.EVGDATADIR, "evg-chess", "pieces", "classic");
        string[] color = { "b", "w" };
        string[] piece = { "p", "n", "b", "r", "q", "k" };

        for( int c = 0; c < 2; c ++ ) {
            for(int p = 0; p < 6; p ++ ) {
                string path = Path.build_path (Path.DIR_SEPARATOR_S, folder, file.printf (color[c], piece[p]));
                render_piece (path, 6 * c + p);
            }
        }

        position = null;
        position = new ChessPosition ();
        //position.set_init ();
        position.add_piece (PieceType.BLACK_PAWN, SquareType.A2);

        flip_board = false;
        selected_square = -1;
    }

    private void render_piece (string file_name, int offset) {
        Rsvg.Handle handle;
        try {
            handle = new Rsvg.Handle.from_file (file_name);			
        } catch( Error e ) {
            error ("Can not open svg file: %s", e.message);
        }

        var temp_cr = new Cairo.Context (temp_surface);
        temp_cr.save ();
        temp_cr.translate (surface_size * offset, 0);
        temp_cr.scale ((double)surface_size / handle.width,
                       (double)surface_size / handle.height);
        handle.render_cairo (temp_cr);
        temp_cr.restore ();
    }

    public override bool configure_event (Gdk.EventConfigure event) {
        width  = get_allocated_width ();
        height = get_allocated_height ();

        board_size = (double)(int.min (width, height));
		square_size = board_size / 8.0;

		ratio = square_size / surface_size;

		x_origin = 0.0;
		y_origin = ((double)height - board_size) / 2.0;

        return true;
    }

    public override bool draw (Cairo.Context cr) {
        cr.set_source_rgb (0.0, 0.0, 0.0);
        cr.rectangle (x_origin, y_origin, board_size, board_size);
        cr.fill ();

        int square;
        double sx, sy;
        for (int rank = 0; rank < 8; rank ++) {
            for (int file = 0; file < 8; file ++) {
                sx = x_origin + file * square_size;
                sy = y_origin + rank * square_size;

                cr.rectangle (sx, sy, square_size, square_size);

                if ((file + rank) % 2 == 0) {
                    cr.set_source_rgb (0xee/255.0, 0xee/255.0, 0xec/255.0);
                } else {
                    cr.set_source_rgb (0xba/255.0, 0xbd/255.0, 0xb6/255.0);
                }
                cr.fill ();

                if (flip_board) {
                    square = (7 - file) + 8 * rank;
                } else {
                    square = file + 8 * (7 - rank);
                }

                int p = (int) position.get_piece ((SquareType)square);

                if (p != 0) {
                    cr.save ();
                    cr.translate (sx, sy);
                    cr.scale (ratio, ratio);	
                    cr.set_source_surface (temp_surface, -(p - 1) * surface_size, 0);
                    cr.rectangle (0, 0, surface_size, surface_size);
                    cr.clip ();
                    cr.paint ();
                    cr.restore ();
                }
            }
        }

        return true;
    }

    public override bool button_press_event (Gdk.EventButton event) {
        if ((x_origin > event.x) || (event.x > (x_origin + board_size)) ||
            (y_origin > event.y) || (event.y > (y_origin + board_size))) {
            return false;
        }

        int file = (int)((event.x - x_origin) / square_size);
        int rank = (int)((event.y - y_origin) / square_size);
        int square;

        if (flip_board) {
            square = (7 - file) + 8 * rank;
        } else {
            square = file + 8 * (7 - rank);
        }

        if (selected_square != -1) {
            position.move_piece ((SquareType)selected_square, (SquareType)square);
            queue_draw ();

            selected_square = -1;
        } else {
            selected_square = square;
        }

        if (event.button == 1) {
        } else if (event.button == 3) {
        } else {
            return false;
        }

        return true;
    }
}

