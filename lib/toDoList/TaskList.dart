import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Task.dart';
import 'SortingStrategy.dart';
import 'ConstantScrollBehaviour.dart';
import 'MyCheckBox.dart';

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
  static final TaskList _instance = TaskList._internal();
  TaskList._internal() {
    _tasks = <Task>[];
  }
  static TaskList get instance => _instance;

  List<Task> _tasks = [];

  void addTask(String name, DateTime expDate, int diff, String subject) {
    Task task = Task(name, subject, expDate, diff);
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
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

