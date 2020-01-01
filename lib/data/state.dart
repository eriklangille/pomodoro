import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AppState {
  final List<TaskItem> tasks;

  AppState(this.tasks);

  factory AppState.initial() => AppState([TaskItem("test", Colors.blue, false, 0, DateTime(0), DateTime(0))]);//AppState(List.unmodifiable([]));
}

class TaskItem {
  final String taskTitle;
  final Color taskColor;
  final bool completed;
  final int time;
  final DateTime createdAt;
  final DateTime dueAt;

  TaskItem(this.taskTitle, this.taskColor, this.completed, this.time, this.createdAt, this.dueAt);

  String get createdAtFormatted => DateFormat.yMMMd().add_Hm().format(createdAt);
}