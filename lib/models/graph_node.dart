import 'dart:ui';

class GraphNode {
  final Offset offset;
  final int index;
  final Color color;

  const GraphNode({
    required this.offset,
    required this.index,
    required this.color,
  });

  GraphNode copyWith({Offset? offset, Color? color}) => GraphNode(
        offset: offset ?? this.offset,
        index: index,
        color: color ?? this.color,
      );
}

