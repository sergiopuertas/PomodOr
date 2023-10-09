import 'package:flutter/material.dart';
#a


void main() {
  runApp(MaterialApp(
    home: Home(),
  )
  );
}
class Home extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return Stack( // <-- STACK AS THE SCAFFOLD PARENT
        children: [
          Container(
            decoration: BoxDecoration(
              image:
              DecorationImage(
                image: AssetImage('assets/papel.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child:
            null,
          ),
          Scaffold(
            backgroundColor: Colors.transparent, // <-- SCAFFOLD WITH TRANSPARENT BG
            appBar: AppBar(
              title: Text(
                'TO-DO LIST',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              backgroundColor: Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
              elevation: 0, // <-- ELEVATION ZEROED
            ),
            body:
              Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(border: Border.all()),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(left: 1.0),
                    child: Text(
                      'Text Center',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                        color: Colors.red
                      ),
                    ),
                  ),
                ),
              ),
          ),
        ],
      );
  }
}
