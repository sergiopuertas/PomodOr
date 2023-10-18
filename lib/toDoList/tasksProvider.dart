import 'Task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tasksProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier(tasks: []);
});
class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier({tasks}) : super(tasks);

  void add(Task task) {
    state = [...state, task];
  }

  void toggle(String taskname) {
    state = [
      for (final item in state)
        if (taskname == item.getName())
          item.copyWith(finished: !item.getIfFinished())
        else
          item
    ];
  }
}