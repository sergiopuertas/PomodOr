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
import 'dart:math';
import 'dart:async';


class WorkTime extends StatefulWidget {
  @override
  _WorkTimeState createState() => _WorkTimeState();
}

class _WorkTimeState extends State<WorkTime> {
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
                              Navigator.popAndPushNamed(context,'/page1');
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
                'Work!',
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
              SizedBox(
                height: 150,
                width: 450,
                child: TaskListItem(list: studyList),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DeleteButton(),
                  AddMoreButton(
                    list: additions(context, studyList),
                    onAdd: addTaskToStudyList,
                  ),
                  FinishButton(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )
      ),
    );
  }
}
class AddMoreButton extends StatelessWidget {
  final List<Task> list;
  final Function(Task) onAdd;

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
    Provider.of<TaskList>(context, listen: false).changeChoosingProcess(true);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children :<Widget> [
                  SizedBox(
                    height: 600,
                    child: TaskListItem(list:list),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      submitButton(
                        text: "Add tasks",
                        function:()=> addAndReturn(context,list),
                        color: Colors.white,
                        size: 18.0,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      submitButton(
                        text: "Return",
                        function:()=> Navigator.pop(context),
                        color: Colors.black,
                        size: 18.0,
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
  void addAndReturn(BuildContext context, List<Task> list) {
    if (tasksChosen(list)) {
      for (var task in list) {
        if (task.getIfChosen()) {
          onAdd(task);
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<TaskList>(context, listen: false).unchooseTasks();
      });
      Navigator.pop(context);
    } else {
      showTemporaryDialog(context);
    }
    Provider.of<TaskList>(context, listen: false).changeChoosingProcess(false);
  }

}