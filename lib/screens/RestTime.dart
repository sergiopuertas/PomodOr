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
import 'package:pomodor/Timer/clocl_view.dart';
import 'package:pomodor/auxiliar.dart';
import 'dart:math';
import 'dart:async';


class RestTime extends StatefulWidget {
  @override
  _RestTimeState createState() => _RestTimeState();
}

class _RestTimeState extends State<RestTime> {
  List<Task> studyList = [];

  @override
  void initState() {
    super.initState();
    studyList = studyTasks(context);
  }

  void addTaskToStudyList(Task task) {
    setState(() {
      studyList.add(task);
    });
  }
  Widget build(BuildContext context) {
    var taskList = Provider.of<TaskList>(context,listen: false);
    taskList.changeChoosingProcess(false);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
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
                              Navigator.pushNamed(context, '/page1');
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 504,
                width: 500,
                child: ClockViewWidget(),
              ),
            ],
          )
      ),
    );
  }
}
