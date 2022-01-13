// @dart=2.9
import 'package:flutter/material.dart';

enum Priority {
  Low,
  Medium,
  High,
  Empty,
}

extension PriorityExtension on Priority {
  static const Map<Priority, Color> _priority = {
    Priority.Low: Colors.lightGreen,
    Priority.Medium: Colors.blue,
    Priority.High: Colors.red,
    Priority.Empty: Colors.white,
  };

  Color get value => _priority[this];
}
