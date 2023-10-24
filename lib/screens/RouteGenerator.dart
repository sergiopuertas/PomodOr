import 'package:flutter/material.dart';
import 'package:pomodor/screens/Choice.dart';
import 'package:pomodor/screens/Home.dart';
import 'package:pomodor/screens/PersonalisedTime.dart';
import 'package:pomodor/screens/RestTime.dart';
import 'package:pomodor/screens/WorkTime.dart';
import 'package:pomodor/screens/TodolistScreen.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/page1':
        return MaterialPageRoute(builder: (_) => Home());
      case '/page2':
        return MaterialPageRoute(builder: (_) => Choice());
      case '/page3':
        return MaterialPageRoute(builder: (_) => WorkTime());
      case '/page4':
        return MaterialPageRoute(builder: (_) => RestTime());
      case '/page5':
        return MaterialPageRoute(builder: (_) => PersonalisedTime());
      case '/page6':
        return MaterialPageRoute(builder: (_) => todolistScreen());

      default : 
        return MaterialPageRoute(builder: (_) => Home());

    }
  }
}