import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodor/auxiliar.dart';
import '../toDoList/TaskList.dart';
import '../toDoList/Task.dart';
import '../toDoList/SortingStrategy.dart';
import '../toDoList/PopUps/BasePopUp.dart';
import '../toDoList/PopUps/submitButton.dart';
import 'dart:async';

class TaskChoosing extends StatelessWidget {
  TaskChoosing({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var taskList = Provider.of<TaskList>(context);
    taskList.showMenu(false);
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'CHOOSE THE TASKS',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "YOU'D LIKE TO TACKLE",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            toolbarHeight:  MediaQuery.of(context).size.height/9,
          ),
          body: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Expanded(
                child: TaskListItem(list: uncompletedTasks(context)),
              ),
              submitButton(
                text: 'Continue without tasks',
                function: () => Continue(context, true),
                color: Colors.grey,
                textColor: Colors.white,
                size: 12,
              ),
              SizedBox(height: 10),
              submitButton(
                text: "Continue",
                function: () => Continue(context, false),
                color: Colors.amber[600]!,
                textColor: Colors.black,
                size: 25.0,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
  void Continue(BuildContext context, bool empty){
    var taskList = Provider.of<TaskList>(context, listen: false);
    if(empty) {
      taskList.unchooseTasks();
      Navigator.pushNamed(context, '/page5');
    }
    else {
      studyTasks(context,true);
      tasksChosen(uncompletedTasks(context)) ? Navigator.pushNamed(context, '/page5') : showTemporaryDialog(context);
      taskList.unchooseTasks();
    }
  }
}