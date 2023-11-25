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
  List<Task> tasks = [];
  for (var task in  Provider.of<TaskList>(context, listen: false).getTaskList()) {
    if (!task.getIfFinished()) {
      tasks.add(task);
    }
  }
  return tasks;
}
bool tasksChosen(List<Task> tasks){
  for (var task in  tasks) {
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
Future<void> showBigDialog(BuildContext context, String text, int time) async {
  bool isDialogOpen = true;
  showDialog(
    context: context,
    barrierDismissible: false, // Cambiar a false para evitar cierre manual
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height-93,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.amber[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  await Future.delayed(Duration(seconds: time));
  if (isDialogOpen && Navigator.of(context).canPop()) {
    isDialogOpen = false;
    Navigator.of(context).pop();
  }
}
Future<void> workAnnouncement(BuildContext context) async {
  await showBigDialog(context, "You are going to start your study session", 4);
  await showBigDialog(context, 'Please get rid of any distracting device and turn off your notifications', 4);
  await showBigDialog(context, "Good results require focus and discipline", 4);
  await showBigDialog(context, "Good luck!", 3);
  Navigator.pushNamed(context, '/page3');
}
Future<void> restAnnouncement(BuildContext context) async { // cuando acabe el study mode
  await showBigDialog(context, "Well done!\nYou have ended your studying round", 4);
  await showBigDialog(context, 'You may now get up and relax', 4);
  await showBigDialog(context, 'Go get some water, food\n or to the toilet if needed', 4);
  await showBigDialog(context, 'See you soon...', 2);
  Navigator.pushNamed(context, '/page4');
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
class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}

