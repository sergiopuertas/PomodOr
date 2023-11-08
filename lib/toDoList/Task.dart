import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Urgency.dart';
import 'TaskList.dart';
import 'MyCheckBox.dart';
import 'dart:math';

class TaskItem extends StatefulWidget {
  final Task task;

  TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isMenuOpen = false;
  OverlayEntry? _overlayEntry;

  void _toggleMenu() {
    if (isMenuOpen) {
      _overlayEntry?.remove();
      setState(() {
        isMenuOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
      setState(() {
        isMenuOpen = true;
      });
    }
  }
  // Este método ahora acepta una función de callback que se llama después de eliminar la task.
  void _showDeleteConfirmation(VoidCallback onConfirmDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this task?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                onConfirmDelete(); // Llama al callback para borrar la task.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  OverlayEntry _createOverlayEntry() {
    Task task = widget.task;
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Delete button
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _overlayEntry?.remove();
                  setState(() {
                    isMenuOpen = false;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // Use AlertDialog for confirmation
                      return AlertDialog(
                        title: const Text("Confirm Delete"),
                        content: const Text("Are you sure you want to delete this task?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text("Delete"),
                            onPressed: () {
                              // Implement your delete logic here
                              Provider.of<TaskList>(context, listen: false).removeTask(widget.task);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              // Edit button
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _overlayEntry?.remove();
                  isMenuOpen = false;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // Use SimpleDialog or another appropriate widget for editing
                      return SimpleDialog(
                        title: const Text("Edit Task"),
                        children: <Widget>[
                          // Implement your editing form here
                        ],
                      );
                    },
                  );
                },
              ),
              // Comment button
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  _overlayEntry?.remove();
                  isMenuOpen = false;
                  // Implement your comment block logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Task task = widget.task;
    return Consumer<TaskList>(
      builder: (context, taskList, child) {
        return Card(
            child: ListTile(
              leading: MyCheckBox(task: task),
              title: Text(
                task.getName(),
                style: TextStyle(
                  color: fitColor(task),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              tileColor: task.getUrgency().getColor(),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    task.getSubject(),
                    style: TextStyle(
                      color: fitColor(task),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    dateFormat(task),
                    style: TextStyle(
                      color: fitColor(task),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: SizedBox(
                width: 40,
                child: FloatingActionButton(
                  onPressed: _toggleMenu,
                  child: Icon(isMenuOpen ? Icons.close : Icons.menu),
                ),
              ),
            )
        );
      },
    );
  }

  String dateFormat(Task task) {
    if (task != null) {
      return task.getDate().month.toString() +
          "/" +
          task.getDate().day.toString() +
          "/" +
          task.getDate().year.toString();
    } else {
      return 'Date Missing';
    }
  }

  Color fitColor(Task task) {
    if (task != null && task.getUrgency().getNumber() == 2) return Colors.black;
    return Colors.white;
  }
}

@immutable
class Task {
    String _name ='';
    bool _finished = false;
    DateTime _expDate = DateTime.now();
    int _diff = 0;
    Urgency _urgency = Urgency(0);
    String _subject = '';
    Task(String name,  String subject,  DateTime expDate,  int diff){
      _name = name;
      _subject = subject;
      _expDate = expDate;
      _diff = diff;
      _finished = false;
      _urgency = _calculateUrgency(expDate, diff);
    }
    Task copyWith({
      String? name,
      String? subject,
      int? diff,
      DateTime? expDate,
      bool? finished,
    }) {
      return Task(name ?? this._name, subject ?? this._subject, expDate ?? this._expDate,diff ?? this._diff);

    }
    Urgency _calculateUrgency(DateTime expDate, int diff) {
      return Urgency(computeUrgency(expDate, diff));
    }
    int computeUrgency(var expDate, var diff){
      double remainingTimeRatio = min(1, _expDate.difference(DateTime.now()).inDays / 7);
      double urgencyValue = (remainingTimeRatio + diff / 5) / 2;
      if (urgencyValue <= 0.33) {
        return 1;
      } else if (urgencyValue <= 0.66) {
        return 2;
      } else {
        return 3;
      }
    }
    bool getIfFinished(){
      return this._finished;
    }
    String getSubject(){
      return this._subject;
    }
    String getName(){
      return this._name;
    }
    DateTime getDate(){
      return this._expDate;
    }
    int getDiff(){
      return this._diff;
    }
    Urgency getUrgency(){
      return this._urgency;
    }
    void toggleFinished() {
      _finished = !_finished;
    }
}


