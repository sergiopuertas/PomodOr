import 'package:flutter/material.dart';
import 'tasksProvider.dart';
import 'Urgency.dart';
//import 'package:intl/intl.dart';
class TaskItem extends ConsumerWidget {
  final Task task;

  TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Checkbox(
          onChanged: (newValue) =>
              ref.read(tasksProvider.notifier).toggle(task.id),
          value: task.completed,
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
        ElevatedButton.icon(
            onPressed: /*función para desplegar notas*/,
            icon: Icon(
              Icons.textsms_rounded,
              color: Colors.white70,
              size: 24.0,
            ) ,
        ),
      ],
    );
  }
}

@immutable
class Task {
  String _name;
  bool _finished;
  DateTime _expDate;
  int _diff;
  Urgency _urgency;
  String _subject;
  List<String> _notesList = [];
  final bool completed;

  Task({required this._name, required this._subject,required this._expDate,required this._diff, this.finished = false});

  Task copyWith({String? name, String? subject, int? diff,DateTime? expDate, bool? finished}) {
    return Task(
        _name: name ?? this._name,
        _subject: subject??this._subject,
        _diff: diff??this._diff,
        _expDate: expDate ?? this._expDate,
        _finished: finished ?? this._finished),
        _urgency: Urgency (this.computeUrgency (expDate ?? this._expDate,diff??this._diff));
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
  int getUrgency(){
    return this._urgency;
  }
  void markFinished(){
    this._finished = true;
  }
}


