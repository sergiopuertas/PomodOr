import 'dart:async';
import 'package:flutter/material.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({Key? key}) : super(key: key);

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int _counter = 0;
  late Timer _timer;
  bool _timerRunning = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Temps écoulé : '),
          Text('$_counter seconds'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  // Action à effectuer lorsque le bouton est pressé
                  // Ici, vous pouvez mettre le code pour arrêter le timer
                  _timer.cancel();
                  setState(() {
                    _timerRunning = false;
                    _counter = 0;
                  });
                },
                icon: Icon(Icons.stop),
              ),
              IconButton(
                icon: _timerRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                onPressed: () {
                  // Toggle le timer entre démarrer et mettre en pause
                  if (_timerRunning) {
                    _timer.cancel();
                  } else {
                    startTimer();
                  }
                  setState(() {
                    _timerRunning = !_timerRunning;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter++;
      });
    });
  }

  @override
  void dispose() {
    // Arrêtez le timer lorsque la page est détruite pour éviter des fuites de mémoire
    _timer.cancel();
    super.dispose();
  }
}
