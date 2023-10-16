import 'package:flutter/material.dart';
import 'PomodoroTimer.dart';

class PomodoroBody extends StatelessWidget{
  const PomodoroBody({super.key});

  @override
  Widget build(BuildContext context){
    return const Column(
      children: <Widget>[
        Flexible(child: PomodoroTimer())
      ],
    );
    
  }
}