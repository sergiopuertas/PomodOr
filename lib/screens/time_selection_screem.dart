import 'package:flutter/material.dart';
import 'package:pomodor/Timer/clock_view.dart';
import 'package:provider/provider.dart';

import 'package:pomodor/Timer/clock_view.dart';

import '../Timer/timer_mode.dart';

class TimeSelectionScreen extends StatefulWidget {
  @override
  _TimeSelectionScreenState createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  int selectedStudyMinutes = 25; // Default value for Study Mode
  int selectedRestMinutes = 5; // Default value for Work Mode

  // Add a method to create a preset button
  Widget presetButton(int workMinutes, int restMinutes, String label) {
    return ElevatedButton(
      child: Text(label),
      onPressed: () {
        final timerMode = Provider.of<TimerMode>(context, listen: false);
        timerMode.setTimes(workMinutes, restMinutes);

        // Navigate to ClockView
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClockView(initialTime: timerMode.initialWorkTime),
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Dropdown for Study Mode minutes
            Text("Study Mode Minutes:"),
            DropdownButton<int>(
              value: selectedStudyMinutes,
              items: List.generate(
                60,
                    (index) =>
                    DropdownMenuItem(
                      value: index,
                      child: Text('$index min'),
                    ),
              ),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedStudyMinutes = value);
                }
              },
            ),
            SizedBox(height: 20),
            presetButton(50, 10, 'Work 50 / Rest 10'),
            presetButton(30, 6, 'Work 30 / Rest 6'),
            presetButton(90, 30, 'Work 90 / Rest 30'),
            // Dropdown for Work Mode minutes
            Text("Rest Mode Minutes:"),
            DropdownButton<int>(
              value: selectedRestMinutes,
              items: List.generate(
                60,
                    (index) =>
                    DropdownMenuItem(
                      value: index,
                      child: Text('$index min'),
                    ),
              ),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedRestMinutes = value);
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Set Time'),
              onPressed: () {
                // Access the TimerMode from the provider
                final timerMode = Provider.of<TimerMode>(
                    context, listen: false);

                // Set the initial work and rest times based on the selections
                timerMode.setInitialWorkTime(
                    DateTime(0, 0, 0, 0, selectedStudyMinutes, 0));
                timerMode.setInitialRestTime(
                    DateTime(0, 0, 0, 0, selectedRestMinutes, 0));

                // Navigate to ClockView
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ClockView(initialTime: timerMode.initialTime),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}