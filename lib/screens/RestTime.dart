import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskChoosing.dart';
import 'package:pomodor/screens/WorkTime.dart';
import 'package:pomodor/toDoList/PopUps/submitButton.dart';
import 'package:pomodor/screens/TodolistScreen.dart';
import 'package:pomodor/screens/TaskChoosing.dart';
import 'package:pomodor/toDoList/Task.dart';
import 'package:pomodor/toDoList/TaskList.dart';
import 'package:pomodor/toDoList/PopUps/BasePopUp.dart';
import 'package:pomodor/Timer/clock_view.dart';
import 'package:pomodor/auxiliar.dart';
import 'package:pomodor/Timer/timer_mode.dart';
import 'package:pomodor/music.dart';
import 'dart:math';
import 'dart:async';


class RestTime extends StatefulWidget {
  @override
  _RestTimeState createState() => _RestTimeState();
}

class _RestTimeState extends State<RestTime> {

  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    var timerMode = Provider.of<TimerMode>(context, listen: false);
    var taskList = Provider.of<TaskList>(context,listen: false);
    taskList.showMenu(false);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              toolbarHeight:  MediaQuery.of(context).size.height/9,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder:(BuildContext context) {
                        return AlertDialog(
                          content: const Text(
                              "Are you sure you want to finish the session?"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("Yes"),
                              onPressed: () {
                                timerMode.endSession(context, false);
                                Navigator.popAndPushNamed(context, '/page1');
                              },
                            ),
                            TextButton(
                              child: const Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      }
                  );
                },
              ),
              title: Text(
                'Rest!',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child:  Column(
                      children: [
                        ClockView(initialTime: Provider.of<TimerMode>(context).initialWorkTime),
                        Center(
                          child: Text('Cycle number ${timerMode.completedCycles+1} '),
                        ),
                      ],
                    )
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      timerMode.motivationalSentences[timerMode.sentenceIndex],
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Music()
        ],
      )
    );
  }
}
