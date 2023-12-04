import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pomodor/toDoList/TaskList.dart';
import 'package:pomodor/toDoList/Task.dart';

import 'package:pomodor/screens/TodolistScreen.dart';
import 'package:pomodor/auxiliar.dart';
class InputBox extends StatefulWidget {
  final String title;
  final String parameter;
  final TextEditingController textEditingController;

  InputBox({
    required this.title,
    required this.parameter,
    required this.textEditingController,
  });

  @override
  _InputBoxState createState() => _InputBoxState(
    title: title,
    parameter: parameter,
    textEditingController: textEditingController,
  );
}
class _InputBoxState extends State<InputBox> {
  final String title;
  final String parameter;
  final TextEditingController textEditingController;

  _InputBoxState({
    required this.title,
    required this.parameter,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Insert $title',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 70,
          child: TextField(
            maxLength: 30,
            controller: this.textEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: parameter,
            ),
          ),
        ),
      ],
    );
  }
}