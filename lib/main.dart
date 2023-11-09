import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodor/screens/Home.dart';
import 'package:pomodor/screens/RouteGenerator.dart';
import 'toDoList/TaskList.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize SharedPreferences and load tasks
      future: _initApp(),
      builder: (context, snapshot) {
        // Show a progress indicator while waiting for initialization
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: CircularProgressIndicator());
        } else {
          // Once complete, show your application
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
    // Assuming you have a method to load tasks from SharedPreferences
    final taskList = await loadTaskList();
    // Now set this task list to your TaskList provider
    TaskList.instance.setTasks(taskList);
  }
}
