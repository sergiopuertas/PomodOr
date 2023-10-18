import 'package:flutter/material.dart';

class PomodoroHomeBody extends StatelessWidget{
  const PomodoroHomeBody({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text('HOME'),
      ),
      body : Center (
        child : Column(
          children: [
            TextButton(
              child:  Text("CHOICE MODE") ,
              onPressed : (){
                Navigator.pushNamed(context, '/page2');
              }
            ),
            TextButton(
              child:  Text("START SESSION") ,
              onPressed : (){
                Navigator.pushNamed(context, '/page3');
              }
            ),
            TextButton(
              child:  Text("PARAMETERS") ,
              onPressed : (){
                
              }
            ),
          ],
          )
      )
    );
    
  }
}