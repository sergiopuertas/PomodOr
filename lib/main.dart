import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodor/screens/Home.dart';
import 'package:pomodor/screens/RouteGenerator.dart';
import 'toDoList/TaskList.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskList.instance,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      title : 'Pomod\'or',
      debugShowCheckedModeBanner: false,
      theme : ThemeData.light(),
      home: Home(),
      initialRoute: '/page1',
    );
  }
}