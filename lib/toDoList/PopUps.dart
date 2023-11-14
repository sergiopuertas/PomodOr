import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Task.dart';
import 'TaskList.dart';
import '../screens/TodolistScreen.dart';
// BasePopup y _BasePopupState
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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _chosenDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _chosenDate) {
      setState(() {
        _chosenDate = picked;
      });
    }
  }

  Widget _buildDifficultyDropdown() {
    return DropdownButton<int>(
      value: _selectedDiff, // Valor actual seleccionado en el Dropdown
      items: <DropdownMenuItem<int>>[
        DropdownMenuItem<int>(value: 1, child: Text('Very easy')),
        DropdownMenuItem<int>(value: 2, child: Text('Easy')),
        DropdownMenuItem<int>(value: 3, child: Text('Intermediate')),
        DropdownMenuItem<int>(value: 4, child: Text('Difficult')),
        DropdownMenuItem<int>(value: 5, child: Text('Very difficult')),
      ],
      onChanged: (int? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedDiff = newValue; // Actualiza el valor seleccionado
          });
        }
      },
    );
  }
  void ShowDialog(BuildContext context) {
    {
      showDialog<Widget>(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                content: Container(
                  width: 300.0,
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
                      SizedBox(
                          height: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 80,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Center(
                                    child: FloatingActionButton(
                                      onPressed: () => _selectDate(context),
                                      child: Icon(Icons
                                          .calendar_today), // Icono del botón
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(
                          height: 89,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 50,
                                child: _buildDifficultyDropdown(),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  SizedBox(
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        String name = _nameController.text;
                        DateTime date = _chosenDate;
                        int diff = _selectedDiff;
                        String subject = _subjectController.text;

                        if (!isGoodSubject(subject) || !isGoodName(name)) {
                          name = "Not defined";
                          subject = "Not defined";
                        }
                        widget.customAction(context,name, date, diff, subject);
                        _nameController.clear();
                        _subjectController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
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
                        _subjectController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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
      );
    }
  }
}

// AddPopup y su estado
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
        ShowDialog(context);
      },
      child: Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}

// EditPopup y su estado
class EditPopup extends BasePopup {
  final Task task;
  final VoidCallback onOverlayEntryRemove;
  EditPopup(this.task, this.onOverlayEntryRemove);

  @override
  _EditPopupState createState() => _EditPopupState(onOverlayEntryRemove);
  _BasePopupState getState() => _EditPopupState(onOverlayEntryRemove);

  @override
  String get nameprompt => task.getName();
  String get subjectprompt => task.getSubject();
  @override
  void customAction(BuildContext context, String name, DateTime date, int diff, String subject) {
    Provider.of<TaskList>(context, listen: false).editTask(task, name, date, diff, subject);
  }
}
class _EditPopupState extends _BasePopupState {
  _EditPopupState(this.onOverlayEntryRemove);
  final VoidCallback onOverlayEntryRemove;
  @override
  Widget build(BuildContext context){
    return IconButton(

      icon: Icon(Icons.edit),
      onPressed: (){
        onOverlayEntryRemove();
        ShowDialog(context);
      },
    );
  }
}

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

bool isGoodName(String txt) {
  return txt.isNotEmpty;
}

bool isGoodSubject(String txt) {
  return txt.isNotEmpty;
}
