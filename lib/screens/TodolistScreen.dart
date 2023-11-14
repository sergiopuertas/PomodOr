import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../toDoList/TaskList.dart';
import '../toDoList/MyCheckBox.dart';
import '../toDoList/PopUps.dart';
import '../toDoList/Task.dart';
import '../toDoList/ConstantScrollBehaviour.dart';
import '../toDoList/SortingStrategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class todolistScreen extends StatelessWidget {
  const todolistScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var taskList = Provider.of<TaskList>(context);
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: null,
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
            elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  taskList.calculateCompletedTaskPercentage(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              OverflowBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                TextButton( child: const Text(
                'Date',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ), onPressed: () {
                  taskList.order('expDate');
                }
              ),
                TextButton( child: const Text(
                'Urgency',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ), onPressed: () {
                  taskList.order('default');
                }
              ),
                TextButton(
                    child: const Text(
                    'Subject',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                ),
              ), onPressed: () {
                  taskList.order('expDate');
                }
              ),
              ],
              ),
              Container(
                height:695,
                child: TaskListItem(),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 810,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AddPopup(),
              ],
            )
          ]
        ),
      ],
    );
    }
}

