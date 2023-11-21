import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../toDoList/TaskList.dart';
import '../toDoList/MyCheckBox.dart';
import '../toDoList/PopUps/BasePopUp.dart';
import '../toDoList/Task.dart';
import '../toDoList/ConstantScrollBehaviour.dart';
import '../toDoList/SortingStrategy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomodor/auxiliar.dart';

class todolistScreen extends StatelessWidget {
  const todolistScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var taskList = Provider.of<TaskList>(context);
    taskList.changeChoosingProcess(false);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child:Stack(
        children: [
          Container(
            color: Colors.white,
            child: null,
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
                  Navigator.pushNamed(context, '/page1');
                },
              ),
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
                Container(
                  height:695,
                  child: TaskListItem(list: taskList.getTaskList()),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DeleteButton(),
                    AddPopup(),
                    FinishButton(),
                  ],
                )
              ]
          ),
        ],
      )
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
      onPressed: () {
        taskList.finishTasks();
        taskList.order(taskList.getCurrentOrder());
        taskList.unchooseTasks();
      },
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
      onPressed: () =>
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
          ),
      child: Icon(
        Icons.delete_forever,
        color: Colors.white,
      ),
    );
  }
}