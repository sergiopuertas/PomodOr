import 'package:flutter/material.dart';
import 'Task.dart';
//import 'Notes.dart';
import 'TaskList.dart';
import 'MyCheckBox.dart';
/*
void main() {
  runApp(const SlidingList());
}

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // This is the theme of your application.
      theme: ThemeData.dark(),
      scrollBehavior: const ConstantScrollBehavior(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
          backgroundColor: Colors.teal[800],
        ),
        body: const WeeklyForecastList(),
      ),
    );
  }
}*/

class SlidingList extends StatelessWidget {
  const SlidingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TaskList tasks = TaskList();
    tasks.addTask('MediaQuery', '11/12/2023', 3, 'MD');
    tasks.addTask('TEMA 2', '11/12/2023', 1, 'MD');
    tasks.addTask('TEMA 4', '11/12/2025', 1, 'MD');
    tasks.addTask('TEMA 5', '11/12/2025', 1, 'MD');
    tasks.addTask('TEMA 6', '11/12/2025', 1, 'MD');
    tasks.addTask('TEMA 7', '11/12/2025', 1, 'MD');
    tasks.addTask('TEMA 8', '11/12/2025', 1, 'MD');

    return SingleChildScrollView(
      child: Column(
        children: tasks.getTaskList().map((task) {
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
                ]
              ),
              trailing: Text(
                'notas',
                style: TextStyle(
                  color: fitColor(task),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                /*FloatingActionButton(
                  onPressed: MyCustomForm(),
                  child: const Icon(Icons.textsms_rounded),
                ),*/
              ),
            ),
          );
        }
        ).toList(),
      ),
    );
  }
}

// --------------------------------------------
// Below this line are helper classes and data.
String dateFormat(Task task){
  return task.getDate().day.toString() + "/" +task.getDate().month.toString() +"/" + task.getDate().year.toString();
}
Color fitColor(Task task){
  if (task.getUrgency().number == 2) return Colors.black;
  else return Colors.white;
}
class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
