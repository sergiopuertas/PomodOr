import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodor/toDoList/TaskList.dart';
import 'package:pomodor/toDoList/Task.dart';
import 'package:pomodor/screens/TodolistScreen.dart';
import 'package:pomodor/auxiliar.dart';


class MyDateSelector extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  DateTime chosenDate;
  MyDateSelector({required this.onDateSelected, required this.chosenDate});
  @override
  _MyDateSelectorState createState() => _MyDateSelectorState(this.chosenDate);
}
class _MyDateSelectorState extends State<MyDateSelector> {
  _MyDateSelectorState(this.chosenDate);
  DateTime chosenDate;
  void updateChosenDate(DateTime? picked) {
    if (mounted && picked != null) {
      setState(() {
        chosenDate = picked;
        widget.onDateSelected(picked);
      });
    }
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.chosenDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    updateChosenDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 3,
            child: FloatingActionButton(
              onPressed: () => _selectDate(context),
              child: Icon(Icons.calendar_month_outlined),
            )
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
            child: Text(
              '${chosenDate.day}' + '-' + '${chosenDate.month}' + '-' + '${chosenDate.year}',
              style: TextStyle(fontSize: 10),
            ),
        ),
      ],
    );
  }
}