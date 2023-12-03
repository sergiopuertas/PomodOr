import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodor/auxiliar.dart';
import 'Task.dart';
import 'TaskList.dart';


class MyCheckBox extends StatelessWidget {
  final Task task;

  const MyCheckBox({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: fitColor(task),
      fillColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        return Colors.transparent;
      }),
      onChanged:(bool? newValue){
        Provider.of<TaskList>(context, listen: false).toggleChosen(task);
      },
      value: task.getIfChosen,
    );
  }
}