class GraphConfig {
  final int vertexCount;
  final List<List<int>> matrix;
  final int maxColors;

  const GraphConfig({
    required this.vertexCount,
    required this.matrix,
    required this.maxColors,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GraphConfig &&
          runtimeType == other.runtimeType &&
          vertexCount == other.vertexCount &&
          maxColors == other.maxColors &&
          _matrixEquals(matrix, other.matrix);

  @override
  int get hashCode => Object.hash(
        vertexCount,
        maxColors,
        matrix.length,
        matrix.isNotEmpty ? Object.hashAll(matrix.first) : 0,
      );

  static bool _matrixEquals(List<List<int>> a, List<List<int>> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].length != b[i].length) return false;
      for (var j = 0; j < a[i].length; j++) {
        if (a[i][j] != b[i][j]) return false;
      }
    }
    return true;
  }
}

