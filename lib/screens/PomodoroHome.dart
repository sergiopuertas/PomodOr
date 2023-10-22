import 'package:flutter/material.dart';
import 'PomodoroHomeBody.dart';

class PomodoroHome extends StatefulWidget{
  const PomodoroHome({super.key});

  @override
  _PomodoroHomeState createState() => _PomodoroHomeState();
}

class _PomodoroHomeState extends State<PomodoroHome>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text('POMOD\'OR'),
        centerTitle: true ,
      ),
      body : const PomodoroHomeBody(),
      bottomNavigationBar: Container(
        color : Colors.white,
        height : 50.0,
        alignment : Alignment.center,
        child : const BottomAppBar(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed: null,
            ),
            IconButton(
              icon : Icon(Icons.music_note),
              onPressed:null,
            ),
            IconButton(
              icon: Icon(Icons.list),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.play_lesson),
              onPressed: null,
            ),
          ],

        ),
        )
        

      ),

      );
  }
}