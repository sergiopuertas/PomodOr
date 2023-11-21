import 'package:flutter/material.dart';
import 'HomeBody.dart';
import 'TodolistScreen.dart';
import 'RouteGenerator.dart';
import 'StartSession.dart';
import 'package:flutter/material.dart';
import 'package:pomodor/toDoList/PopUps/submitButton.dart';

class Home extends StatefulWidget{
  const Home({super.key});
  @override
  _PomodoroHomeState createState() => _PomodoroHomeState();
}

class _PomodoroHomeState extends State<Home>{
  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        Container(
          child:  Image(
              image: AssetImage('assets/back.jpeg'),
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
          )
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 125,
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
          body: Column(
            children:<Widget> [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20),
                child: Text(
                  '“The future belongs to those who believe in the beauty of their dreams.”',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 550,
                child: StartSession()
              ),
              submitButton(text: 'ToDo List', function:()=> Navigator.pushNamed(context, '/page6'), color: Colors.green, size: 25.0),
            ],
          ),
        )
      ]
    );
  }
}