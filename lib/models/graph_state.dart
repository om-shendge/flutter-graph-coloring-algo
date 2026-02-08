import 'package:flutter/material.dart';
import 'graph_node.dart';

class GraphState {
  final List<GraphNode> nodes;
  final List<List<int>> matrix;
  final int colorCount;
  final int maxColors;
  final bool isRunning;

  const GraphState({
    required this.nodes,
    required this.matrix,
    this.colorCount = 0,
    this.maxColors = 3,
    this.isRunning = false,
  });

  GraphState copyWith({
    List<GraphNode>? nodes,
    List<List<int>>? matrix,
    int? colorCount,
    int? maxColors,
    bool? isRunning,
  }) =>
      GraphState(
        nodes: nodes ?? this.nodes,
        matrix: matrix ?? this.matrix,
        colorCount: colorCount ?? this.colorCount,
        maxColors: maxColors ?? this.maxColors,
        isRunning: isRunning ?? this.isRunning,
      );

  int get vertexCount => nodes.length;

  static GraphState initial(int vertexCount, List<List<int>> matrix, int maxColors) {
    final nodes = List.generate(
      vertexCount,
      (i) => GraphNode(
        offset: Offset(200 + 10 * i.toDouble(), 150),
        index: i,
        color: Colors.white,
      ),
    );
    return GraphState(nodes: nodes, matrix: matrix, maxColors: maxColors);
  }
}

