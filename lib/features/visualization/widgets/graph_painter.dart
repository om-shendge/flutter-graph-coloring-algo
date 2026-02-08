import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  final List<Offset> offsets;
  final List<List<int>> matrix;

  const GraphPainter({required this.offsets, required this.matrix});

  @override
  void paint(Canvas canvas, Size size) {
    if (offsets.length <= 1) return;

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    final vertexCount = offsets.length;
    for (var i = 0; i < vertexCount; i++) {
      for (var j = 0; j < vertexCount; j++) {
        if (matrix[i][j] == 1) {
          canvas.drawLine(offsets[i], offsets[j], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(GraphPainter oldDelegate) => true;
}

