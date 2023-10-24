import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../Task.dart';
import '../Providers/tasksProvider.dart';

//enum Order = {_expDate,_subject,_name, _urgency};

class TaskListItem extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);
    return Column(
      children: tasks.map(
            (task) => TaskItem(task: task),
      ).toList(),
    );
  }
}
class TaskList{
  List<String> _subjectList = [""];
  List<Task> _tasks = [new Task("","",DateTime.now(),0)];
  //Order _currentOrder;

  TaskList(){
    this._subjectList = [];
    this._tasks = [];
  }
  void addTask(String name, String expDate, int diff, String subject) {
    DateTime formatted = DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).parse(expDate);
    Task task = Task(name, subject,formatted, diff);
    this._tasks.add(task);
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
  /*void order(var order){
    this._currentOrder = order;
    _tasks.sort((task1, task2) => task1.order.compareTo(task2.order));
  }*/
}
