import 'package:board_app/algorithm/node.dart';
import 'package:board_app/constants.dart';
import 'package:board_app/cubit/board_cubit.dart';
import 'package:board_app/widgets/path_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cell extends StatefulWidget {
  Cell({
    required this.node,
    required this.context,
    super.key,
  }) {
    boardCubit = BlocProvider.of<BoardCubit>(context);
    path = boardCubit.Path;
    backgroundColor = kCellColor;
    textColor = Colors.black;
    fromPath = path.indexWhere((element) => node == element);
    if (fromPath != -1) {
      backgroundColor = kPathColor;
      textColor = Colors.white;
    }
    start = boardCubit.board.StartNode == node;
    end = boardCubit.board.EndNode == node;
    text = start
        ? "Start"
        : end
            ? "End"
            : "${node.index + 1}";
    border = getBorder();

    AddLines();
  }

  void AddLines() {
    PathLine line = PathLine(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        Size: boardCubit.Size);
    if (fromPath == 0) {
      lines.add(line.circle());
    }
    if (fromPath == path.length - 1 && fromPath != -1) {
      if (node.left == path[fromPath - 1]) {
        lines.add(line.arrow(0));
      } else if (node.right == path[fromPath - 1]) {
        lines.add(line.arrow(2));
      } else if (node.up == path[fromPath - 1]) {
        lines.add(line.arrow(1));
      } else if (node.down == path[fromPath - 1]) {
        lines.add(line.arrow(3));
      }
    }
    if (fromPath < path.length - 1 && fromPath != -1) {
      if (node.right == path[fromPath + 1]) {
        lines.add(line.right());
      } else if (node.up == path[fromPath + 1]) {
        lines.add(line.up());
      } else if (node.down == path[fromPath + 1]) {
        lines.add(line.down());
      } else if (node.left == path[fromPath + 1]) {
        lines.add(line.left());
      }
    }
    if (fromPath > 0) {
      if (node.right == path[fromPath - 1]) {
        lines.add(line.right());
      } else if (node.up == path[fromPath - 1]) {
        lines.add(line.up());
      } else if (node.down == path[fromPath - 1]) {
        lines.add(line.down());
      } else if (node.left == path[fromPath - 1]) {
        lines.add(line.left());
      }
    }
  }

  Border getBorder() {
    List<List<Node>> walls = boardCubit.walls
        .where((element) => element[0] == node || element[1] == node)
        .toList();

    BorderSide left = const BorderSide(width: 5, color: kBorderColor);
    BorderSide right = const BorderSide(width: 5, color: kBorderColor);
    BorderSide top = const BorderSide(width: 5, color: kBorderColor);
    BorderSide bottom = const BorderSide(width: 5, color: kBorderColor);

    walls.forEach(
      (element) {
        if (element[1] == node) {
          Node temp = element[0];
          element[0] = element[1];
          element[1] = temp;
        }

        if (element[0].left == null) {
          left = const BorderSide(width: 5, color: kWallColor);
        }
        if (element[0].right == null) {
          right = const BorderSide(width: 5, color: kWallColor);
        }
        if (element[0].up == null) {
          top = const BorderSide(width: 5, color: kWallColor);
        }
        if (element[0].down == null) {
          bottom = const BorderSide(width: 5, color: kWallColor);
        }
      },
    );
    return Border(bottom: bottom, left: left, right: right, top: top);
  }

  Node node;
  BuildContext context;
  late Color backgroundColor;
  late Color textColor;
  late bool start;
  late bool end;
  late int fromPath;
  late Border border;
  late BoardCubit boardCubit;
  late String text;
  List<Widget> lines = [];
  late List<Node> path;

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: widget.backgroundColor, border: widget.border),
            height: (MediaQuery.of(context).size.width - 20) /
                widget.boardCubit.Size,
            width: double.infinity,
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 22,
                  color: widget.textColor,
                ),
              ),
            ),
          ),
          ...widget.lines
        ],
      ),
    );
  }

  void onTap() {
    if (widget.boardCubit.Path.isEmpty) {
      if (widget.boardCubit.board.StartNode == null) {
        widget.boardCubit.SetStartCell(widget.node);
      } else if (widget.boardCubit.board.EndNode == null) {
        if (widget.boardCubit.board.StartNode != widget.node) {
          widget.boardCubit.SetEndCell(widget.node);
        }
      } else {
        setState(() {
          widget.backgroundColor = Colors.grey;
        });
        widget.boardCubit.AddWall(widget.node);
      }
    }
  }
}
