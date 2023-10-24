import 'package:flutter/material.dart';
import '../Task.dart';
import '../Lists/TaskList.dart';
import '../MyCheckBox.dart';
import 'ConstantScrollBehaviour.dart';

class SlidingTaskList extends StatefulWidget {
  final TaskList taskList;
  const SlidingTaskList({required this.taskList}) ;
  @override
  _SlidingTaskListState createState() => _SlidingTaskListState(taskList: taskList);
}

class _SlidingTaskListState extends State<SlidingTaskList> {
  final DateTime currentDate = DateTime.now();
  final TaskList taskList;
  ConstantScrollBehavior scrollBehavior = ConstantScrollBehavior();
  _SlidingTaskListState({required this.taskList});
  @override
  void initState() {
    super.initState();
    // Initialize your task list here
    taskList.addTask('TEMA 1', '11/12/2023', 3, 'MD');
    taskList.addTask('TEMA 2', '11/12/2023', 0, 'MD');
    taskList.addTask('TEMA 4', '11/12/2025', 0, 'MD');
    taskList.addTask('TEMA 5', '11/12/2025', 0, 'MD');
    taskList.addTask('TEMA 6', '11/12/2025', 1, 'MD');
    taskList.addTask('TEMA 7', '11/12/2025', 1, 'MD');
    taskList.addTask('TEMA 8', '11/12/2025', 1, 'MD');
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: scrollBehavior,
      child: SingleChildScrollView(
        child: Column(
          children: taskList.getTaskList().map((task) {
            return Card(
              child: ListTile(
                leading: MyCheckBox(),
                title: Text(
                  task.getName(),
                  style: TextStyle(
                    color: fitColor(task),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                tileColor: task.getUrgency().color,
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      task.getSubject(),
                      style: TextStyle(
                        color: fitColor(task),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      dateFormat(task),
                      style: TextStyle(
                        color: fitColor(task),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: SizedBox(
                  width: 120, // Ajusta el ancho según tus necesidades
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Handle notes button press
                        },
                        child: Text(
                          'notas',
                          style: TextStyle(
                            color: fitColor(task),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          taskList.removeTask(task);
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.delete_forever,
                        ),
                      )
                    ],
                  ),
                ),
              )

            );
          }).toList(),
        ),
      ),
    );
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
    if (task != null && task.getUrgency().number == 2) return Colors.black;
    return Colors.white;
  }
}

