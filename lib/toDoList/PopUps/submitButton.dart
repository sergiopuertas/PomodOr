import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pomodor/toDoList/TaskList.dart';
import 'package:pomodor/toDoList/Task.dart';

import 'package:pomodor/screens/TodolistScreen.dart';
import 'package:pomodor/auxiliar.dart';

import 'submitButton.dart';
class submitButton extends StatelessWidget{
  final String text;
  final Function function;
  final Color color;
  final double size;
  submitButton({Key? key, required this.text,required this.function,required this.color, required this.size}) : super(key: key);

  Widget build(BuildContext context){
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width - 10,
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: size,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size > 20 ? 25.0 : 17,
            color: color==Colors.white ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}

