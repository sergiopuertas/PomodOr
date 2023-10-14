import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

class Task implements Comparable{
  String _name;
  bool _finished;
  DateTime _expDate;
  int _diff;
  int _urgency;
  String _subject;
  List<String> _notesList = [];

  Task(String name,DateTime expDate,int diff, String subject) {
    this._name = name;
    this._finished = false;
    this._diff = diff;
    this._expDate = expDate;
    this._subject = subject;
    this._urgency = this.computeDifficulty(expDate,diff);
  }

  int computeDifficulty(var expDate, var diff){
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
