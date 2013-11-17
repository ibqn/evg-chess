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

public interface Evg.Game : Object {
}

public class Evg.ChessGame : Object, Evg.Game {
    private Evg.Position position;
    private Evg.GameStore game_store;
    private int ply;
    private Evg.GameIter iter;

    public ChessGame () {
        ply = 0;

        position = new Evg.ChessPosition ();
        game_store = new Evg.GameStore ();
    }

    public Evg.Position get_position () {
        return position;
    }
}
