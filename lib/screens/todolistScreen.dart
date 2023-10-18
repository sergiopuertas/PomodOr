import 'package:flutter/material.dart';
import '../toDoList/TaskList.dart';
import '../toDoList/SlidingList.dart';
import '../toDoList/MyCheckBox.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    scrollBehavior: const ConstantScrollBehavior(),
    home: todolistScreen(),
  )
  );
}

class todolistScreen extends StatefulWidget {
  const todolistScreen({super.key});
  @override
  State<todolistScreen> createState() => _TestState();
}

class _TestState extends State<todolistScreen> {

  @override
  Widget build(BuildContext context) {

    return Stack(
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
          backgroundColor: Colors.transparent,
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
            backgroundColor: Colors.transparent,
            elevation: 0, // <-- ELEVATION ZEROED
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0,0.0,20.0,0.0),
                      child: Text(
                        'Here you can find all your tasks left',
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0,0.0,20.0,0.0),
                      child: Text(
                        'Feel free to order them as you like',
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    /*Padding(
                      padding: EdgeInsets.fromLTRB(10.0,0.0,20.0,0.0),
                      child: Text(
                      'Good luck!',
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),*/
                    OverflowBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        /*Padding(
                          padding: EdgeInsets.fromLTRB(10.0,0.0,20.0,0.0),
                          child: Text(
                            'Order by:',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),*/
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
                  ],
                ),
              ),
              Container(
                height:500,
                padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 60.0),
                child: SlidingList(),
              ),
            ],
          ),

        ),
      ],
    );
  }
}

