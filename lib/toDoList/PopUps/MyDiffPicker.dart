import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pomodor/toDoList/TaskList.dart';
import 'package:pomodor/toDoList/Task.dart';

import 'package:pomodor/screens/TodolistScreen.dart';
import 'package:pomodor/auxiliar.dart';

class MyDiffPicker extends StatefulWidget {
  final Function(int) onDifficultySelected;
  int selectedDiff;
  MyDiffPicker({required this.onDifficultySelected, required this.selectedDiff});

  @override
  _MyDiffPickerState createState() => _MyDiffPickerState(this.selectedDiff);
}
class _MyDiffPickerState extends State<MyDiffPicker> {
  int selectedDiff;
  _MyDiffPickerState(this.selectedDiff);
  void _openDifficultyPicker() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Difficulty'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <DropdownMenuItem<int>>[
                DropdownMenuItem<int>(value: 1, child: Text('Very easy')),
                DropdownMenuItem<int>(value: 2, child: Text('Easy')),
                DropdownMenuItem<int>(value: 3, child: Text('Intermediate')),
                DropdownMenuItem<int>(value: 4, child: Text('Difficult')),
                DropdownMenuItem<int>(value: 5, child: Text('Very difficult')),
              ].map((item) {
                return ListTile(
                  title: item.child,
                  onTap: () {
                    Navigator.of(context).pop(item.value);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    ).then((int? value) {
      if (value != null) {
        setState(() {
          selectedDiff = value;
          widget.onDifficultySelected(value);
        });
      }
    });
  }
  String getDifficultyText(int difficulty) {
    switch (difficulty) {
      case 1:
        return 'Very easy';
      case 2:
        return 'Easy';
      case 3:
        return 'Intermediate';
      case 4:
        return 'Difficult';
      case 5:
        return 'Very difficult';
      default:
        return 'Unknown';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FloatingActionButton(
          onPressed: _openDifficultyPicker,
          child: Icon(Icons.directions_run_rounded),
        ),
        SizedBox(height: 10.0),
        Text(
          getDifficultyText(selectedDiff),
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}