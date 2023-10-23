import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './Providers/tasksProvider.dart';
import 'Urgency.dart';
import 'dart:math';
import 'package:intl/intl.dart';
class TaskItem extends ConsumerWidget {
  final Task task;

  TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Checkbox(
          onChanged: (newValue) =>
              ref.read(tasksProvider.notifier).toggle(task.getName()),
          value: task._finished,
        ),
        Container(
          color: task._urgency.color,
          child: Text(
            task._name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        /*ElevatedButton.icon(
            onPressed: /*función para desplegar notas*/,
            icon: Icon(
              Icons.textsms_rounded,
              color: Colors.white70,
              size: 24.0,
            ) ,
        ),*/
      ],
    );
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
  List<String> _notesList = [];
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

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
  List<String> getNoteList() {
    return this._notesList;
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
  void markFinished(){
    this._finished = true;
  }
}


