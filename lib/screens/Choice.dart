import 'package:flutter/material.dart';

class Choice extends StatelessWidget {
  const Choice({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CHOICE',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white, // Couleur du texte du bouton
              ),
              onPressed: () {
                // choice = 1
              },
              child: Text(
                "25-5",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 16.0), // Espacement entre les boutons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                // choice = 2
                Navigator.pushNamed(context, '/page5');
              },
              child: Text(
                "Personalised",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
