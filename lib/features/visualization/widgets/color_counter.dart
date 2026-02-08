import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants.dart';
import '../../../models/graph_config.dart';
import '../providers/graph_provider.dart';

class ColorCounter extends ConsumerWidget {
  final GraphConfig config;

  const ColorCounter({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorCount = ref.watch(
      graphProvider(config).select((c) => c.state.colorCount),
    );

    return RichText(
      text: TextSpan(
        text: '$colorCount',
        style: const TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 60,
          color: Colors.white,
        ),
        children: const [
          TextSpan(
            text: ' times vertices colored.',
            style: TextStyle(
              fontFamily: AppConstants.fontFamily,
              fontSize: 40,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}

