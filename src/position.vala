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

public interface Position : Object {
    public abstract void set_init ();

    public abstract void set_empty ();

    public abstract void add_piece (PieceType piece, SquareType square);

    public virtual void remove_piece (SquareType square) {
        add_piece (PieceType.EMPTY, square);
    }

    public abstract void apply (Evg.Move move);

    public abstract void undo (Evg.Move move);

    public virtual void move_piece (SquareType from, SquareType to) {
        add_piece (get_piece (from), to);
        remove_piece (from);
    }

    public virtual PieceType get_piece (SquareType square) {
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

    public PieceType get_piece (SquareType square) {
        return board[(int)square];
    }

    public void set_init () {
        board[(int)Evg.SquareType.A1] = Evg.PieceType.WHITE_ROOK;
        board[(int)Evg.SquareType.B1] = Evg.PieceType.WHITE_KNIGHT;
        board[(int)Evg.SquareType.C1] = Evg.PieceType.WHITE_BISHOP;
        board[(int)Evg.SquareType.D1] = Evg.PieceType.WHITE_QUEEN;
        board[(int)Evg.SquareType.E1] = Evg.PieceType.WHITE_KING;
        board[(int)Evg.SquareType.F1] = Evg.PieceType.WHITE_BISHOP;
        board[(int)Evg.SquareType.G1] = Evg.PieceType.WHITE_KNIGHT;
        board[(int)Evg.SquareType.H1] = Evg.PieceType.WHITE_ROOK;

        for (int i = (int)Evg.SquareType.A2; i <= (int)Evg.SquareType.H2; i ++) {
            board[i] = Evg.PieceType.WHITE_PAWN;
        }

        board[(int)Evg.SquareType.A8] = Evg.PieceType.BLACK_ROOK;
        board[(int)Evg.SquareType.B8] = Evg.PieceType.BLACK_KNIGHT;
        board[(int)Evg.SquareType.C8] = Evg.PieceType.BLACK_BISHOP;
        board[(int)Evg.SquareType.D8] = Evg.PieceType.BLACK_QUEEN;
        board[(int)Evg.SquareType.E8] = Evg.PieceType.BLACK_KING;
        board[(int)Evg.SquareType.F8] = Evg.PieceType.BLACK_BISHOP;
        board[(int)Evg.SquareType.G8] = Evg.PieceType.BLACK_KNIGHT;
        board[(int)Evg.SquareType.H8] = Evg.PieceType.BLACK_ROOK;

        for (int i = (int)Evg.SquareType.A7; i <= (int)Evg.SquareType.H7; i ++) {
            board[i] = Evg.PieceType.BLACK_PAWN;
        }
    }

    public void apply (Evg.Move move) {
    }

    public void undo (Evg.Move move) {
    }
}

} // namespace Evg
