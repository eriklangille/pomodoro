import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodoro/data/tasks/state.dart';
import 'package:flutter/material.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('users');

  // First initialization of user data
  Future<void> updateUserData(List<TaskItem> tasks, int pomos, int totalTime) async {
    return await userCollection.document(uid).setData({
      'pomodoros': pomos,
      'total_time': totalTime,
      'tasks': ''
    });
  }

  Future<void> updateTaskOrder(List<String> order) async {
    return await userCollection.document(uid).updateData({
      'tasks': order,
    });
  }

  Future<void> updateTaskTime(TaskItem task) async {
    return await userCollection.document(uid).collection("tasks").document(task.id).updateData({
      'time': task.time,
      'modified': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTaskDetails(TaskItem task) async {
    return await userCollection.document(uid).collection("tasks").document(task.id).updateData({
      'title': task.taskTitle,
      'color': task.taskColor.value,
      'completed': task.completed,
      'dueAt': task.dueAt
    });
  }

  Future<List<TaskItem>> getUserTaskData() async {
    print("UID: $uid");
    List<TaskItem> _tasks = [];
    List<dynamic> _tasksOrder = [];
    await userCollection.document(uid).get().then((DocumentSnapshot snapshot) {
      if (snapshot.data.containsKey('tasks')) {
        _tasksOrder = snapshot.data['tasks'];
      }
    });
    await userCollection.document(uid).collection("tasks").getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        Timestamp _createdAt = f.data['createdAt'];
        Timestamp _dueAt = f.data['dueAt'];
        _tasks.add(TaskItem(ValueKey(f.documentID), f.documentID, f.data['title'], Color(f.data['color']), f.data['completed'], f.data['time'], DateTime.fromMillisecondsSinceEpoch(_createdAt.microsecondsSinceEpoch), DateTime.fromMillisecondsSinceEpoch(_dueAt.millisecondsSinceEpoch)));
        print(f.data['title']);
      });
    });
    _tasks = _tasksOrder.map((x) {
      return _tasks.firstWhere(((TaskItem d) => d.id == x));
    }).toList();
    return _tasks;
  }

  Future<void> addUserTaskData(TaskItem task, List<String> order) async {
    print("Adding task: ${task.taskTitle}");
    WriteBatch _batch = Firestore.instance.batch();
    _batch.setData(userCollection.document(uid).collection("tasks").document(task.id), {
      'title': task.taskTitle,
      'color': task.taskColor.value,
      'completed': task.completed,
      'modified': FieldValue.serverTimestamp(), //This needs to be updated whenever and only when the time parameter is updated.
      'time': task.time, //Needs to be 0 or will fail to upload to database.
      'createdAt': task.createdAt,
      'dueAt': task.dueAt
    });
    _batch.updateData(userCollection.document(uid), {
      'tasks': order,
    });
    return await _batch.commit();
  }
}