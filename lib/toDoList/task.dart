import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task implements Comparable{
  var String _name;
  var bool _finished;
  var DateTime _expDate;
  var int _diff;
  var int _urgency;
  var String _subject;
  List<String> _notesList = [];

  Task(var name,var expDate,var diff, var subject) {
    this._urgency = this.computeDifficulty();
    this._name = name;
    this._finished = false;
    this._diff = diff;
    this._expDate = expDate;
    this._subject = subject;
  }

  int computeDifficulty(){
    var float value = 0;
    // insert algorithm here: value = ...
    _urgency.setValue(value);
    return _urgency;
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
