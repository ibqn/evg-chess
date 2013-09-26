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

public enum SquareType {
    A1, B1, C1, D1, E1, F1, G1, H1,
    A2, B2, C2, D2, E2, F2, G2, H2,
    A3, B3, C3, D3, E3, F3, G3, H3,
    A4, B4, C4, D4, E4, F4, G4, H4,
    A5, B5, C5, D5, E5, F5, G5, H5,
    A6, B6, C6, D6, E6, F6, G6, H6,
    A7, B7, C7, D7, E7, F7, G7, H7,
    A8, B8, C8, D8, E8, F8, G8, H8;
    
    public string to_string () {
        return "%s%u".printf (("abcdefgh".get_char ((int)this % 8)).to_string (), (int)this / 8 + 1);
    }
}

public enum ColorType {
    BLACK,
    WHITE;
    
    public string to_string() {
        switch (this) {
            case BLACK:
                return ("Black");

            case WHITE:
                return ("White");

            default:
                assert_not_reached();
        }
    }
}

public enum PieceType {
    EMPTY,
    BLACK_PAWN,
    BLACK_KNIGHT,
    BLACK_BISHOP,
    BLACK_ROOK,
    BLACK_QUEEN,
    BLACK_KING,
    WHITE_PAWN,
    WHITE_KNIGHT,
    WHITE_BISHOP,
    WHITE_ROOK,
    WHITE_QUEEN,
    WHITE_KING;

    public string to_string () {
        EnumClass enumc = (EnumClass) typeof (PieceType).class_ref ();
        unowned EnumValue? eval = enumc.get_value (this);
        return_val_if_fail (eval != null, "");

        return eval.value_nick.replace ("-", " ");
    }
}

public enum Moveflags{
    ILLEGAL,
    REGULAR,
    CAPTURE,
    SHORT_CASTLE,
    LONG_CASTLE,
    WHITE,
    BLACK,
    PROMOTION,
    EN_PASSANT,
}

} // namespace Evg
