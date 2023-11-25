import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomeBody.dart';
import 'TodolistScreen.dart';
import 'RouteGenerator.dart';
import 'StartSession.dart';
import 'package:flutter/material.dart';
import 'package:pomodor/toDoList/TaskList.dart';
import 'package:pomodor/toDoList/PopUps/submitButton.dart';
import 'package:pomodor/auxiliar.dart';
class Home extends StatefulWidget{
  const Home({super.key});
  @override
  _PomodoroHomeState createState() => _PomodoroHomeState();
}

class _PomodoroHomeState extends State<Home>{
  @override
  Widget build(BuildContext context){

    return WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            Container(
              child:  Image(
                  image: AssetImage('assets/back3.png'),
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
              )
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 255,
                flexibleSpace: Column(
                  children:<Widget> [
                    Container(
                      padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                      child: Row(
                        children: [
                          Text(
                            '   POMOD\'',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                              backgroundColor: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "OR",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                              backgroundColor: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        '“The future belongs to those who believe in the beauty of their dreams.”\n ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.transparent,
                elevation: 0, // <-- ELEVATION ZEROED
              ),
              bottomNavigationBar: Column(
                  children: [
                    SizedBox(
                      height: 700,
                    ),
                    Material(
                      elevation: 1,
                      color: Colors.amber[200],
                      borderRadius: BorderRadius.circular(150),
                      child: TextButton(
                        onPressed: () {
                          var taskList = Provider.of<TaskList>(context, listen: false);
                          taskList.changeChoosingProcess(false);
                          taskList.unchooseTasks();
                          Navigator.pushNamed(context, '/page6');
                        },
                        child: Text(
                          '\n TO-DO\n',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
            ),
           Stack(
             children: [
               Center(
                 child: Container(
                   width: 300,
                   height: 300,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(150),
                     color: Colors.white,
                     image: DecorationImage(
                       alignment: Alignment.center,
                       image: AssetImage('assets/watch3.png'), // Asegúrate de usar el camino correcto
                       fit: BoxFit.contain, //
                       // Esto asegura que la imagen cubra todo el botón
                     ),
                   ),
                 ),
               ),
               Center(
                 child: TextButton(
                     onPressed: () {
                       var taskList = Provider.of<TaskList>(context, listen: false);
                       taskList.unchooseTasks();
                       taskList.changeChoosingProcess(true);
                       Navigator.pushNamed(context, '/page2');
                     },
                     child: Text(
                       '\n\nSTART \nSESSION\n',
                       textAlign: TextAlign.center,
                       overflow: TextOverflow.ellipsis,
                       style:  TextStyle(
                         backgroundColor: Colors.white,
                         fontWeight: FontWeight.bold,
                         fontSize: 30,
                         color: Colors.black,
                       ),
                     ),
                     style: ButtonStyle(
                         padding: MaterialStateProperty.all(EdgeInsets.all(70)),
                         shape: MaterialStateProperty.all(CircleBorder()),
                         backgroundColor: MaterialStateProperty.all(Colors.transparent)
                     )
                 ),
               ),
             ],
           )
          ]
        )
    );
  }
}