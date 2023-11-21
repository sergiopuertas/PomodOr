import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodor/toDoList/Task.dart';
import 'package:pomodor/toDoList/TaskList.dart';
import 'package:pomodor/toDoList/PopUps/BasePopUp.dart';
import 'package:pomodor/toDoList/SortingStrategy.dart';
import 'dart:async';
import 'dart:math';
import 'dart:convert';

List<Task> studyTasks(BuildContext context) {
  List<Task> tasksToStudy = [];
  TaskList tasklist = Provider.of<TaskList>(context, listen: false);
  for (var task in  tasklist.getTaskList()) {
    if (task.getIfChosen() && !task.getIfFinished()) {
      tasksToStudy.add(task);
    }
  }
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<TaskList>(context, listen: false).unchooseTasks();
  });
  return tasksToStudy;
}

List<Task> additions(BuildContext context,List<Task> study ) {
  List<Task> uncompleted = uncompletedTasks(context);
  uncompleted.removeWhere((task) => study.contains(task));
  return uncompleted;
}
List<Task> uncompletedTasks(BuildContext context) {
  List<Task> tasksToStudy = [];
  for (var task in  Provider.of<TaskList>(context, listen: false).getTaskList()) {
    if (!task.getIfFinished()) {
      tasksToStudy.add(task);
    }
  }
  return tasksToStudy;
}
bool tasksChosen(List<Task> tasksToStudy){
  for (var task in  tasksToStudy) {
    if (task.getIfChosen()) {
      return true;
    }
  }
  return false;
}

void showTemporaryDialog(BuildContext context) {
  bool isDialogOpen = true;
  showDialog(
    barrierColor: Colors.transparent,
    context: context,
    barrierDismissible: false, // Evita que el diálogo se cierre al tocar fuera
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async => false, // Evita que se cierre con el botón de atrás
          child: AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
              "Please, choose any task",
              style: TextStyle(color: Colors.red),
            ),
          )
      );
    },
  );
  Timer(Duration(seconds: 1), () {
    if (isDialogOpen && Navigator.of(context).canPop()) {
      isDialogOpen = false;
      Navigator.of(context).pop();
    }
  });
}
bool isGoodName(String txt) {
  return txt.isNotEmpty;
}

bool isGoodSubject(String txt) {
  return txt.isNotEmpty;
}
String dateFormat(Task task) {
  if (task != null) {
    return task.getDate().day.toString() +
        "/" +
        task.getDate().month.toString() +
        "/" +
        task.getDate().year.toString();
  } else {
    return 'Date Missing';
  }
}
Color fitColor(Task task) {
  if (task != null && task.getUrgency().getNumber() == 2) return Colors.black;
  return Colors.white;
}


