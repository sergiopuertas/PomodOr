import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskChoosing.dart';
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


class WorkTime extends StatefulWidget {
  @override
  _WorkTimeState createState() => _WorkTimeState();
}

class _WorkTimeState extends State<WorkTime> {
  @override
  void initState() {
    super.initState();
  }

  void addTasksToStudyList(BuildContext context) {
    setState(() {
      taskBeingStudied(context);
    });
  }

  Widget build(BuildContext context) {
    var taskList = Provider.of<TaskList>(context,listen: false);
    var timerMode = Provider.of<TimerMode>(context,listen: false);
    taskList.showMenu(false);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child : Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              toolbarHeight:  MediaQuery.of(context).size.height/9,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                            "Are you sure you want to finish the session?",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () {
                              timerMode.endSession(context, false);
                              Navigator.popAndPushNamed(context,'/page1');
                            },
                          ),
                          TextButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              title: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.235),
                  Text(
                    'Work!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30
                    ),
                  ),
                ],
              )
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    flex: 10,
                    child:  Column(
                      children: [
                        Center(
                          child: Text('Cycle number ${timerMode.completedCycles+1} '),
                        ),
                        ClockView(initialTime: timerMode.initialWorkTime),
                      ],
                    )
                ),
                Expanded(
                  flex: 4,
                  child: Consumer<TaskList>(builder: (context, taskList, child) {
                    return  TaskListItem(list: taskBeingStudied(context));
                    }
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          FloatingActionButton(
                              heroTag: null,
                              backgroundColor: Colors.deepOrange,
                              onPressed:()=> deleteAndReturn( context, taskBeingStudied(context)),
                              child: Icon(
                                Icons.visibility_outlined,
                                color: Colors.white,
                              ),
                            ),
                            Consumer<TaskList>(builder: (context, taskList, child) {
                              return  AddMoreButton(
                                list: additions(context, taskBeingStudied(context)),
                                onAdd:(context)=> addTasksToStudyList(context),
                              );
                            }
                            ),
                            FinishButton(),
                          ],
                        ),
                        SizedBox(height: 5)
                      ],
                    )
                )
              ],
            ),
          ),
          Music(home:false)
        ],
      ),
    );
  }
  void deleteAndReturn(BuildContext context, List<Task> list) {
    var taskList = Provider.of<TaskList>(context, listen: false);
    if (tasksChosen(list)) {
      for (var task in list) {
        if (task.getIfChosen) {
          task.setStudied(false);
        }
      }
      taskList.unchooseTasks();
      taskList.notifyListeners();
    }
  }

}
class AddMoreButton extends StatelessWidget {
  final List<Task> list;
  final Function(BuildContext) onAdd;

  AddMoreButton({Key? key, required this.list, required this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Colors.white,
      onPressed: () {
        showAddDialog(context, list);
      },
      child: Icon(Icons.add, color: Colors.black),
    );
  }

  void showAddDialog(BuildContext context, List<Task> list) {
    Provider.of<TaskList>(context, listen: false).showMenu(false);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.7),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children :<Widget> [
                  Expanded(
                    child: TaskListItem(list:list),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      submitButton(
                        text: "Add",
                        function:()=> addAndReturn(context),
                        color: Colors.amber[600] as Color,
                        textColor: Colors.black,
                        size: 20.0,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      submitButton(
                        text: "Return",
                        function:()=> Navigator.pop(context),
                        color: Colors.grey,
                        textColor: Colors.white,
                        size: 20.0,
                      ),
                    ],
                  )
                ]
            ),
          ),
        );
      },
    );
  }

  void addAndReturn(BuildContext context) {
    var taskList = Provider.of<TaskList>(context, listen: false);
    var list = taskList.getTaskList;
    if (tasksChosen(list)) {
      studyTasks(context, true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<TaskList>(context, listen: false).unchooseTasks();
      });
      onAdd(context);

      Navigator.pop(context);
    } else {
      showTemporaryDialog(context);

    }
    Provider.of<TaskList>(context, listen: false).showMenu(false);
  }
}