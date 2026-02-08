import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../visualization/visualization_page.dart';
import 'providers/matrix_provider.dart';
import 'widgets/matrix_grid.dart';

class InputPage extends ConsumerStatefulWidget {
  final int vertexCount;

  const InputPage({super.key, required this.vertexCount});

  @override
  ConsumerState<InputPage> createState() => _InputPageState();
}

class _InputPageState extends ConsumerState<InputPage> {
  final _colorController = TextEditingController(text: '3');

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  void _navigateToVisualization(List<List<int>> matrix) {
    final colors = int.tryParse(_colorController.text) ?? 3;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VisualizationPage(
          vertexCount: widget.vertexCount,
          matrix: matrix,
          maxColors: colors,
        ),
      ),
    );
  }

  void _navigateWithSampleMatrix(List<List<int>> matrix) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VisualizationPage(
          vertexCount: 5,
          matrix: matrix,
          maxColors: 3,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width > 600;

    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 100),
              _buildHeader(),
              const SizedBox(height: 50),
              Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MatrixGrid(vertexCount: widget.vertexCount),
                  const SizedBox(height: 20),
                  _buildControls(),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: const TextSpan(
                text: 'Fill the adjacency Matrix.',
                style: TextStyle(
                  fontFamily: AppConstants.fontFamily,
                  fontSize: 60,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: '\nFill in the adjacency matrix by clicking on grid block.'
                        '\nEnter number of colors you wish to use.'
                        '\nIndexing of matrix starts from 0, similar to 2-D array.'
                        '\nYou can skip this part and proceed with the sample matrix.',
                    style: TextStyle(
                      fontFamily: AppConstants.fontFamily,
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.cyanAccent),
                onPressed: () => _navigateWithSampleMatrix(
                  AppConstants.sampleMatrixOne.map((r) => r.toList()).toList(),
                ),
                child: const Text('Sample Matrix 1', style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.cyanAccent),
                onPressed: () => _navigateWithSampleMatrix(
                  AppConstants.sampleMatrixTwo.map((r) => r.toList()).toList(),
                ),
                child: const Text('Sample Matrix 2', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      );

  Widget _buildControls() => Consumer(
        builder: (context, ref, _) {
          final notifier = ref.read(matrixProvider(widget.vertexCount));
          return Column(
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _colorController,
                  autofocus: true,
                  cursorColor: Colors.redAccent,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Enter number of colors',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: AppConstants.fontFamily,
                    ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffFC4A71),
                ),
                onPressed: () =>
                    _navigateToVisualization(notifier.toMatrix()),
                child: const Text('Proceed', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
}

