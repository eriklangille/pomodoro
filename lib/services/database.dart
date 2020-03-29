import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodoro/data/tasks/state.dart';
import 'package:flutter/material.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('users');

  _tasksString(List<TaskItem> tasks) {
    tasks.map((task) => 0);
    return '';
  }
  // First initialization of user data
  Future<void> updateUserData(List<TaskItem> tasks, int pomos, int totalTime) async {
    return await userCollection.document(uid).setData({
//      'item': 'value',
      'pomodoros': pomos,
      'total_time': totalTime,
      'tasks': 'none'//_tasksString(tasks),
    });
  }

  Future<List<TaskItem>> getUserTaskData() async {
    print("UID: $uid");
    List<TaskItem> _tasks = [];
    await userCollection.document(uid).collection("tasks").getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        Timestamp _createdAt = f.data['createdAt'];
        Timestamp _dueAt = f.data['dueAt'];
        _tasks.add(TaskItem(ValueKey(f.documentID), f.documentID, f.data['title'], Color(f.data['color']), f.data['completed'], f.data['time'], DateTime.fromMillisecondsSinceEpoch(_createdAt.microsecondsSinceEpoch), DateTime.fromMillisecondsSinceEpoch(_dueAt.millisecondsSinceEpoch)));
        print(f.data['title']);
      });
    });
    return _tasks;
  }

  Future<void> addUserTaskData(TaskItem task, int order) async {
    print("Adding task: ${task.taskTitle}");
    return await userCollection.document(uid).collection("tasks").document(task.id).setData({
      'title': task.taskTitle,
      'order': order,
      'color': task.taskColor.value,
      'completed': task.completed,
      'time': task.time,
      'createdAt': task.createdAt,
      'dueAt': task.dueAt
    });
  }
}