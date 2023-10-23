import '../Lists/NoteList.dart';
import '../Note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notesProvider = StateNotifierProvider<NotesNotifier, List<Note>>((ref) {
  return NotesNotifier(notes: []);
}
);
class NotesNotifier extends StateNotifier<List<Note>> {
  NotesNotifier({notes}) : super(notes);

  void add(Note note) {
    state = [...state, note];
  }
}