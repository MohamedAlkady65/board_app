import 'package:board_app/cubit/board_cubit.dart';
import 'package:board_app/widgets/cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class TableBoard extends StatelessWidget {
  TableBoard({super.key});

  late int Size;

  @override
  Widget build(BuildContext context) {
    Size = BlocProvider.of<BoardCubit>(context).Size;
    return Table(
        defaultColumnWidth: FractionColumnWidth(1 / Size),
        border: TableBorder.symmetric(
            outside: const BorderSide(width: 10, color: kBorderColor)),
        children: List.generate(
            Size,
            (inRow) => TableRow(
                children: List.generate(
                    Size,
                    (inCell) => Cell(
                          node: BlocProvider.of<BoardCubit>(context)
                              .board
                              .nodes[inRow][inCell],
                          context: context,
                        )))));
  }
}
