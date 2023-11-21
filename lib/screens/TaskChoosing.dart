import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodor/auxiliar.dart';
import '../toDoList/TaskList.dart';
import '../toDoList/Task.dart';
import '../toDoList/ConstantScrollBehaviour.dart';
import '../toDoList/SortingStrategy.dart';
import '../toDoList/PopUps/BasePopUp.dart';
import '../toDoList/PopUps/submitButton.dart';

import 'dart:async';

class TaskChoosing extends StatelessWidget {
  TaskChoosing({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Provider.of<TaskList>(context, listen: false).changeChoosingProcess(true);
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        Container(
          color: Colors.white,
          child: null,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body:
          Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Text(
                'CHOOSE THE TASKS',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'YOU''\'D LIKE TO TACKLE',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 620,
                child: TaskListItem(list: uncompletedTasks(context)),
              ),
              submitButton(text: "Let's go!",function:()=> letsGo(context),color: Colors.red, size: 25.0)
            ],
          ),
        ),
      ],
    );
  }
  void letsGo(BuildContext context){
    tasksChosen(uncompletedTasks(context)) ? Navigator.pushNamed(context, '/page7') : showTemporaryDialog(context);
  }
}