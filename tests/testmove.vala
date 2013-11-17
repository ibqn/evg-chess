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
    }

    public override void set_up () {
        test_move = Evg.Move ();
	}

	public override void tear_down () {
		test_move = null;
	}

    public void test_type_correctness () {
    }
}
