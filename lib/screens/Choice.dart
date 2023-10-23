import 'package:flutter/material.dart';

class Choice extends StatelessWidget{
  const Choice({super.key});

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
                //choice = 1
              }
            ),
            TextButton(
              child:  Text("Personalised") ,
              onPressed : (){
                //choice = 2
                Navigator.pushNamed(context, '/page5');
              }
            )
          ],
          ),
        )
    );
  }

}
