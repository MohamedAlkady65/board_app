import 'package:board_app/algorithm/node.dart';
import 'package:board_app/algorithm/paths.dart';

class Board {
  late List<List<Node>> nodes;
  int Size;
  Node? StartNode;
  Node? EndNode;

  Board({required this.Size}) {
    nodes = List<List<Node>>.generate(
        Size,
        (inRow) => List<Node>.generate(
            Size, (inCell) => Node(index: ((inRow * Size) + inCell))));

    for (int i = 0; i < Size; i++) {
      for (int j = 0; j < Size - 1; j++) {
        nodes[i][j].right = nodes[i][j + 1];
        nodes[i][j + 1].left = nodes[i][j];
      }
    }

    for (int i = 0; i < Size - 1; i++) {
      for (int j = 0; j < Size; j++) {
        nodes[i][j].down = nodes[i + 1][j];
        nodes[i + 1][j].up = nodes[i][j];
      }
    }
  }

  bool AddWall(Node one, Node two) {
    if (one.left == two) {
      one.left = null;
      two.right = null;
      return true;
    } else if (one.right == two) {
      one.right = null;
      two.left = null;
      return true;
    } else if (one.up == two) {
      one.up = null;
      two.down = null;
      return true;
    } else if (one.down == two) {
      one.down = null;
      two.up = null;
      return true;
    } else {
      return false;
    }
  }

  List<Node>? FindPath() {
    return _GetPath(StartNode);
  }

  List<Node>? _GetPath(Node? cur) {
    if (cur == null || cur.state == false) {
      return null;
    }

    if (cur == EndNode) {
      return [cur];
    }

    Paths paths = Paths();

    cur.state = false;

    paths.right = _GetPath(cur.right);
    paths.left = _GetPath(cur.left);
    paths.up = _GetPath(cur.up);
    paths.down = _GetPath(cur.down);

    cur.state = true;

    List<Node>? minimumPath = [];

    if (paths.up != null &&
        (paths.up!.length < minimumPath.length || minimumPath.isEmpty)) {
      minimumPath = paths.up;
    }
    if (paths.down != null &&
        (paths.down!.length < minimumPath!.length || minimumPath.isEmpty)) {
      minimumPath = paths.down;
    }
    if (paths.right != null &&
        (paths.right!.length < minimumPath!.length || minimumPath.isEmpty)) {
      minimumPath = paths.right;
    }
    if (paths.left != null &&
        (paths.left!.length < minimumPath!.length || minimumPath.isEmpty)) {
      minimumPath = paths.left;
    }

    if (minimumPath!.isEmpty) {
      return null;
    } else {
      minimumPath.insert(0, cur);
      return minimumPath;
    }
  }
}

