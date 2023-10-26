import 'package:flutter/material.dart';
import 'package:pomodor/screens/Choice.dart';
import 'package:pomodor/screens/Home.dart';
import 'package:pomodor/screens/PersonalisedTime.dart';
import 'package:pomodor/screens/RestTime.dart';
import 'package:pomodor/screens/WorkTime.dart';
import 'package:pomodor/screens/TodolistScreen.dart';

abstract class RouteFactory {
  MaterialPageRoute createRoute();
}

class HomeRouteFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => Home());
}
class ChoiceRouteFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => Choice());
}
class WorkRouteFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => WorkTime());
}
class RestRouteFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => RestTime());
}
class PersonalisedRouteFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => PersonalisedTime());
}
class todoListRouteFactory extends RouteFactory {
  @override
  MaterialPageRoute createRoute() => MaterialPageRoute(builder: (_) => todolistScreen());
}

class RouteGenerator {
  static final Map<String, RouteFactory> _routes = {
    '/page1': HomeRouteFactory(),
    '/page2': ChoiceRouteFactory(),
    '/page3': WorkRouteFactory(),
    '/page4': RestRouteFactory(),
    '/page5': PersonalisedRouteFactory(),
    '/page6': todoListRouteFactory()
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
