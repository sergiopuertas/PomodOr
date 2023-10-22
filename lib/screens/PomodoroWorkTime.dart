import 'package:flutter/material.dart';
import 'package:pomodor/screens/PomodoroTimer.dart';

class PomodoroWorkTime extends StatelessWidget{
  const PomodoroWorkTime({super.key});

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