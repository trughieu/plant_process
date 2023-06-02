import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressProvider extends ChangeNotifier {
  double _progress = 0.1;

  double get progress => _progress;

  void updateProgress() {
    if (_progress < 1.0) {
      _progress += 0.1;
      notifyListeners();
    }
  }
}
