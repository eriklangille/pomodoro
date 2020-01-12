import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class TasksState {
  final List<TaskItem> tasks;
  final TimeState timeState;
  final int countdownTime;
  final bool countdown;
  final Timer countdownTimer;
  final bool newTask;

  TasksState(this.tasks, this.timeState, this.countdownTime, this.countdown, this.countdownTimer, this.newTask);

  factory TasksState.initial() => TasksState(List.unmodifiable([]), TimeState.none, 10, true, null, false);

}

class TaskItem {
  final int key;
  final String taskTitle;
  final Color taskColor;
  final bool completed;
  final int time;
  final DateTime createdAt;
  final DateTime dueAt;

  TaskItem(this.key, this.taskTitle, this.taskColor, this.completed, this.time, this.createdAt, this.dueAt);

  String get createdAtFormatted => DateFormat.yMMMd().add_Hm().format(createdAt);

  String get timeFormatted => "${time ~/ 60}h ${time % 60}m";
}

enum TimeState {
  none, pomodoroTime, breakTime, longBreakTime
}

class CountdownTime {
  final int time;

  CountdownTime(this.time);


}