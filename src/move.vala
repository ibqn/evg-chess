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

private enum MoveMask {
    FROM         = 63,
    TO           = 4032,
    PIECE        = 61440,
    IS_CASTLE    = 65536,
    IS_PROMOTION = 131072,
    IS_CAPTURE   = 262144,
    CAPTURE      = 7864320,
}

private enum MoveShift {
    TO           = 6,
    PIECE        = 12,
    IS_CASTLE    = 16,
    IS_PROMOTION = 17,
    IS_CAPTURE   = 18,
    CAPTURE      = 19,
}

/*
 * The move definition bitfield layout of "move_data":
 * 00000000 00000000 00000000 00111111 = from square     = bits 1-6
 * 00000000 00000000 00001111 11000000 = to square       = bits 7-12
 * 00000000 00000000 11110000 00000000 = piece type      = bits 13-16
 * 00000000 00000001 00000000 00000000 = castle          = bit  17
 * 00000000 00000010 00000000 00000000 = promotion       = bit  18
 * 00000000 00000100 00000000 00000000 = capture         = bit  19
 * 00000000 01111000 00000000 00000000 = capture piece   = bits 20-23
 * 00000000 10000000 00000000 00000000 = en passant      = bit  24
 * 00001111 00000000 00000000 00000000 = promotion piece = bits 25-28
 */

public struct Move {
    private uint32 move_data;

    public Move () {
        clear ();
    }

    public void clear () {
        move_data = 0;
    }

    public bool is_empty () {
        return move_data == 0;
    }

    public void set_from (SquareType square) {
        assert (square <= SquareType.H8);
        assert (SquareType.A1 <= square);
        
        move_data &= (~MoveMask.FROM);
        move_data |= square;
    }

    public SquareType get_from () {
        return (SquareType)(move_data & MoveMask.FROM);
    }

    public void set_to (SquareType square) {
        assert (square >= SquareType.A1);
        assert (square <= SquareType.H8);

        move_data &= (~MoveMask.TO);
        move_data |= (square << MoveShift.TO);
    }

    public SquareType get_to () {
        return (SquareType)((move_data & MoveMask.TO) >> MoveShift.TO);
    }

    public void set_piece (PieceType piece) {
        assert (piece >= PieceType.EMPTY);
        assert (piece <= PieceType.WHITE_KING);

        move_data &= (~MoveMask.PIECE);
        move_data |= (piece << MoveShift.PIECE);
    }

    public PieceType get_piece () {
        return (PieceType)((move_data & MoveMask.PIECE) >> MoveShift.PIECE);
    }
    
    public void set_capture (PieceType piece) {
        assert (piece >= PieceType.EMPTY);
        assert (piece <= PieceType.WHITE_KING);

        move_data &= (~MoveMask.CAPTURE);
        move_data |= (piece << MoveShift.CAPTURE);
    }

    public PieceType get_capture () {
        return (PieceType)((move_data & MoveMask.CAPTURE) >> MoveShift.CAPTURE);
    }

    public bool is_capture () {
        return (move_data & MoveMask.IS_CAPTURE) == MoveMask.IS_CAPTURE;
    }

    public bool is_castle () {
        return (move_data & MoveMask.IS_CASTLE) == MoveMask.IS_CASTLE;
    }

    public bool is_promotion () {
        return (move_data & MoveMask.IS_PROMOTION) == MoveMask.IS_PROMOTION;
    }
}

} // namespace Evg
