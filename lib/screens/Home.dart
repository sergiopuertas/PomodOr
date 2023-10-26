import 'package:flutter/material.dart';
import 'HomeBody.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  _PomodoroHomeState createState() => _PomodoroHomeState();
}

class _PomodoroHomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POMOD\'OR',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const HomeBody(),
      bottomNavigationBar: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  size: 28.0,
                ),
                onPressed: null,
              ),
              IconButton(
                icon: Icon(
                  Icons.music_note,
                  size: 28.0,
                ),
                onPressed: null,
              ),
              IconButton(
                icon: Icon(
                  Icons.list,
                  size: 28.0,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/page6');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
