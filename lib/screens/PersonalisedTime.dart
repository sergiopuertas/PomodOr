import 'package:flutter/material.dart';

class PersonalisedTime extends StatefulWidget {
  const PersonalisedTime({Key? key});

  @override
  _PersonalisedTimeState createState() => _PersonalisedTimeState();
}

class _PersonalisedTimeState extends State<PersonalisedTime> {
  TextEditingController _tempsTravailController = TextEditingController();
  TextEditingController _tempsPauseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PERSONALISED',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Temps de travail :',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _tempsTravailController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                labelText: 'Entrez la durée en minutes',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Temps de pause :',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _tempsPauseController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                labelText: 'Entrez la durée en minutes',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Vous pouvez accéder aux valeurs saisies ici
                final tempsTravail = _tempsTravailController.text;
                final tempsPause = _tempsPauseController.text;

                // Vous pouvez faire quelque chose avec ces valeurs, par exemple les afficher
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Temps de travail: $tempsTravail, Temps de pause: $tempsPause'),
                  ),
                );
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
