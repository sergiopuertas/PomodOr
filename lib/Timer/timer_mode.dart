import 'package:flutter/material.dart';
import 'package:pomodor/auxiliar.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'clock_view.dart';

//2 modes => _isWorkMode == true (workMode)
//           _isWorkMode == false (restMode)

class TimerMode with ChangeNotifier {
  TimerMode._privateConstructor();

  Future<List<String>> loadMotivationalSentences() async {
    String fileContent = await rootBundle.loadString(
        'assets/motivation_4_work.txt');
    return fileContent.split('\n'); // Splits the file content into lines
  }

  List<String> motivationalSentences = [];
  Random random = Random(); // Create a Random object
  int sentenceIndex = 0;
  static final TimerMode _instance = TimerMode._privateConstructor();

  static TimerMode get instance => _instance;

  bool _isOpen = true;
  bool _isWorkMode = true;
  int _completedCycles = 0;

  late DateTime initialWorkTime;
  late DateTime initialRestTime;
  late int numCycles;

  void startSession(){
    loadMotivationalSentences().then((sentences) {
        motivationalSentences = sentences;
    });
    _isOpen = true;
    notifyListeners();
  }
  void endSession(BuildContext context, bool show){
    studyTasks(context,false);
    _isOpen = false;
    numCycles = 0;
    _isWorkMode = false;
    if (show)endAnnouncement(context);
    notifyListeners();
  }
  void setInitialWorkTime(DateTime time) {
    initialWorkTime = time;
    notifyListeners();
  }
  void setNumCycles(int numcycles) {
    numCycles = numcycles;
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
  bool get isOpen => _isOpen;
  bool get isWorkMode => _isWorkMode;
  int get completedCycles => _completedCycles;

  void switchMode(BuildContext context) {
    _isWorkMode = !_isWorkMode;
    if (!_isWorkMode) {
      print("end of work");
      sentenceIndex = random.nextInt(motivationalSentences.length);
      restAnnouncement(context);
    }
    else{
      print("end of rest");
      _completedCycles++;
      if(_completedCycles == numCycles){
        print("end of session");
        endSession(context, true);
      }
      else workAnnouncement(context);
    }
    notifyListeners();
    return;
  }
  DateTime get initialTime => _isWorkMode ? initialWorkTime : initialRestTime;
}

