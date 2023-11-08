import 'package:flutter/material.dart';
import 'HomeBody.dart';
import 'TodolistScreen.dart';
import 'RouteGenerator.dart';
import 'StartSession.dart';

class Home extends StatefulWidget{
  const Home({super.key});
  @override
  _PomodoroHomeState createState() => _PomodoroHomeState();
}

class _PomodoroHomeState extends State<Home>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 125, // Set this height
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
          child: Text(
            'WELCOME TO\n POMOD''\'OR!!',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // <-- ELEVATION ZEROED
      ),
      body : StartSession(),
      bottomNavigationBar: Container(
        color : Colors.white,
        height : 90.0,
        alignment : Alignment.center,
        child : BottomAppBar(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: (){
                Navigator.pushNamed(context, '/page6');
              },
              iconSize: 40.0,
            ),
            IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed:null,
              iconSize: 40.0,
            ),
            IconButton(
              icon : Icon(Icons.music_note),
              onPressed: null,
              iconSize: 40.0,
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: null,
              iconSize: 40.0,
            ),
          ],
        ),
        )
      ),
    );
  }
}