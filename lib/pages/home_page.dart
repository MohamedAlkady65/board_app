import 'package:board_app/cubit/board_cubit.dart';
import 'package:board_app/widgets/table_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/path_line.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BoardCubit boardCubit;

  @override
  Widget build(BuildContext context) {
    boardCubit = BlocProvider.of<BoardCubit>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text("Board App")),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            BlocBuilder<BoardCubit, BoardState>(builder: (context, state) {
              String text;

              if (boardCubit.board.StartNode == null) {
                text = "Select Start Cell";
              } else if (boardCubit.board.EndNode == null) {
                text = "Select End Cell";
              } 
              else if (boardCubit.unreach == true) {
                text = "Unreachable";
              }
              else {
                text = "Add Walls";
              }
              return Text(
                text,
                style: const TextStyle(fontSize: 40),
              );
            }),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<BoardCubit, BoardState>(
              builder: (context, state) {
                return TableBoard();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
                onPressed: () {
                  boardCubit.GetPath();
                },
                child: const Text(
                  "Get Shortest Path",
                  style: TextStyle(fontSize: 28),
                )),
            const Spacer(
              flex: 1,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(maximumSize: const Size(100, 50)),
                onPressed: () {
                  boardCubit.Reset();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Reset"), Icon(Icons.replay)],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
