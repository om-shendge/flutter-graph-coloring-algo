import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class DraggableNode extends StatelessWidget {
  final Offset offset;
  final String label;
  final Color color;
  final void Function(double x, double y) onDrag;

  const DraggableNode({
    super.key,
    required this.offset,
    required this.label,
    required this.color,
    required this.onDrag,
  });

  void _handleDrag(DragUpdateDetails details) {
    onDrag(details.globalPosition.dx, details.globalPosition.dy);
  }

  @override
  Widget build(BuildContext context) {
    const size = AppConstants.nodeSize;
    return Positioned(
      left: offset.dx - size / 2,
      top: offset.dy - size / 2,
      child: GestureDetector(
        onPanStart: (d) => onDrag(d.globalPosition.dx, d.globalPosition.dy),
        onPanUpdate: _handleDrag,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

