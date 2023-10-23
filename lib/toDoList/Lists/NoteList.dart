import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/notesProvider.dart';
import '../Note.dart';
import '../SlidingLists/SlidingNoteList.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: NoteList(),
    );
  }
}
class NoteListItem extends ConsumerWidget {
  final NoteList noteList;
  NoteListItem({Key? key, required this.noteList}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notes = ref.watch(notesProvider);
    return Column(
      children: notes.map(
            (note) => NoteItem(note: note),
      ).toList(),
    );
  }
}
// Define a custom Form widget.
class NoteList extends StatefulWidget {
  //List<NoteItem> noteList;
  NoteList({super.key});
  @override
  State<NoteList> createState() => _NotesState();
}

class _NotesState extends State<NoteList> {
  final myController = TextEditingController();
  final List<NoteItem> notes;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) { // usar sliding list para esto.
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Your notes'),
          content:  Container(
            child: SlidingNoteList(),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: myController,
              ),
            ),
            TextButton(
              onPressed: () => confirm(context,notes,myController),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
//-----------------------------------------------------------
void addNote(List<NoteItem> list, String text){
  Note aux = new Note(text);
  NoteItem item = new NoteItem(note: aux);
  list.add(item);
}
void confirm(BuildContext context,List<NoteItem>list, var myController){
  addNote(list, myController.toString());
  myController.clear();
  Navigator.pop(context, 'OK');
}
void delete(List<NoteItem>list,NoteItem note){
  list.remove(note);
}
