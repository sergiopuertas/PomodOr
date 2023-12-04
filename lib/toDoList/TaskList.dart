import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomodor/notifications.dart';
import 'dart:convert';
import 'dart:math';
import 'Task.dart';
import 'SortingStrategy.dart';

import 'MyCheckBox.dart';
import 'package:pomodor/auxiliar.dart';

Future<void> saveTaskList(List<Task> tasks) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> stringList = tasks.map((task) => jsonEncode(task.toJson())).toList();
  await prefs.setStringList('taskList', stringList);
}

Future<List<Task>> loadTaskList() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? stringList = prefs.getStringList('taskList');
  if (stringList != null) {
    return stringList.map((taskJson) => Task.fromJson(jsonDecode(taskJson))).toList();
  } else {
    return [];
  }
}
class TaskListItem extends StatelessWidget {
  final List<Task> list;
  const TaskListItem({required this.list});

  Widget build(BuildContext context) {
    ConstantScrollBehavior scrollBehavior = ConstantScrollBehavior();
    var tasks = list;
    return ScrollConfiguration(

      behavior: scrollBehavior,
      child: SingleChildScrollView(

        child: Column(
          children: tasks.map((task) => TaskItem(task: task)).toList(),
        ),
      ),
    );
  }
}

class TaskList with ChangeNotifier {
  static final TaskList _instance = TaskList._internal();

  TaskList._internal() {
    _tasks = <Task>[];
  }
  static TaskList get instance => _instance;

  List<Task> _tasks = [];
  List<Task> get getTaskList => _tasks;

  bool _showMenu = false;
  bool get getShowMenu => _showMenu;
  String _currentOrder = 'expDate';
  String get getCurrentOrder => _currentOrder;

  void setTasks(List<Task> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void saveTasks() async {
    await saveTaskList(_tasks);
    notifyListeners();
  }

  void loadTasks() async {
    _tasks = await loadTaskList();
    notifyListeners();
  }


  void showMenu(bool value){
    _showMenu = value;
  }

  void addTask(String name, DateTime expDate, int diff, String subject) {
    Task task = Task(name, subject, expDate, diff);
    _tasks.add(task);
    scheduleNotification(task);
    order(this._currentOrder);
    saveTasks();
    notifyListeners();
  }
  void editTask(Task task, String name, DateTime expDate, int diff, String subj) {
    bool changedDate = false;
    if (task.getDate.difference(expDate) != 0){
      cancelTaskNotification(task);
      changedDate = true;
    }
    task.setDate(expDate);
    task.setDiff(diff);
    task.setName(name);
    task.setSubject(subj);
    task.setUrgency(expDate, diff);

    if(changedDate) scheduleNotification(task);
    order(this._currentOrder);
    saveTasks();
    notifyListeners();
  }

  String calculateCompletedTaskPercentage() {
    int returns;
    if (_tasks.isEmpty) {
      returns =  0;
    }
    else{
      int completedTasks = _tasks.where((task) => task.getIfFinished).length;
      returns = ((completedTasks / _tasks.length) * 100).ceil();
    }
    return 'Tasks completed: ' + returns.toString() + '%';
  }
  void order(String orderType) {
    SortingStrategy strategy = SortingStrategyFactory.getSortingStrategy(orderType);
    this.getTaskList.sort(strategy.compare);
    _currentOrder = orderType;
    notifyListeners();
  }
  void toggleTask(Task task) {
    task.toggleFinished();
    notifyListeners();
  }
  void toggleChosen(Task task) {
    task.setChosen();
    notifyListeners();
  }
  void deleteTasks() {
    List<Task> tasksToRemove = [];
    for (var task in _tasks) {
      if (task.getIfChosen) {
        tasksToRemove.add(task);
      }
    }
    for (var task in tasksToRemove) {
      _tasks.remove(task);
      cancelTaskNotification(task);
    }
    saveTasks();
    notifyListeners();
  }
  void unchooseTasks() {
    for (var task in _tasks) {
      if (task.getIfChosen) {
        task.setChosen();
      }
    }
    saveTasks();
    notifyListeners();
  }
  void finishTasks(){
    _tasks.forEach((task) {
      if(task.getIfChosen){
        toggleTask(task);
      }
    });
  }
}