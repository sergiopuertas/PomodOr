import 'package:flutter/material.dart';

class PersonalisedTime extends StatelessWidget{
  const PersonalisedTime({super.key});

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text('PERSONALISED'),
      ),
      body : Center (
        child: Column(
          children: [
            const Text('Temps de travail : '),
            TextField(
              keyboardType: TextInputType.number,
              decoration : InputDecoration(
                labelText: 'Enter minute number'
              ) 
            ),
            const Text('Temps de pause :'),
            TextField(
              keyboardType: TextInputType.number,
              decoration : InputDecoration(
                labelText: 'Enter minute number'
              ) 
            ),
          ],
        ),
      )
    );
  }
}
