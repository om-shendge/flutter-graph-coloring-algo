import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme.dart';
import '../../../models/graph_config.dart';
import '../providers/graph_provider.dart';

class AlgorithmControls extends ConsumerWidget {
  final bool isHorizontal;
  final GraphConfig config;

  const AlgorithmControls({
    super.key,
    required this.config,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(graphProvider(config));
    final isRunning = ref.watch(
      graphProvider(config).select((c) => c.state.isRunning),
    );

    final buttons = [
      _AlgorithmButton(
        label: 'Recursive',
        color: AppTheme.recursiveButton,
        onPressed: isRunning ? null : notifier.runRecursive,
      ),
      _AlgorithmButton(
        label: 'Backtracking',
        color: AppTheme.backtrackButton,
        onPressed: isRunning ? null : notifier.runBacktracking,
      ),
      _AlgorithmButton(
        label: 'Greedy',
        color: AppTheme.accent,
        onPressed: isRunning ? null : notifier.runGreedy,
      ),
      _AlgorithmButton(
        label: 'Reset Colors',
        color: Colors.white,
        textColor: Colors.black,
        onPressed: isRunning ? null : notifier.resetAllColors,
      ),
    ];

    return Flex(
      direction: isHorizontal ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }
}

class _AlgorithmButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback? onPressed;

  const _AlgorithmButton({
    required this.label,
    required this.color,
    this.textColor = Colors.white,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: onPressed == null ? color.withValues(alpha: 0.5) : color,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Text(label, style: TextStyle(color: textColor)),
      );
}

