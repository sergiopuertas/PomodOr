import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../toDoList/TaskList.dart';
import '../toDoList/MyCheckBox.dart';
import '../toDoList/PopUps/BasePopUp.dart';
import '../toDoList/Task.dart';
import '../toDoList/SortingStrategy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomodor/auxiliar.dart';
import 'package:pomodor/music.dart';

class todolistScreen extends StatelessWidget {
  const todolistScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var taskList = Provider.of<TaskList>(context);
    taskList.showMenu(true);
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
                'TO-DO LIST  ',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 48,
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
                    taskList.order('urgency');
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
                    taskList.order('subject');
                  }
                  ),
                ],
              ),
              Expanded(
                child: TaskListItem(list: taskList.getTaskList),
              ),
            ],
          ),
        ),
        Positioned( //
          bottom: 50,
          left: 15,
          right: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DeleteButton(),
              AddPopup(),
              FinishButton(),
            ],
          ),
        ),
      ],
    );
  }
}
class FinishButton extends StatelessWidget{
  const FinishButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var taskList = Provider.of<TaskList>(context);
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Colors.green,
      onPressed: tasksChosen(taskList.getTaskList) ? () {
        taskList.finishTasks();
        taskList.order(taskList.getCurrentOrder);
        taskList.unchooseTasks();
      } : null,
      child: Icon(
        Icons.star,
        color: Colors.white,
      ),
    );
  }
}
class DeleteButton extends StatelessWidget{
  const DeleteButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var taskList = Provider.of<TaskList>(context);
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Colors.red,
      onPressed: tasksChosen(taskList.getTaskList) ? () =>
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm Delete"),
                content: const Text("Are you sure you want to delete?"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      taskList.unchooseTasks();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("Delete"),
                    onPressed: () {
                      // Implement your delete logic here
                      taskList.deleteTasks();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ) : null,
      child: Icon(
        Icons.delete_forever,
        color: Colors.white,
      ),
    );
  }
}