import 'package:flutter/material.dart';
import 'HomeBody.dart';
import 'RouteGenerator.dart';

class StartSession extends StatefulWidget{
  const StartSession({super.key});
  @override
  _StartSessionState createState() => _StartSessionState();
}
class _StartSessionState extends State<StartSession>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            height: 400,
            width: 400,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/page7');
              },
              child: Text(
                'START \n SESSION',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                backgroundColor: MaterialStateProperty.all(Colors.blue), // <-- Button color
                overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) return Colors.red; // <-- Splash color
                }),
              ),
            ),
          ),
        )
    );
  }
}