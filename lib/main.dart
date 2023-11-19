import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pomodor/screens/Home.dart';
import 'package:pomodor/screens/RouteGenerator.dart';
import 'toDoList/TaskList.dart';
import 'notifications.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initNotifications();
    return FutureBuilder(
      future: _initApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: CircularProgressIndicator());
        }
        else {
          return ChangeNotifierProvider(
            create: (context) => TaskList.instance,
            child: MaterialApp(
              onGenerateRoute: RouteGenerator.generateRoute,
              title: 'Pomod\'or',
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              home: Home(),
              initialRoute: '/page1',
            ),
          );
        }
      },
    );
  }

  Future _initApp() async {
    final taskList = await loadTaskList();
    TaskList.instance.setTasks(taskList);
  }
}
