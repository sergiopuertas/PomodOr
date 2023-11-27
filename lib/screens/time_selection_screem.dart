import 'package:flutter/material.dart';

import '/Timer/clock_view.dart';
class TimeSelectionScreen extends StatefulWidget {
  @override
  _TimeSelectionScreenState createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  int selectedMinutes = 0;
  int selectedSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Dropdown for minutes
            DropdownButton<int>(
              value: selectedMinutes,
              items: List.generate(60, (index) => DropdownMenuItem(value: index, child: Text('$index min'))),
              onChanged: (value) => setState(() => selectedMinutes = value!),
            ),
            // Dropdown for seconds
            DropdownButton<int>(
              value: selectedSeconds,
              items: List.generate(60, (index) => DropdownMenuItem(value: index, child: Text('$index sec'))),
              onChanged: (value) => setState(() => selectedSeconds = value!),
            ),
            ElevatedButton(
              child: Text('Set Time'),
              onPressed: () {
                final DateTime setTime = DateTime(0, 0, 0, 0, selectedMinutes, selectedSeconds);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ClockView(initialTime: setTime)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*
* class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timer App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Navigate to TimeSelectionScreen and wait for the selected time
            final DateTime? selectedTime = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TimeSelectionScreen()),
            );

            // If a time was selected, navigate to ClockView with that time
            if (selectedTime != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClockView(initialTime: selectedTime),
                ),
              );
            }
          },
          child: Text('Set Timer'),
        ),
      ),
    );
  }
}*/