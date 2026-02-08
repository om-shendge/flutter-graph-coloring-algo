import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/matrix_provider.dart';

class MatrixGrid extends ConsumerWidget {
  final int vertexCount;

  const MatrixGrid({super.key, required this.vertexCount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matrixData =
        ref.watch(matrixProvider(vertexCount).select((c) => c.matrix));
    final notifier = ref.read(matrixProvider(vertexCount));
    final size = MediaQuery.sizeOf(context).height * 0.5;

    return SizedBox(
      height: size,
      width: size,
      child: GridView.builder(
        itemCount: vertexCount * vertexCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: vertexCount,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => notifier.toggle(index),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '${matrixData[index]}',
                  style: const TextStyle(color: Colors.redAccent, fontSize: 40),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

