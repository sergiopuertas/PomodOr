import 'package:flutter/material.dart';

class Urgency{
  int num;
  Color color;
  Urgency(int num){
    num = num;
    color = setColor(num);
  };
  Color setColor(var num){
    if(num == 1) return Colors.green;
    else if (num == 2) return Colors.yellow;
    else return Colors.redAccent;
  }
}