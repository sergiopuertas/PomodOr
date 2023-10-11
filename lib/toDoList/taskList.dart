import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'task.dart';
import 'lib/toDoList/orders/order.dart';

class TaskList {
  var order _currentOrder;
  static final TaskList _singleton = TaskList._internal();

  factory TaskList() {
    return _singleton;
  }

  TaskList._internal();

  List<Task> _tasks = [];
  List<String> _subjectList = [];

  List<Tasks> selectOrder(order selectedOrder){
    this._currentOrder = selectedOrder;
  }
  void addTask(Task task) {
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


}
