import 'package:flutter/material.dart';
import 'package:pomodor/toDoList/'
void main() {
  runApp(MaterialApp(
    home: todolistScreen(),
  )
  );
}
class todolistScreen extends StatelessWidget {
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
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
            elevation: 0, // <-- ELEVATION ZEROED
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              OverflowBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0,0.0,20.0,0.0),
                    child: Text(
                      'Order by:',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton( child: const Text(
                    'Date',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ), onPressed: () {
                    // list.selectOrder(dateOrder);
                  }),
                  TextButton( child: const Text(
                    'Urgency',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ), onPressed: () {
                    // list.selectOrder(urgencyOrder);
                  }),
                  TextButton( child: const Text(
                    'Subject',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ), onPressed: () {
                    // list.selectOrder(urgencyOrder);
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                      color: Colors.cyan,
                      padding: EdgeInsets.all(30.0),
                      child: Text('inside container')
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
