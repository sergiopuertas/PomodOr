import 'package:flutter/material.dart';
import 'SlidingList.dart';
import '../Lists/NoteList.dart';
import '../Note.dart';
import 'ConstantScrollBehaviour.dart';

class NewNote extends StatefulWidget {
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  bool isTagSelected = false;
  bool isNoteCreationEnabled = false;

  List<NewNote> newTopicList = [];

  addNewNote() {
    newTopicList.add(new NewTopic());
    setState(() {});
  }

  enableNoteCreation(String txt) {
    setState(() {
      if (txt.length > 0) {
        isNoteCreationEnabled = true;
      } else {
        isNoteCreationEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _createNewNote;

    if (isNoteCreationEnabled) {
      _createNewNote = () {
        addNewNote();
      };
    } else {
      _createNewNote = null;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('ALL COURSES'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.blueGrey,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Your notes",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CodeFont',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        child: TextField(
                          onChanged: (text) {
                            enableNoteCreation(text);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Course Name",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextButton(
                        onPressed: _createNewNote,
                        child: Container(
                          padding: EdgeInsets.all(18),
                          margin: EdgeInsets.all(8),
                          child: Icon(
                            Icons.add_box,
                            color: isNoteCreationEnabled
                                ? Colors.green
                                : Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: getAllNotesListView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAllNotesListView() {
    ListView NoteList = new ListView.builder(
        shrinkWrap: true,
        itemCount: newNoteList.length,
        itemBuilder: (context, index) {
          return new ListTile(
            title: new NewNote(),
          );
        });
    return NoteList;
  }
}

class NewNote extends StatefulWidget {
  @override
  _NewTopicState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewTopic> {
  TextEditingController _topicController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _NoteController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _NoteController.dispose();
  }
}