import 'package:flutter/material.dart';
import 'package:pomodor/screens/Home.dart';
import 'package:pomodor/screens/RouteGenerator.dart';


void main() {
  runApp(const MyApp());
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
      //initialRoute: '/page1',
      );
  }
}