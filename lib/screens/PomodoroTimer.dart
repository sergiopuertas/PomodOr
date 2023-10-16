import 'dart:async';
import 'package:flutter/material.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer>{
  int _counter = 0;
  late Timer _timer;



  void startTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      setState((){
        _counter++;
      });
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text('Timer'),
      ),
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Temps écoulé : '),
            Text('$_counter seconds'), 
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                icon: Icon(Icons.stop),
                onPressed: null,
                ),
                IconButton(
                icon: Icon(Icons.pause),
                onPressed: null,
                ),
             ]
            )


          ]
        ),
      )
    );
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }
}