import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AppState {
  final List<TaskItem> tasks;
  final TimeState timeState;
  final int countdownTime;
  final bool countdown;

  AppState(this.tasks, this.timeState, this.countdownTime, this.countdown);

  factory AppState.initial() => AppState(List.unmodifiable([]), TimeState.none, 0, true);
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

  String get timeFormatted => "${time ~/ 60}h ${time % 60}m";
}

enum TimeState {
  none, pomodoroTime, breakTime
}

class CountdownTime {
  final int time;

  CountdownTime(this.time);


}