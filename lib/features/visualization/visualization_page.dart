import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/graph_config.dart';
import 'widgets/algorithm_controls.dart';
import 'widgets/color_counter.dart';
import 'widgets/graph_canvas.dart';

class VisualizationPage extends ConsumerWidget {
  final int vertexCount;
  final List<List<int>> matrix;
  final int maxColors;

  const VisualizationPage({
    super.key,
    required this.vertexCount,
    required this.matrix,
    required this.maxColors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = MediaQuery.sizeOf(context).width > 600;
    final config = GraphConfig(
      vertexCount: vertexCount,
      matrix: matrix,
      maxColors: maxColors,
    );

    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              GraphCanvas(config: config),
              const SizedBox(height: 50),
              ColorCounter(config: config),
              const SizedBox(height: 50),
              AlgorithmControls(config: config, isHorizontal: isDesktop),
            ],
          ),
        ),
      ),
    );
  }
}

