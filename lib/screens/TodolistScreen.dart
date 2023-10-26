import 'package:flutter/material.dart';
import '../toDoList/Lists/TaskList.dart';
import '../toDoList/SlidingLists/SlidingTaskList.dart';
import '../toDoList/MyCheckBox.dart';
import '../toDoList/AddPopUp.dart';
import '../toDoList/SlidingLists/ConstantScrollBehaviour.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     scrollBehavior: const ConstantScrollBehavior(),
//     home: todolistScreen(),
//   )
//   );
// }

class todolistScreen extends StatefulWidget {
  const todolistScreen({super.key});
  @override
  State<todolistScreen> createState() => _todolistScreenState();
}

class _todolistScreenState extends State<todolistScreen> {
  final TaskList taskList = new TaskList();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image:
            DecorationImage(
              image: AssetImage('assets/papel.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child:
          null,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'TO-DO LIST',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0, // <-- ELEVATION ZEROED
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              OverflowBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                TextButton( child: const Text(
                'Date',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ), onPressed: () {
                // list.selectOrder(dateOrder);
              }
              ),
                TextButton( child: const Text(
                'Urgency',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ), onPressed: () {
                // list.selectOrder(urgencyOrder);
              }
              ),
                TextButton(
                    child: const Text(
                    'Subject',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                ),
              ), onPressed: () {
                // list.selectOrder(urgencyOrder);
                }
              ),
              ],
              ),
              Container(
                height:600,
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
                child: SlidingTaskList(taskList: taskList),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(350, 0.0, 0.0, 60.0),
                child: AddPopUp(taskList: taskList),
              )
            ],
          ),
        ),
        ],
    );
  }
}
