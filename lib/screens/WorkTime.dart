import 'package:flutter/material.dart';
import 'package:pomodor/toDoList/TaskList.dart';
import 'package:pomodor/Timer/clocl_view.dart';

import 'dart:math';

class WorkTime extends StatelessWidget{
  const WorkTime({super.key});
   @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title : const Text('WORK !'),
      ),
      body : Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
              height: 504,
              width: 500,
              child: ClockViewWidget(),
          ),
          SizedBox(
            height: 200,
            width: 450,
            child: TaskListItem(),
          ),
          SizedBox(
            height: 40,
            width: 500,
          ),
        ],
      )
    );
  }

}