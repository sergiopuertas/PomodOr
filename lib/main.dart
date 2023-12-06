import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomodor/auxiliar.dart';
import 'package:pomodor/screens/Home.dart';
import 'package:pomodor/Timer/timer_mode.dart';
import 'package:pomodor/screens/RouteGenerator.dart';
import 'package:pomodor/music.dart';
import 'toDoList/TaskList.dart';
import 'notifications.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initNotifications();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(Pomodor());
  });
}


class Pomodor extends StatelessWidget {
  Pomodor({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return FutureBuilder(
      future: _initApp(),
      builder: (context, snapshot) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => TaskList.instance),
              ChangeNotifierProvider(create: (context) => TimerMode.instance),
              InheritedProvider(create: (context)=> MusicProvider.instance)
            ],
            child: MaterialApp(
              onGenerateRoute: RouteGenerator.generateRoute,
              title: 'Pomod\'or',
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              home: Home(),
              initialRoute: '/page1',
            ),
          );
      },
    );
  }
  Future _initApp() async {
    final taskList = await loadTaskList();
    TaskList.instance.setTasks(taskList);
  }
}
