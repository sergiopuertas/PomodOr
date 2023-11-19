import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskChoosing.dart';
import 'package:pomodor/toDoList/Task.dart';
import 'package:pomodor/toDoList/TaskList.dart';
import 'package:pomodor/Timer/clocl_view.dart';

import 'dart:math';

class WorkTime extends StatelessWidget{
  const WorkTime({super.key});
   @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title : const Text('WORK !'),
      ),
      body : Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
              height: 504,
              width: 500,
              child: ClockViewWidget(),
          ),
          SizedBox(
            height: 150,
            width: 450,
            child: TaskListItem(list: studyTasks(context)),
          ),
        ],
      )
    );
  }
  List<Task> studyTasks(BuildContext context) {
    List<Task> tasksToStudy = [];
    for (var task in  Provider.of<TaskList>(context, listen: false).getTaskList()) {
      if (task.getIfChosen()) {
        tasksToStudy.add(task);
      }
    }
    return tasksToStudy;
  }

}