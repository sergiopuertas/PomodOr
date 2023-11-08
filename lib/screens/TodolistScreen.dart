import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../toDoList/TaskList.dart';
import '../toDoList/MyCheckBox.dart';
import '../toDoList/AddPopUp.dart';
import '../toDoList/Task.dart';
import '../toDoList/ConstantScrollBehaviour.dart';
import '../toDoList/SortingStrategy.dart';

class todolistScreen extends StatelessWidget {
  const todolistScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var taskList = Provider.of<TaskList>(context);
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
                  taskList.order('expDate');
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
                  taskList.order('default');
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
                  taskList.order('expDate');
                }
              ),
              ],
              ),
              Container(
                height:540,
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
                child: TaskListItem(),
              ),
              Container(
                height: 130,
                padding: EdgeInsets.fromLTRB(350, 0.0, 0.0, 0.0),
                child:
                  AddPopUp(),
              )
            ],
          ),
          bottomNavigationBar: Container(
              color : Colors.white,
              height : 90.0,
              alignment : Alignment.center,
              child : BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.list),
                      onPressed: null,
                      iconSize: 40.0,
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed:null,
                      iconSize: 40.0,
                    ),
                    IconButton(
                      icon : Icon(Icons.music_note),
                      onPressed: null,
                      iconSize: 40.0,
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: null,
                      iconSize: 40.0,
                    ),
                  ],
                ),
              )
          ),
        ),
      ],
    );
  }
}

