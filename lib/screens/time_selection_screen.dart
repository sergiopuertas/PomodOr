import 'package:flutter/material.dart';
import 'package:pomodor/Timer/clock_view.dart';
import 'package:provider/provider.dart';
import 'package:pomodor/toDoList/PopUps/submitButton.dart';
import '../Timer/timer_mode.dart';
import 'package:pomodor/auxiliar.dart';


class TimeSelectionScreen extends StatefulWidget {
  @override
  _TimeSelectionScreenState createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  int selectedStudyMinutes = 25; // Default value for Study Mode
  int selectedRestMinutes = 5; // Default value for Work Mode
  int selectedCycles = 2;
  Widget presetButton(int workMinutes, int restMinutes, String label) {
    final timerMode = Provider.of<TimerMode>(context, listen: false);
    return Padding(
        padding: EdgeInsets.all(10),
        child: Material(
            color: Colors.amber[200],
            borderRadius: BorderRadius.circular(150),
            child: Column(
              children: [
                TextButton(
                  child: Text(
                      label,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    timerMode.setTimes(workMinutes, restMinutes);
                    timerMode.setNumCycles(selectedCycles);
                    timerMode.startSession();
                    workAnnouncement(context);
                  },
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(20))
                  ),
                ),
              ],
            )
        )
    );
  }


  Widget build(BuildContext context) {
    final timerMode = Provider.of<TimerMode>(context, listen: false);
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            toolbarHeight:  MediaQuery.of(context).size.height/6,
            flexibleSpace: Column(
              children: <Widget>[
                SizedBox(height: 80),
                Text(
                  'CHOOSE THE TIME\nDISTRIBUTION',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Number of cycles: ",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    DropdownButton<int>(
                      iconSize: 40,
                      elevation: 0,
                      borderRadius: BorderRadius.circular(30.0),
                      value: selectedCycles,
                      items: List.generate(
                        5,
                            (index) =>
                            DropdownMenuItem(
                              value: index + 1,
                              child: Text(
                                '${index+1}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                      ),
                      onChanged:(value) {
                        if (value != null) {
                          setState(() => selectedCycles = value);
                        }
                      }
                    )
                  ],
                ),
                 Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Predefined Distributions",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      presetButton(25,5, 'Work 25 / Rest 5'),
                      presetButton(50, 10, 'Work 50 / Rest 10'),
                      presetButton(90, 30, 'Work 90 / Rest 30'),

                    ],
                  ),

                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Customized Distribution",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                           Column(
                              children: [
                                Text(
                                    "Study Minutes",
                                  style: TextStyle(
                                    fontSize: 16
                                  ),
                                ),
                                DropdownButton<int>(
                                  iconSize: 40,
                                  borderRadius: BorderRadius.circular(30.0),
                                  value: selectedStudyMinutes,
                                  items: List.generate(
                                    24,
                                        (index) =>
                                        DropdownMenuItem(
                                          value: 5 + index*5,
                                          child: Text('${5 + index*5}',
                                            textAlign: TextAlign.center,),
                                        ),
                                  ),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() => selectedStudyMinutes = value);
                                    }
                                  },
                                ),
                              ],
                            ),

                          Column(
                              children: [
                                Text(
                                  "Rest Minutes",
                                  style: TextStyle(
                                      fontSize: 16
                                  ),
                                ),
                                DropdownButton<int>(
                                  iconSize: 40,
                                  borderRadius: BorderRadius.circular(30.0),
                                  value: selectedRestMinutes,
                                  items: List.generate(
                                    12,
                                        (index) =>
                                        DropdownMenuItem(
                                          value: 5 + index*5,
                                          child: Text('${5+index*5}',
                                            textAlign: TextAlign.center,),
                                        ),
                                  ),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() => selectedRestMinutes = value);
                                    }
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: 10),
                      presetButton(selectedStudyMinutes, selectedStudyMinutes, 'Set Custom Time'),
                    ],
                  ),
                SizedBox(height: 30),
                ],
                ),

            ),
        );
  }
}