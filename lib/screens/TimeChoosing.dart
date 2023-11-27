import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodor/auxiliar.dart';
import '../toDoList/TaskList.dart';
import '../toDoList/Task.dart';
import '../toDoList/SortingStrategy.dart';
import '../toDoList/PopUps/BasePopUp.dart';
import '../toDoList/PopUps/submitButton.dart';
import '../Timer/clock_view.dart';
import 'dart:async';

class TimeChoosing extends StatelessWidget {
  TimeChoosing({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar:AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            flexibleSpace: Column(
              children:<Widget> [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'CHOOSE THE TIME\nDISTRIBUTION',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 560,
                child: ClockViewWidget(),
              ),
              SizedBox(
                height: 10,
              ),
              submitButton(text: "Let's go",function:()=> workAnnouncement(context) ,color: Colors.amber[600] as Color , size: 25.0)
            ],
          ),
        ),
      ],
    );
  }
}
