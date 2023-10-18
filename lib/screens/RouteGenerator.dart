import 'package:flutter/material.dart';
import 'package:pomodor/screens/PomodorChoice.dart';
import 'package:pomodor/screens/PomodoroHome.dart';
import 'package:pomodor/screens/PomodoroPersonalisedTime.dart';
import 'package:pomodor/screens/PomodoroRestTime.dart';
import 'package:pomodor/screens/PomodoroWorkTime.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/page1':
        return MaterialPageRoute(builder: (_) => PomodoroHome());
      case '/page2':
        return MaterialPageRoute(builder: (_) => PomodoroChoice());
      case '/page3':
        return MaterialPageRoute(builder: (_) => PomodoroWorkTime());
      case '/page4':
        return MaterialPageRoute(builder: (_) => PomodoroRestTime());
      case '/page5':
        return MaterialPageRoute(builder: (_) => PomodoroPersonalisedTime());

      default : 
        return MaterialPageRoute(builder: (_) => PomodoroHome());

    }
  }
}