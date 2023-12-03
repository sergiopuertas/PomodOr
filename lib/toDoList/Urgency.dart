import 'package:flutter/material.dart';

class Urgency{
  int _number = 0;
  Color _color = Colors.white;
  Urgency(int num){
    _number = num;
    _color = setColor(num);
  }
  Color setColor(var num){
    if(num == 1) return Colors.green;
    else if (num == 2) return Colors.yellow;
    else return Colors.redAccent;
  }
  int get getNumber =>_number;
  Color get getColor => _color;
}