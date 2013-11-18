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

public class MoveTests : Evg.TestCase {

    private Evg.Move? test_move;
    
    public MoveTests () {
        base ("Move");

        add_test ("[Move] type correctness", test_type_correctness);
        add_test ("[Move] getters and setters", test_get_set_methods);
        add_test ("[Move] generatrs", test_move_generators);
    }

    public override void set_up () {
        test_move = Evg.Move ();
	}

	public override void tear_down () {
		test_move = null;
	}

    public void test_type_correctness () {
        assert (test_move != null);

        assert (test_move.is_empty ());
    }

    public void test_get_set_methods () {
        test_move.set_piece (Evg.PieceType.WHITE_PAWN);
        assert (test_move.get_piece () == Evg.PieceType.WHITE_PAWN);

        test_move.set_from (Evg.SquareType.E2);
        test_move.set_to (Evg.SquareType.E4);
        assert (test_move.get_from () == Evg.SquareType.E2);
        assert (test_move.get_to () == Evg.SquareType.E4);
    }

    public void test_move_generators () {
    }
}
