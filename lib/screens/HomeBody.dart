import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Couleur de fond du bouton
                onPrimary: Colors.white, // Couleur du texte du bouton
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/page2');
              },
              child: Text("CHOICE MODE"),
            ),
            SizedBox(height: 16.0), // Espacement entre les boutons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/page3');
              },
              child: Text("START SESSION"),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                // Ajoutez le code à exécuter lorsque le bouton "PARAMETERS" est pressé
              },
              child: Text("PARAMETERS"),
            ),
          ],
        ),
      ),
    );
  }
}
