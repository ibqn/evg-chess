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

namespace Evg {

public interface Position {
    public void set_startup () {
    }

    public abstract void set_empty ();

    public abstract void add_piece (PieceType piece, SquareType square);

    public void remove_piece (SquareType square) {
        add_piece (PieceType.EMPTY, square);
    }

    public void move_piece (SquareType from, SquareType to) {
        add_piece (get_piece (from), to);
        remove_piece (from);
    }

    public PieceType get_piece (SquareType square) {
        return PieceType.EMPTY;
    }

    public abstract Position copy ();
}

public class ChessPosition : Object, Position  {
    private const int SQUARES = 64;

    private PieceType[] board;

    public ChessPosition () {
        board = new PieceType[SQUARES];
    }

    public void set_empty () {
        for (int i = 0; i < SQUARES; i ++) {
            board[i] = PieceType.EMPTY;
        }
    }

    public void add_piece (PieceType piece, SquareType square) {
        board[(int)square] = piece;
    }

    public Position copy () {
        var position = new ChessPosition ();

        for (int i = 0; i < SQUARES; i ++) {
            position.add_piece (board[i], (SquareType) i);
        }

        return position;
    }
}

} // namespace Evg
