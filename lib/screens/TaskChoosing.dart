import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../toDoList/TaskList.dart';
import '../toDoList/Task.dart';
import '../toDoList/ConstantScrollBehaviour.dart';
import '../toDoList/SortingStrategy.dart';

class TaskChoosing extends StatelessWidget{
  const TaskChoosing({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        Container(
          color: Colors.white,
          child: null,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body:
            Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'CHOOSE THE TASKS',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'YOU''\'D LIKE TO TACKLE',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 620,
                    child: TaskListItem(list: Provider.of<TaskList>(context, listen: false).getTaskList()),
                  ),
                  InkWell(
                      onTap: () {
                        //Provider.of<TaskList>(context, listen: false).selectChosen();

                        Navigator.pushNamed(context, '/page7');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width -10,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 25.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          "Let's GO!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
    );
  }
}
