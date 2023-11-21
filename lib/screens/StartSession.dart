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
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.transparent,
          body: Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/page2');
                },
                child: Text(
                  'START \n SESSION',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10.0),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(CircleBorder()),
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  backgroundColor: MaterialStateProperty.all(Colors.black45), // <-- Button color
                  overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed)) return Colors.transparent; // <-- Splash color
                  }),
                ),
              ),
            ),
          )
        )
      ],
    );
  }
}