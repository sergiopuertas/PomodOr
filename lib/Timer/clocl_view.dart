import 'dart:math';
import 'main.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class ClockView extends StatefulWidget {
  final DateTime initialTime; //

  ClockView({required this.initialTime,});

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {


  late DateTime currentTime; // Store the current time
  late Timer timer;
  bool isPaused = true;
  bool hasStarted = false;
  int selectedMinutes = 0;
  int selectedSeconds = 0;





  @override
  void initState() {
    super.initState();
    currentTime = widget.initialTime;


    // Initialize selectedMinutes based on initialTime
    selectedMinutes = widget.initialTime.minute;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          currentTime = currentTime.subtract(Duration(seconds: 1));
          // Calculate remaining time
          int totalSeconds = currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second;
          int remainingMinutes = totalSeconds ~/ 60;
          int remainingSeconds = totalSeconds % 60;

          // Update the notification
        });
      }
    });
  }


  void resetTimer() {
    setState(() {
      currentTime = widget.initialTime;// Resetting the time to initial value
      hasStarted = false;
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Transform.rotate(
          angle: -pi / 2,  // -90 degrees in radians
          child: CustomPaint(
            painter: ClockPainter(currentTime: currentTime),
            size: Size(300, 300),
          ),
        ),
        // Numeric counter for remaining time
        if (hasStarted) ...[
          SizedBox(height: 20),
          Text(
            '${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Set text color to white
            ),
          ),
        ],
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isPaused ? resumeTimer : pauseTimer,
              child: Text(isPaused ? (hasStarted ? "Resume" : "Start") : "Pause"),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: resetTimer,
              child: Text("Reset"),
            ),
          ],
        ),
        if (!hasStarted) ...[
          SizedBox(height: 20),
          Center(
            child: DropdownButton<int>(
              value: selectedMinutes,
              items: List.generate(60, (index) {
                return DropdownMenuItem<int>(
                    value: index,
                    child:Text(
                      '$index min',
                      style: TextStyle(color: Colors.black),
                    )// Set text color to white,
                );
              }),
              onChanged: (value) {
                setState(() {
                  selectedMinutes = value!;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentTime = DateTime(0, 0, 0, 0, selectedMinutes, 0);
                // Add notification logic here when setting initial time
              });
            },
            child: Text("Set Initial Time"),
          ),
        ],
      ],
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
/* HOUR HAND
    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;
      */

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    // Decrement the time by 1 second every second
    //dateTime = dateTime.subtract(Duration(seconds: 1));

    /* var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);
*/

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



/*
*
*
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }*/