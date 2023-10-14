import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'task.dart';

void main() {
  runApp(MaterialApp(
    home: TaskList(),
    )
  );
}

class TaskList extends StatefulWidget {
  static final TaskList _singleton = TaskList._internal();

  factory TaskList() {
    return _singleton;
  }
  TaskList._internal();
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<String> _subjectList = ['md', 'so'];

  /*List<Task> _tasks = [];

  void addTask(String name, var expDate, int diff, String subject) {
    //mirar si ya hay una instancia de esa task y lo de null y tal
    Task task = new Task(name, expDate, diff, subject);
    _tasks.add(task);
  }
  void removeTask(Task task) {
    _tasks.remove(task);
  }
  List<Task> getTaskList(){
    return this._tasks;
  }
  List<String> getSubjectList(){
    return this._subjectList;
  }
  void order(var param){
    _tasks.sort((task1, task2) => task1.param.compareTo(task2.param));
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children:<Widget>[
          SizedBox(height: 40.0),
          Column(
            children:_subjectList.map((subj) => Text(subj)
            ).toList(),
          )
        ]
      ),
    );
  }
}