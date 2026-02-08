import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class MatrixController extends ChangeNotifier {
  MatrixController(this._vertexCount)
      : _matrix = List.filled(_vertexCount * _vertexCount, 0);

  final int _vertexCount;
  List<int> _matrix;

  List<int> get matrix => _matrix;

  void toggle(int index) {
    final updated = [..._matrix];
    updated[index] = updated[index] == 0 ? 1 : 0;
    _matrix = updated;
    notifyListeners();
  }

  List<List<int>> toMatrix() => List.generate(
        _vertexCount,
        (i) => List.generate(
          _vertexCount,
          (j) => _matrix[j + i * _vertexCount],
        ),
      );
}

final matrixProvider =
    ChangeNotifierProvider.family<MatrixController, int>(
        (ref, vertexCount) => MatrixController(vertexCount));

