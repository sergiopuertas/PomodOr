import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodor/toDoList/Task.dart';
import 'package:pomodor/toDoList/TaskList.dart';
import 'package:pomodor/screens/TodolistScreen.dart';
import 'package:pomodor/auxiliar.dart';
import 'InputBox.dart';
import 'MyDateSelector.dart';
import 'MyDiffPicker.dart';
import 'submitButton.dart';
abstract class BasePopup extends StatefulWidget {
  @override
  _BasePopupState createState() => getState();

  _BasePopupState getState();
  String get nameprompt;
  String get subjectprompt;

  void customAction(BuildContext context, String name, DateTime expDate, int difficulty, String subject);
}

abstract class _BasePopupState extends State<BasePopup> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  DateTime _chosenDate = DateTime.now();
  int _selectedDiff = 1;

  void ShowDialog(BuildContext context, String prevName, String prevSubject, DateTime prevDate, int prevDiff) {
    {
      _nameController.text = prevName;
      _subjectController.text = prevSubject;
      _chosenDate = prevDate;
      _selectedDiff = prevDiff;
      showDialog<Widget>(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                content: Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InputBox(
                        title: 'Name',
                        parameter: widget.nameprompt,
                        textEditingController: _nameController,
                      ),
                      InputBox(
                        title: 'Subject',
                        parameter: widget.subjectprompt,
                        textEditingController: _subjectController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                              height: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 100,
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                                      child: Center(
                                        child: MyDateSelector(
                                          onDateSelected: (DateTime newDate) {
                                            _chosenDate = newDate;
                                          },
                                          chosenDate: _chosenDate,
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                          SizedBox(
                              height: 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 80,
                                    child: MyDiffPicker(
                                      onDifficultySelected: (int newDifficulty) {
                                        _selectedDiff = newDifficulty;
                                      },
                                      selectedDiff: _selectedDiff,
                                    )
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                      submitButton(text: 'Continue', function:()=> acceptInput(context,_nameController, _subjectController), color: Colors.amber[600] as Color,textColor: Colors.black, size: 14.0,),
                    ],
                  ),
                ),
              )
      );
    }
  }
  void acceptInput(BuildContext context,TextEditingController nameController,TextEditingController subjectController){
    String name = nameController.text;
    String subject = subjectController.text;
    if (!isGoodSubject(subject) || !isGoodName(name)) {
      name = "Not defined";
      subject = "Not defined";
    }
    widget.customAction(context, name, _chosenDate, _selectedDiff, subject);
    closeAll(context);
  }
  void closeAll(BuildContext context){
    _nameController.clear();
    _subjectController.clear();
    Navigator.of(context).pop();
  }
}
class AddPopup extends BasePopup {
  @override
  _AddPopupState createState() => _AddPopupState();
  _BasePopupState getState() => _AddPopupState();

  @override
  String get nameprompt => "Ex: create cool App";
  String get subjectprompt => "Ex: POO in mobile devices";

  @override
  void customAction(BuildContext context, String name, DateTime date, int diff, String subject) {
    Provider.of<TaskList>(context, listen: false).addTask(name, date, diff, subject);
  }
}

class _AddPopupState extends _BasePopupState {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      heroTag: null,
      onPressed: () {
        Provider.of<TaskList>(context,listen: false).unchooseTasks();
        ShowDialog(context,"", "", DateTime.now(),1);
      },
      child: Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}

class EditPopup extends BasePopup {
  final Task task;
  final VoidCallback onOverlayEntryRemove;
  EditPopup(this.task, this.onOverlayEntryRemove);

  @override
  _EditPopupState createState() => _EditPopupState(onOverlayEntryRemove, task);
  _BasePopupState getState() => _EditPopupState(onOverlayEntryRemove, task);

  @override
  String get nameprompt => task.getName();
  String get subjectprompt => task.getSubject();
  @override
  void customAction(BuildContext context, String name, DateTime date, int diff, String subject) {
    Provider.of<TaskList>(context, listen: false).editTask(task, name, date, diff, subject);
  }
}
class _EditPopupState extends _BasePopupState {
  _EditPopupState(this.onOverlayEntryRemove, this.task);
  final VoidCallback onOverlayEntryRemove;
  final Task task;
  @override
  Widget build(BuildContext context){
    return IconButton(
      color: Colors.black,
      icon: Icon(Icons.edit),
      onPressed: (){
        onOverlayEntryRemove();
        ShowDialog(context,task.getName(),task.getSubject(), task.getDate(), task.getDiff());
      },
    );
  }
}