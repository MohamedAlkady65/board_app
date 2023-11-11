import 'package:flutter/material.dart';

class PathLine {
  PathLine({required this.width, required this.height, required this.Size});
  double width;
  double height;
  int Size;

  Widget up() {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: RotatedBox(
          quarterTurns: 1,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: (width - 15) / Size / 2,
              height: 5,
              color: Colors.black,
            ),
          ),
        ));
  }

  Widget down() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: RotatedBox(
          quarterTurns: 1,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: (width - 15) / Size / 2,
              height: 5,
              color: Colors.black,
            ),
          ),
        ));
  }

  Widget left() {
    return Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: (width - 15) / Size / 2,
            height: 5,
            color: Colors.black,
          ),
        ));
  }

  Widget right() {
    return Positioned(
        top: 0,
        bottom: 0,
        right: 0,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: (width - 15) / Size / 2,
            height: 5,
            color: Colors.black,
          ),
        ));
  }

  Widget circle() {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 7,
          ),
        ));
  }

  Widget arrow(int rotate) {
    return Positioned(
        top: 0,
        bottom: 0,
        right: 0,
        left: 0,
        child: Align(
          alignment: Alignment.center,
          child: RotatedBox(
            quarterTurns: rotate,
            child: Icon(
              Icons.play_arrow,
              size: 30,
              weight: 50,
            ),
          ),
        ));
  }
}
