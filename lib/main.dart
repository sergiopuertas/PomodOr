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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(MyApp());
  });
}
Future<void> initNotifications() async {
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    //initNotifications();
    return FutureBuilder(
      future: _initApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: CircularProgressIndicator());
        } else {
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
        }
      },
    );
  }
  Future _initApp() async {
    final taskList = await loadTaskList();
    TaskList.instance.setTasks(taskList);
  }
}
