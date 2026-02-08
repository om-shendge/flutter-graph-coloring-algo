import 'package:flutter/material.dart';

abstract final class AppConstants {
  static const nodeSize = 50.0;
  static const animationDelay = Duration(milliseconds: 500);
  static const canvasHeight = 500.0;
  static const fontFamily = 'CM';

  static const recursiveColors = <Color>[
    Colors.white,
    Color(0xffFF5436),
    Color(0xff008FFF),
    Color(0xff50E3C2),
    Color(0xffB1F96E),
    Color(0xffBB14D9),
    Colors.orange,
  ];

  static const greedyBaseColors = <Color>[
    Color(0xffF6EE3F),
    Color(0xffFF5436),
    Color(0xff008FFF),
    Color(0xff50E3C2),
    Color(0xffB1F96E),
    Color(0xffBB14D9),
    Colors.orange,
  ];

  static const sampleMatrixOne = [
    [0, 1, 1, 0, 0],
    [1, 0, 1, 1, 0],
    [1, 1, 0, 1, 0],
    [0, 1, 1, 0, 1],
    [0, 0, 0, 1, 0],
  ];

  static const sampleMatrixTwo = [
    [0, 1, 1, 0, 0],
    [1, 0, 1, 0, 1],
    [1, 1, 0, 0, 1],
    [0, 0, 0, 0, 1],
    [0, 1, 1, 1, 0],
  ];
}

