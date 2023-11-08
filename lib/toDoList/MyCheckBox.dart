import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Task.dart';
import 'TaskList.dart'; // Asegúrate de que TaskList es un ChangeNotifier

class MyCheckBox extends StatelessWidget {
  final Task task;

  const MyCheckBox({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        return Colors.blue; // Use the appropriate color
      }),
      onChanged: (bool? newValue) {
        // Aquí usamos Provider para cambiar el estado de la tarea
        Provider.of<TaskList>(context, listen: false).toggleTask(task);
      },
      value: task.getIfFinished(),
    );
  }
}
