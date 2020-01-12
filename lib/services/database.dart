import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomodoro/data/tasks/state.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('users');

  _tasksString(List<TaskItem> tasks) {
    tasks.map((task) => 0);
    return '';
  }

  Future<void> updateUserData(List<TaskItem> tasks, int pomos, int totalTime) async {
    return await userCollection.document(uid).setData({
//      'item': 'value',
      'pomodoros': pomos,
      'total_time': totalTime,
      'tasks': 'none'//_tasksString(tasks),
    });
  }
}