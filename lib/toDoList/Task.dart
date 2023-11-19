import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomodor/notifications.dart';

import 'Urgency.dart';
import 'TaskList.dart';
import 'MyCheckBox.dart';
import 'dart:math';
import 'PopUps.dart';

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
    var tasks = Provider.of<TaskList>(context, listen: false);
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
              EditPopup(task,() => _toggleMenu()),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () async {
                  _overlayEntry?.remove();
                  setState(() {
                    isMenuOpen = false;
                  });
                  String savedComment = task.getComment() ?? "";
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController _textController = TextEditingController(text: savedComment);
                      return Dialog(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 300, // when it reach the max it will use scroll
                            maxWidth: 500,
                          ),
                          child: TextField(
                            controller: _textController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 5,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: _textController.text,
                              border: InputBorder.none,
                            ),
                            onChanged: (value) async {
                              task.setComment(value);
                              tasks.saveTasks();
                            },
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  );
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
                  heroTag: task.hashCode,
                  backgroundColor: task.getUrgency().getColor(),
                  elevation: 0.0,
                  onPressed: _toggleMenu,
                  child: Icon(
                    isMenuOpen ? Icons.close : Icons.menu,
                    color: fitColor(task),
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}

class Task {
    Map<String, dynamic> toJson() => {
      'name': _name,
      'subject': _subject,
      'expDate': _expDate.toIso8601String(),
      'diff': _diff,
      'finished': _finished,
      'comment': _comment,
    };

    factory Task.fromJson(Map<String, dynamic> json) => Task(
      json['name'],
      json['subject'],
      DateTime.parse(json['expDate']),
      json['diff'],
    ).._finished = json['finished'].._comment = json['comment'];

    String _name ='';
    bool _finished = false;
    DateTime _expDate = DateTime.now();
    int _diff = 0;
    Urgency _urgency = Urgency(0);
    String _subject = '';
    String _comment = '';

    Task(String name,  String subject,  DateTime expDate,  int diff){
      _name = name;
      _subject = subject;
      _expDate = expDate;
      _diff = diff;
      _finished = false;
      _urgency = _calculateUrgency(expDate, diff);
      _comment = '';
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
    void setUrgency(DateTime expDate, int diff){
      this._urgency = _calculateUrgency(expDate, diff);
    }
    Urgency _calculateUrgency(DateTime expDate, int diff) {
      return Urgency(computeUrgency(expDate, diff));
    }
    int computeUrgency(DateTime expDate, int diff){
      int daysUntilExpDate = expDate.difference(DateTime.now()).inDays;
      if(daysUntilExpDate < 3){
        if(diff >2)  return 3;
        else return 2;
      }
      else if((daysUntilExpDate >=3 && daysUntilExpDate <=15) && diff >3){
        return 2;
      }
      else return 1;
    }

    void setComment(String comment){
      this._comment = comment;
    }
    String getComment(){
      return this._comment;
    }
    bool getIfFinished(){
      return this._finished;
    }
    void setSubject(String txt){
      this._subject = txt;
    }
    String getSubject(){
      return this._subject;
    }
    void setName(String txt){
      this._name = txt;
    }
    String getName(){
      return this._name;
    }
    void setDate(DateTime time){
      this._expDate = time;
    }
    DateTime getDate(){
      return this._expDate;
    }
    void setDiff(int num){
      this._diff = num;
    }
    int getDiff(){
      return this._diff;
    }
    Urgency getUrgency(){
      return this._urgency;
    }

    void toggleFinished() {
      if(!_finished){
        cancelTaskNotification(this);
      }
      else{
        scheduleNotification(this);
      }
      _finished = !_finished;
    }
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