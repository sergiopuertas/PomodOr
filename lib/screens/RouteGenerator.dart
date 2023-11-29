import 'package:flutter/material.dart';
import 'package:pomodor/screens/Home.dart';
import 'package:pomodor/screens/RestTime.dart';
import 'package:pomodor/screens/WorkTime.dart';
import 'package:pomodor/screens/TodolistScreen.dart';
import 'package:pomodor/screens/TaskChoosing.dart';
import 'package:pomodor/screens/time_selection_screen.dart';

import 'package:pomodor/Timer/clock_view.dart';

abstract class RouteFactory {
  MaterialPageRoute createRoute();
}
class HomeRouteFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => Home());
}
class WorkRouteFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => WorkTime());
}
class RestRouteFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => RestTime());
}
class todoListRouteFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => todolistScreen());
}

class TaskChoosingFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => TaskChoosing());
}
class TimeChoosingFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => TimeSelectionScreen());
}
class RouteGenerator {
  static final Map<String, RouteFactory> _routes = {
    '/page1': HomeRouteFactory(),
    '/page2': TaskChoosingFactory(),
    '/page3': WorkRouteFactory(),
    '/page4': RestRouteFactory(),
    '/page5': TimeChoosingFactory(),
    '/page6': todoListRouteFactory(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final factory = _routes[settings.name];
    if (factory != null) {
      return factory.createRoute();
    }
    // Default route
    return HomeRouteFactory().createRoute();
  }
}
