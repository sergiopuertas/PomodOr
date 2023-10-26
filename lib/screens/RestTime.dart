import 'package:flutter/material.dart';

class RestTime extends StatelessWidget{
  const RestTime({super.key});

   @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: Container(
        color : Colors.white,
        height : 50.0,
        alignment : Alignment.center,
        child : BottomAppBar(
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
              icon:  Icon(Icons.list) ,
              onPressed : (){
                Navigator.pushNamed(context, '/page6');
              }
            ),
          ],

        ),
      )
      )
    );
  }

}