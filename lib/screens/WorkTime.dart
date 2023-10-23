import 'package:flutter/material.dart';
import 'package:pomodor/screens/PomodoroTimer.dart';


class WorkTime extends StatelessWidget{
  const WorkTime({super.key});

   @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text('WORK !'),
      ),
      body : PomodoroTimer(),
    );
  }

}