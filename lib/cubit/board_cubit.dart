import 'package:board_app/algorithm/node.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../algorithm/board.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit() : super(BoardInitial()) {
    Size = 5;
    board = Board(Size: Size);
  }

  late int Size;
  late Board board;
  Node? SideWall;
  List<List<Node>> walls = [];
  List<Node> Path = [];
  bool unreach = false;

  void AddWall(Node node) {
    if (SideWall == null) {
      SideWall = node;
    } else {
      bool added = board.AddWall(SideWall!, node);
      if (added == true) {
        walls.add([SideWall!, node]);
      }
      SideWall = null;
      emit(BoardInitial());
    }
  }

  void SetStartCell(Node node) {
    board.StartNode = node;
    emit(BoardInitial());
  }

  void SetEndCell(Node node) {
    board.EndNode = node;
    emit(BoardInitial());
  }

  void GetPath() {
    if (board.StartNode != null && board.EndNode != null) {
      Path = board.FindPath() ?? [];
      if (Path.isEmpty) {
        unreach = true;
      } else {
        unreach = false;
      }
      emit(BoardInitial());
    }
  }

  void Reset() {
    board = Board(Size: Size);
    walls = [];
    Path = [];
    unreach = false;
    emit(BoardInitial());
  }
}
