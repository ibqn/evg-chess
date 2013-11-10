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

protected enum Evg.NodeType {
    COMMENT,
    MOVE,
    TIME,
    VARIATION,
}

protected class Evg.Node {
    public NodeType type;
    public Node? next;
    public weak Node? prev;

    private Node () {
        next = null;
        prev = null;
    }
}

protected class Evg.CommentNode : Evg.Node {
    public string comment;

    public CommentNode (string comment) {
        base ();

        type = Evg.NodeType.COMMENT;
        this.comment = comment;
    }
}

protected class Evg.MoveNode : Evg.Node {
    public Evg.Move move;

    public MoveNode (Evg.Move move) {
        base ();

        type = NodeType.MOVE;
        this.move = move;
    }
}

public struct Evg.GameIter {
    public Evg.Node current;
    public int64 time_stamp;

    public GameIter () {
        current = null;
        time_stamp = 0;
    }
}

public class Evg.GameStore : Object {
    private Evg.Node? first;
    private Evg.Node? last;
    private int64 time_stamp;

    public GameStore () {
        first = null;
        last = null;

        time_stamp = new DateTime.now_utc ().to_unix ();
    }

    private void add_node (Evg.Node node) {
        if (last != null) {
            node.prev = last;
            last.next = node;
            last = node;
        } else {
            first = last = node;
        }
    }

    public void add_move (Evg.Move move) {
        Evg.Node move_node = new Evg.MoveNode (move);
        add_node (move_node);
    }

    public void add_comment (string comment) {
        Evg.Node comment_node = new Evg.CommentNode (comment);
        add_node (comment_node);
    }

    public bool has_next_move (Evg.GameIter iter) {
        Evg.Node next_node = iter.current.next;

        while (next_node != null) {
            if (next_node.type == Evg.NodeType.MOVE) {
                return true;
            }

            next_node = next_node.next;
        }

        return false;
    }

    public bool has_prev_move (Evg.GameIter iter) {
        Evg.Node prev_node = iter.current.prev;

        while (prev_node != null) {
            if (prev_node.type == Evg.NodeType.MOVE) {
                return true;
            }

            prev_node = prev_node.prev;
        }

        return false;
    }

    public bool prev_move (out Evg.GameIter iter) {
        Evg.Node prev_node = iter.current.prev;

        while (prev_node != null) {
            if (prev_node.type == Evg.NodeType.MOVE) {
                iter.current = prev_node;
                return true;
            }

            prev_node = prev_node.prev;
        }

        return false;
    }

    public bool next_move (out Evg.GameIter iter) {
        Evg.Node next_node = iter.current.next;

        while (next_node != null) {
            if (next_node.type == Evg.NodeType.MOVE) {
                iter.current = next_node;
                return true;
            }

            next_node = next_node.next;
        }

        return false;
    }

    public Evg.Move? get_move (Evg.GameIter iter) {
        if (iter.current.type == Evg.NodeType.MOVE) {
            return ((Evg.MoveNode) iter.current).move;
        }

        return null;
    }

    public bool init_iter_first (out Evg.GameIter iter) {
        if (first == null) {
            return false;
        }

        iter.current = first;
        iter.time_stamp = time_stamp;
        return true;
    }

    public bool is_valid_iter (Evg.GameIter iter) {
        if (iter.time_stamp == time_stamp) {
            return true;
        }

        return false;
    }
}