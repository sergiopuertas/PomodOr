import 'package:flutter/material.dart';

//2 modes => _isWorkMode == true (workMode)
//           _isWorkMode == false (restMode)

class TimerMode with ChangeNotifier {
  bool _isWorkMode = true;
  int _completedCycles = 0;

  late DateTime initialWorkTime; // Initial time for work mode
  late DateTime initialRestTime; // Initial time for rest mode

  void setInitialWorkTime(DateTime time) {
    initialWorkTime = time;
    notifyListeners();
  }
  void setTimes(int workMinutes, int restMinutes) {
    initialWorkTime = DateTime(0, 0, 0, 0, workMinutes, 0);
    initialRestTime = DateTime(0, 0, 0, 0, restMinutes, 0);
    notifyListeners();
  }

  void setInitialRestTime(DateTime time) {
    initialRestTime = time;
    notifyListeners();
  }

  bool get isWorkMode => _isWorkMode;
  int get completedCycles => _completedCycles;

  void switchMode() {
    _isWorkMode = !_isWorkMode;
    if (!_isWorkMode) {
      _completedCycles++;
    }
    notifyListeners();
  }

  void resetCycles() {
    _completedCycles = 0;
    notifyListeners();
  }

  DateTime get initialTime => _isWorkMode ? initialWorkTime : initialRestTime;
}
