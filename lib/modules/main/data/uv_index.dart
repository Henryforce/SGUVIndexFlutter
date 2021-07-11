import 'package:flutter/material.dart';

class UVIndex {
  final _Level _level;
  final int value;

  UVIndex._(this._level, this.value);

  factory UVIndex.fromValue(int value) {
    if (value <= 2) {
      return UVIndex._(_Level.low, value);
    }
    switch (value) {
      case 3:
      case 4:
      case 5:
        return UVIndex._(_Level.moderate, value);
      case 6:
      case 7:
        return UVIndex._(_Level.high, value);
      case 8:
      case 9:
      case 10:
        return UVIndex._(_Level.veryHigh, value);
      default:
        return UVIndex._(_Level.extreme, value);
    }
  }

  String name() {
    switch (_level) {
      case _Level.low:
        return 'Low';
      case _Level.moderate:
        return 'Moderate';
      case _Level.high:
        return 'High';
      case _Level.veryHigh:
        return 'Very High';
      case _Level.extreme:
        return 'Extreme';
    }
  }

  Color color() {
    switch (_level) {
      case _Level.low:
        return Colors.green;
      case _Level.moderate:
        return Colors.yellow;
      case _Level.high:
        return Colors.orange;
      case _Level.veryHigh:
        return Colors.red;
      case _Level.extreme:
        return Colors.purple;
    }
  }
}

enum _Level { low, moderate, high, veryHigh, extreme }
