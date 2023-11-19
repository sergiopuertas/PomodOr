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
                content: Container(
                  width: 200.0,
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
                                      padding: EdgeInsets.fromLTRB(
                                          0.0, 20.0, 0.0, 0.0),
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
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  SizedBox(
                    height: 40,
                    child: InkWell(
                        onTap: () {
                          String name = _nameController.text;
                          String subject = _subjectController.text;
                          if (!isGoodSubject(subject) || !isGoodName(name)) {
                            name = "Not defined";
                            subject = "Not defined";
                          }
                          widget.customAction(context, name, _chosenDate, _selectedDiff, subject);
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
      icon: Icon(Icons.edit),
      onPressed: (){
        onOverlayEntryRemove();
        ShowDialog(context,task.getName(),task.getSubject(), task.getDate(), task.getDiff());
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

class MyDateSelector extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  DateTime chosenDate;
  MyDateSelector({required this.onDateSelected, required this.chosenDate});
  @override
  _MyDateSelectorState createState() => _MyDateSelectorState(this.chosenDate);
}

class _MyDateSelectorState extends State<MyDateSelector> {
  _MyDateSelectorState(this.chosenDate);
  DateTime chosenDate;
  void updateChosenDate(DateTime? picked) {
    if (mounted && picked != null) {
      setState(() {
        chosenDate = picked;
        widget.onDateSelected(picked);
      });
    }
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.chosenDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    updateChosenDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => _selectDate(context),
            child: Icon(Icons.calendar_month_outlined),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '${chosenDate.toLocal()}'.split(' ')[0],
            style: TextStyle(fontSize: 10),
          ),
        ],
    );
  }
}
class MyDiffPicker extends StatefulWidget {
  final Function(int) onDifficultySelected;
  int selectedDiff;
  MyDiffPicker({required this.onDifficultySelected, required this.selectedDiff});

  @override
  _MyDiffPickerState createState() => _MyDiffPickerState(this.selectedDiff);
}

class _MyDiffPickerState extends State<MyDiffPicker> {
  int selectedDiff;
  _MyDiffPickerState(this.selectedDiff);
  void _openDifficultyPicker() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Difficulty'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <DropdownMenuItem<int>>[
                DropdownMenuItem<int>(value: 1, child: Text('Very easy')),
                DropdownMenuItem<int>(value: 2, child: Text('Easy')),
                DropdownMenuItem<int>(value: 3, child: Text('Intermediate')),
                DropdownMenuItem<int>(value: 4, child: Text('Difficult')),
                DropdownMenuItem<int>(value: 5, child: Text('Very difficult')),
              ].map((item) {
                return ListTile(
                  title: item.child,
                  onTap: () {
                    Navigator.of(context).pop(item.value);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    ).then((int? value) {
      if (value != null) {
        setState(() {
          selectedDiff = value;
          widget.onDifficultySelected(value);
        });
      }
    });
  }
  String getDifficultyText(int difficulty) {
    switch (difficulty) {
      case 1:
        return 'Very easy';
      case 2:
        return 'Easy';
      case 3:
        return 'Intermediate';
      case 4:
        return 'Difficult';
      case 5:
        return 'Very difficult';
      default:
        return 'Unknown';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FloatingActionButton(
          onPressed: _openDifficultyPicker,
          child: Icon(Icons.directions_run_rounded),
        ),
        SizedBox(height: 10.0),
          Text(
            getDifficultyText(selectedDiff),
            style: TextStyle(fontSize: 12),
          ),
      ],
    );
  }
}

