import 'package:flutter/material.dart';
import 'dart:ui';
import 'Task.dart';
import 'Lists/TaskList.dart';

class AddPopUp extends StatefulWidget {
  final TaskList taskList;
  const AddPopUp({required this.taskList});
  @override
  _AddPopUpState createState() => _AddPopUpState(taskList: taskList);
}

class _AddPopUpState extends State<AddPopUp> {
  final TaskList taskList;
  bool isTaskCreationEnabled = false;

  _AddPopUpState({required this.taskList});

  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _diffController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showDialog<Widget>(
        context: context,
        builder:(BuildContext context) =>
          AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text("Create task"),
          content: Container(
            width: 300.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InputBox(
                  title: 'Name',
                  parameter: 'Ex: Create cool app',
                  textEditingController: _nameController,
                  checker: isGoodName,
                ),
                InputBox(
                  title: 'Subject',
                  parameter: 'Ex: OOP on mobile devices',
                  textEditingController: _subjectController,
                  checker: isGoodSubject,
                ),
                InputBox(
                  title: 'Date',
                  parameter: 'Ex: 16/05/2024',
                  textEditingController: _dateController,
                  checker: goodDate,
                ),
                InputBox(
                  title: 'Difficulty',
                  parameter: 'Ex: 5',
                  textEditingController: _diffController,
                  checker: goodDiff,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            SizedBox(
              height: 40,
              child: InkWell(
                onTap: () {
                  if (isTaskCreationEnabled) {
                    String name = _nameController.text;
                    String date = _dateController.text;
                    String diff = _diffController.text;
                    String subject = _subjectController.text;
                    taskList.addTask(name, date, int.parse(diff), subject);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: isTaskCreationEnabled ? Colors.black : Colors.grey,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    "Submit",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 40,
              child: InkWell(
                onTap: () {
                  _nameController.clear();
                  _dateController.clear();
                  _diffController.clear();
                  _subjectController.clear();
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    "Cancel",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ),
      child: const Icon(Icons.add),
    );
  }

  bool isGoodName(String txt) {
    return txt.isNotEmpty;
  }

  bool isGoodSubject(String txt) {
    return txt.isNotEmpty;
  }

  bool goodDate(String txt) {
    //return DateTime.tryParse(txt) != null;
    return true;
  }

  bool goodDiff(String txt) {
    if (txt.isEmpty) {
      return false;
    }
    int diff = int.tryParse(txt) ?? 0;
    return diff >= 1 && diff <= 5;
  }
}

class InputBox extends StatefulWidget {
  final String title;
  final String parameter;
  final TextEditingController textEditingController;
  final Function(String) checker;

  InputBox({
    required this.title,
    required this.parameter,
    required this.textEditingController,
    required this.checker,
  });

  @override
  _InputBoxState createState() => _InputBoxState(
    title: title,
    parameter: parameter,
    textEditingController: textEditingController,
    checker: checker,
  );
}

class _InputBoxState extends State<InputBox> {
  final String title;
  final String parameter;
  final TextEditingController textEditingController;
  final Function(String) checker;

  _InputBoxState({
    required this.title,
    required this.parameter,
    required this.textEditingController,
    required this.checker,
  });

  bool isTaskCreationEnabled = false;

  void enableTaskCreation(String text) {
    setState(() {
      isTaskCreationEnabled = true;
      if (!checker(text)) {
        isTaskCreationEnabled = false;
      }
    });
  }

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
            controller: this.textEditingController,
            onChanged: (text) {
              enableTaskCreation(text);
            },
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
