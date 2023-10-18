import 'package:flutter/material.dart';

class PomodoroChoice extends StatelessWidget{
  const PomodoroChoice({super.key});

   @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text('CHOICE'),
      ),
      body : Center (
        child: Column(
          children: [
            TextButton(
              child:  Text("25-5") ,
              onPressed : (){
              }
            ),
            TextButton(
              child:  Text("Personalised") ,
              onPressed : (){
                Navigator.pushNamed(context, '/page5');
              }
            )
          ],
          ),
        )
    );
  }

}
