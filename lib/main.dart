import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';
import 'features/info/info_page.dart';

void main() => runApp(const ProviderScope(child: GraphColoringApp()));

class GraphColoringApp extends StatelessWidget {
  const GraphColoringApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Graph Coloring Visualization',
        theme: AppTheme.theme,
        home: const InfoPage(),
      );
}
