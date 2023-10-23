import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Providers/notesProvider.dart';

class NoteItem extends ConsumerWidget{
  final Note note;
  NoteItem({Key? key, required this.note}) : super(key: key);
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Colors.white,
          child: Text(
            note.getText(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
@immutable
class Note{
  String _text;
  DateTime _dateTime;
  Note(String text){
    this._text = text;
    this._dateTime = DateTime.now();
  }
  String getText(){
    return this._text;
  }
  DateTime getDate(){
    return this._dateTime;
  }
}
