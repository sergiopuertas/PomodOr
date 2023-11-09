import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'Task.dart';
import 'TaskList.dart';
import '../screens/TodolistScreen.dart';

class AddPopUp extends StatefulWidget {
  const AddPopUp({Key? key}) : super(key: key);

  @override
  _AddPopUpState createState() => _AddPopUpState();
}

class _AddPopUpState extends State<AddPopUp> {
  DateTime _chosenDate = DateTime.now();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  int _selectedDiff = 0;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        ShowDialog(context);
      },
      child: const Icon(Icons.add),
    );
  }
  void ShowDialog(BuildContext context){
    {
      showDialog<Widget>(
          context: context,
          builder: (BuildContext context) =>
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
                      ),
                      InputBox(
                        title: 'Subject',
                        parameter: 'Ex: OOP on mobile devices',
                        textEditingController: _subjectController,
                      ),
                      SizedBox(
                          height: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Choose Date'),
                              SizedBox(
                                height: 80,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: CupertinoDatePicker(
                                    minimumDate: DateTime.now(),
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: DateTime.now(),
                                    onDateTimeChanged: (
                                        DateTime newDateTime) {
                                      _chosenDate = newDateTime;
                                    },
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
                            children: <Widget>[
                              Text('Choose Difficulty'),
                              SizedBox(
                                height: 70,
                                child: DificultyPicker(
                                    selectedDiff: _selectedDiff), // Corregido aquí
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
                        DateTime date = _chosenDate as DateTime;
                        int diff = _selectedDiff;
                        String subject = _subjectController.text;

                        if (!isGoodSubject(subject) || !isGoodName(name)) {
                          name = "Not defined";
                          subject = "Not defined";
                        }
                        Provider.of<TaskList>(context, listen: false).addTask(name, date, diff, subject);
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

  bool isGoodName(String txt) {
    return txt.isNotEmpty;
  }

  bool isGoodSubject(String txt) {
    return txt.isNotEmpty;
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

const double _kItemExtent = 32.0;

const List<String> _difficulties = <String>[
  'Very easy',
  'Easy',
  'Intermediate',
  'Difficult',
  'Very difficult',
];
class DificultyPicker extends StatefulWidget {

  int selectedDiff;

  DificultyPicker({required this.selectedDiff}); // Mantener el constructor

  @override
  State<DificultyPicker> createState() => _DificultyPickerState();
}

class _DificultyPickerState extends State<DificultyPicker> {

  _DificultyPickerState();

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _showDialog(
                  CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: _kItemExtent,
                    // This sets the initial item.
                    scrollController: FixedExtentScrollController(
                      initialItem: widget.selectedDiff,
                    ),
                    onSelectedItemChanged: (int selectedItem) {
                      setState(() {
                        widget.selectedDiff = selectedItem;
                      });
                    },
                    children:
                    List<Widget>.generate(_difficulties.length, (int index) {
                      return Center(child: Text(_difficulties[index]));
                    }),
                  ),
                ),
                // This displays the selected fruit name.
                child: Text(
                  _difficulties[widget.selectedDiff],
                  style: const TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
