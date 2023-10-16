import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'Task.dart';
import 'tasksProvider.dart'

class TaskListItem extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);

    return Column(
      children: tasks.map(
            (task) => TaskItem(task: task),
      )
          .toList(),
    );
  }
}
class TaskList{
  List<String> _subjectList = ['md', 'so'];
  List<Task> _tasks = [];

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
}
