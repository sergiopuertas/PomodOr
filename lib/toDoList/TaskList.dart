import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Task.dart';
import 'SortingStrategy.dart';
import 'ConstantScrollBehaviour.dart';
import 'MyCheckBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


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
  Widget build(BuildContext context) {
    ConstantScrollBehavior scrollBehavior = ConstantScrollBehavior();
    var tasks = Provider.of<TaskList>(context).getTaskList();
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
  static final TaskList _instance = TaskList._internal();

  TaskList._internal() {
    _tasks = <Task>[];
  }
  static TaskList get instance => _instance;

  List<Task> _tasks = [];

  void addTask(String name, DateTime expDate, int diff, String subject) {
    Task task = Task(name, subject, expDate, diff);
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    saveTasks();
    notifyListeners();
  }

  List<Task> getTaskList() {
    return List.unmodifiable(_tasks);
  }

  void order(String orderType) {
    SortingStrategy strategy = SortingStrategyFactory.getSortingStrategy(orderType);
    this.getTaskList().sort(strategy.compare);
    notifyListeners();
  }
  void toggleTask(Task task) {
    task.toggleFinished(); // Asumiendo que tienes un método así en la clase Task
    notifyListeners();
  }
}