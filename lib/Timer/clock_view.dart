import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodor/timer_mode.dart';
import 'time_selection_screen.dart';
import 'package:provider/provider.dart';



class ClockView extends StatefulWidget {
  final DateTime initialTime; //

  ClockView({required this.initialTime,});

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {


  late DateTime currentTime; // Store the current time
  late Timer timer;
  bool isPaused = false;
  bool hasStarted = false;
  int selectedMinutes = 0;
  int selectedSeconds = 0;




  @override
  void initState() {
    super.initState();

    final timerMode = Provider.of<TimerMode>(context, listen: false);
    // Set currentTime to the initial Work Mode time
    currentTime = timerMode.initialWorkTime;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          int totalSeconds = currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second;
          if (totalSeconds > 0) {
            currentTime = currentTime.subtract(Duration(seconds: 1));
          } else {
            // When timer reaches zero, switch modes and reset to the initial time of the new mode
            timerMode.switchMode();
            currentTime = timerMode.isWorkMode ? timerMode.initialWorkTime : timerMode.initialRestTime;
            // Optionally, if you want to keep the timer paused after switching modes, set isPaused to true
            // isPaused = true;
          }
        });
      }
    });
  }



  void resetTimer() {
    final timerMode = Provider.of<TimerMode>(context, listen: false);

    setState(() {
      // Reset to the initial time of the current mode
      currentTime = timerMode.isWorkMode ? timerMode.initialWorkTime : timerMode.initialRestTime;
      hasStarted = false;
      isPaused = true; // Ensure the timer is paused
    });
  }


  void pauseTimer() {
    setState(() {
      isPaused = true;
    });
  }
  void resumeTimer() {
    setState(() {
      isPaused = false;
      hasStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate remaining time in minutes and seconds
    int totalSeconds = currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second;
    int remainingMinutes = totalSeconds ~/ 60;
    int remainingSeconds = totalSeconds % 60;

    return Scaffold(
      appBar: AppBar(
        title: Text('Clock View'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.grey[900], // Optional: match the appBar color with the background
      ),
      body: Container(
        color: Colors.grey[900],
        child: Center(
          child: Column(
            children: <Widget>[
              Transform.rotate(
                angle: -pi / 2,  // -90 degrees in radians
                child: CustomPaint(
                  painter: ClockPainter(currentTime: currentTime),
                  size: Size(300, 300),
                ),
              ),
              SizedBox(height: 20),
              // Always display remaining time
              Text(
                '${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 20),
              IconButton(
                iconSize: 64,
                icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                onPressed: () {
                  if (isPaused) {
                    resumeTimer();
                  } else {
                    pauseTimer();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }



}


class ClockPainter extends CustomPainter {
  final DateTime currentTime;//
  late DateTime dateTime;
  ClockPainter({required this.currentTime}) {
    dateTime = DateTime(
        currentTime.year, currentTime.month, currentTime.day, currentTime.hour, currentTime.minute, currentTime.second);
  }
  //60 sec - 360, 1 sec - 6degree
  //12 hours  - 360, 1 hour - 30degrees, 1 min - 0.5degrees

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Color(0xFF444974);

    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerFillBrush = Paint()..color = Color(0xFFEAECFF);

    var secHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;


    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    // Decrement the time by 1 second every second
    //dateTime = dateTime.subtract(Duration(seconds: 1));


    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



