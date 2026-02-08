import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants.dart';
import '../../../core/theme.dart';
import '../../../models/graph_config.dart';
import '../providers/graph_provider.dart';
import 'draggable_node.dart';
import 'graph_painter.dart';

class GraphCanvas extends ConsumerWidget {
  final GraphConfig config;

  const GraphCanvas({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(graphProvider(config));
    final state = controller.state;
    final notifier = ref.read(graphProvider(config));

    return Container(
      color: AppTheme.canvasBackground,
      height: AppConstants.canvasHeight,
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: GraphPainter(
              offsets: state.nodes.map((n) => n.offset).toList(),
              matrix: state.matrix,
            ),
          ),
          ...state.nodes.map(
            (node) => DraggableNode(
              offset: node.offset,
              label: '${node.index}',
              color: node.color,
              onDrag: (x, y) =>
                  notifier.updateNodePosition(node.index, Offset(x, y)),
            ),
          ),
        ],
      ),
    );
  }
}

