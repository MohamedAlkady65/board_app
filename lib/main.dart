import 'package:board_app/cubit/board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const BoardApp());
}

class BoardApp extends StatelessWidget {
  const BoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoardCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.black
          )
        ),
      ),
    );
  }
}
