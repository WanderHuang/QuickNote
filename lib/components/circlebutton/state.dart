// import 'package:flutter/material.dart' show Animation, AnimationController;
import 'dart:math';
class CircleButtonState {

  final double boxRadius = 75;
  final double iconRadius = 20;
  final double startPosition = 55;
  final double centerSize = 40;
  final double zero = 0;

  // 1 go expand 0 go shrink
  int status;

  List<List<double>> positions = [];

  CircleButtonState(this.status, [List<List<double>> endPositions]) {
    if (endPositions == null) {
      List<List<double>> positions = [];
      double line = startPosition * sqrt1_2;
      positions.add([startPosition - line, startPosition - line]);
      positions.add([startPosition, zero]);
      positions.add([zero, startPosition]);
      positions.add([startPosition + line, startPosition - line]);
      positions.add([startPosition - line, startPosition + line]);
      this.positions.addAll(positions);
    } else {
      this.positions = endPositions;
    }
  }

  factory CircleButtonState.fromState(CircleButtonState state) {
    return CircleButtonState(state.status, state.positions);
  }

  @override
  String toString() {
    return 'CircleButtonState[status=$status]';
  }
}