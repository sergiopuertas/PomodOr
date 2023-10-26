import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

class ClockView extends StatefulWidget {
  final DateTime initialTime; //

  ClockView({
    required this.initialTime,
  });
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {


  late DateTime currentTime; // Store the current time
  late Timer timer;
  bool isPaused = false;
  int selectedMinutes = 0;
  int selectedSeconds = 0;


  @override
  void initState() {
    currentTime =
        widget.initialTime; // Initialize currentTime with the initial time
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          // Decrement the time by 1 second
          currentTime = currentTime.subtract(Duration(seconds: 1));
        }
        );
      }
    });
    super.initState();
  }

  void resetTimer() {
    setState(() {
      currentTime = widget.initialTime; // Resetting the time to initial value
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
    });
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isPaused ? resumeTimer : pauseTimer,
              child: Text(isPaused ? "Resume" : "Pause"),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: resetTimer,
              child: Text("Reset"),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: selectedMinutes,
              items: List.generate(60, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text('$index min'),
                );
              }),
              onChanged: (value) {
                setState(() {
                  selectedMinutes = value!;
                });
              },
            ),
            SizedBox(width: 10),
            DropdownButton<int>(
              value: selectedSeconds,
              items: List.generate(60, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text('$index sec'),
                );
              }),
              onChanged: (value) {
                setState(() {
                  selectedSeconds = value!;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              currentTime = DateTime(0, 0, 0, 0, selectedMinutes, selectedSeconds);
            });
          },
          child: Text("Set Initial Time"),
        ),
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

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    // Decrement the time by 1 second every second
    //dateTime = dateTime.subtract(Duration(seconds: 1));

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

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



/* To implement it you have to give a Initial time:

* class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Color(0xFF2D2F41),
        child: ClockView(
          initialTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 1, 0, 0),
        ),
      ),
    );
  }
}
* */