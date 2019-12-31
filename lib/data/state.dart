import 'package:intl/intl.dart';

class AppState {
  final List<TaskItem> tasks;

  AppState(this.tasks);

  factory AppState.initial() => AppState(List.unmodifiable([]));
}

class TaskItem {
  final String taskTitle;
  final int time;
  final DateTime createdAt;
  final DateTime dueAt;

  TaskItem(this.taskTitle, this.time, this.createdAt, this.dueAt);

  String get createdAtFormatted => DateFormat.yMMMd().add_Hm().format(createdAt);
}