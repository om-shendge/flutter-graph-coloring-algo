import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../models/graph_config.dart';
import '../../../models/graph_state.dart';
import '../../../services/graph_coloring_service.dart';

class GraphController extends ChangeNotifier {
  GraphState _state;

  GraphController(GraphConfig config)
      : _state = GraphState.initial(
          config.vertexCount,
          config.matrix,
          config.maxColors,
        );

  GraphState get state => _state;

  void updateNodePosition(int index, Offset offset) {
    final updatedNodes = [..._state.nodes];
    updatedNodes[index] = updatedNodes[index].copyWith(offset: offset);
    _state = _state.copyWith(nodes: updatedNodes);
    notifyListeners();
  }

  void _updateNodeColor(int index, Color color, {bool count = true}) {
    final updatedNodes = [..._state.nodes];
    updatedNodes[index] = updatedNodes[index].copyWith(color: color);
    _state = _state.copyWith(
      nodes: updatedNodes,
      colorCount: count ? _state.colorCount + 1 : _state.colorCount,
    );
    notifyListeners();
  }

  void resetAllColors() {
    final updatedNodes = _state.nodes
        .map((node) => node.copyWith(color: Colors.white))
        .toList();
    _state =
        _state.copyWith(nodes: updatedNodes, colorCount: 0, isRunning: false);
    notifyListeners();
  }

  Future<void> runRecursive() async {
    if (_state.isRunning) return;
    _state = _state.copyWith(isRunning: true, colorCount: 0);
    notifyListeners();

    await GraphColoringService.runRecursive(
      matrix: _state.matrix,
      maxColors: _state.maxColors,
      onColorUpdate: (vertex, color) async => _updateNodeColor(vertex, color),
    );

    _state = _state.copyWith(isRunning: false);
    notifyListeners();
  }

  Future<void> runBacktracking() async {
    if (_state.isRunning) return;
    _state = _state.copyWith(isRunning: true, colorCount: 0);
    notifyListeners();

    await GraphColoringService.runBacktracking(
      matrix: _state.matrix,
      maxColors: _state.maxColors,
      onColorUpdate: (vertex, color) async => _updateNodeColor(vertex, color),
    );

    _state = _state.copyWith(isRunning: false);
    notifyListeners();
  }

  Future<void> runGreedy() async {
    if (_state.isRunning) return;
    _state = _state.copyWith(isRunning: true, colorCount: 0);
    notifyListeners();

    await GraphColoringService.runGreedy(
      matrix: _state.matrix,
      onColorUpdate: (vertex, color) async =>
          _updateNodeColor(vertex, color, count: vertex != 0),
    );

    _state = _state.copyWith(isRunning: false);
    notifyListeners();
  }
}

final graphProvider =
    ChangeNotifierProvider.family<GraphController, GraphConfig>(
        (ref, config) => GraphController(config));

