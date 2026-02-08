import 'package:flutter/material.dart';
import '../core/constants.dart';

typedef ColorUpdateCallback = Future<void> Function(int vertex, Color color);

abstract final class GraphColoringService {
  static Future<bool> runRecursive({
    required List<List<int>> matrix,
    required int maxColors,
    required ColorUpdateCallback onColorUpdate,
  }) async {
    final vertexCount = matrix.length;
    final colors = List<Color>.filled(vertexCount, Colors.white);
    return _recursiveColoring(matrix, maxColors, 0, colors, vertexCount, onColorUpdate);
  }

  static Future<bool> _recursiveColoring(
    List<List<int>> matrix,
    int maxColors,
    int vertex,
    List<Color> colors,
    int vertexCount,
    ColorUpdateCallback onColorUpdate,
  ) async {
    if (vertex == vertexCount) return _isSafeColoring(matrix, colors, vertexCount);

    for (var c = 1; c <= maxColors; c++) {
      colors[vertex] = AppConstants.recursiveColors[c];
      await Future.delayed(AppConstants.animationDelay);
      await onColorUpdate(vertex, colors[vertex]);

      if (await _recursiveColoring(matrix, maxColors, vertex + 1, colors, vertexCount, onColorUpdate)) {
        return true;
      }
    }
    return false;
  }

  static bool _isSafeColoring(List<List<int>> matrix, List<Color> colors, int vertexCount) {
    for (var i = 0; i < vertexCount; i++) {
      for (var j = i + 1; j < vertexCount; j++) {
        if (matrix[i][j] == 1 && colors[j] == colors[i]) return false;
      }
    }
    return true;
  }

  static Future<bool> runBacktracking({
    required List<List<int>> matrix,
    required int maxColors,
    required ColorUpdateCallback onColorUpdate,
  }) async {
    final vertexCount = matrix.length;
    final colors = List<Color>.filled(vertexCount, Colors.white);
    return _backtrackColoring(matrix, maxColors, colors, vertexCount, 0, onColorUpdate);
  }

  static Future<bool> _backtrackColoring(
    List<List<int>> matrix,
    int maxColors,
    List<Color> colors,
    int vertexCount,
    int vertex,
    ColorUpdateCallback onColorUpdate,
  ) async {
    if (vertex == vertexCount) return true;

    for (var c = 1; c <= maxColors; c++) {
      if (_isColorSafe(vertex, matrix, colors, c, vertexCount)) {
        colors[vertex] = AppConstants.recursiveColors[c];
        await Future.delayed(AppConstants.animationDelay);
        await onColorUpdate(vertex, colors[vertex]);

        if (await _backtrackColoring(matrix, maxColors, colors, vertexCount, vertex + 1, onColorUpdate)) {
          return true;
        }
        colors[vertex] = Colors.white;
      }
    }
    return false;
  }

  static bool _isColorSafe(int vertex, List<List<int>> matrix, List<Color> colors, int colorIndex, int vertexCount) {
    final color = AppConstants.recursiveColors[colorIndex];
    for (var i = 0; i < vertexCount; i++) {
      if (matrix[vertex][i] == 1 && color == colors[i]) return false;
    }
    return true;
  }

  static Future<void> runGreedy({
    required List<List<int>> matrix,
    required ColorUpdateCallback onColorUpdate,
  }) async {
    final vertexCount = matrix.length;
    final greedyPalette = AppConstants.greedyBaseColors;
    final resultIndex = List<int>.filled(vertexCount, -1);

    resultIndex[0] = 0;
    await onColorUpdate(0, Colors.purpleAccent);

    for (var u = 1; u < vertexCount; u++) {
      final available = List<bool>.filled(vertexCount, true);

      for (var i = 0; i < vertexCount; i++) {
        if (matrix[u][i] == 1 && resultIndex[i] != -1) {
          available[resultIndex[i]] = false;
        }
      }

      var colorIndex = 0;
      while (colorIndex < vertexCount && !available[colorIndex]) {
        colorIndex++;
      }

      resultIndex[u] = colorIndex;
      final color =
          colorIndex < greedyPalette.length ? greedyPalette[colorIndex] : Colors.grey;

      await Future.delayed(AppConstants.animationDelay);
      await onColorUpdate(u, color);
    }
  }
}

