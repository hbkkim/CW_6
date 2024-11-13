import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  // Create a new task
  Future<void> addTask(String title, String description) async {
    await _tasksCollection.add({
      'title': title,
      'description': description,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Read tasks
  Stream<QuerySnapshot> getTasks() {
    return _tasksCollection.orderBy('createdAt', descending: true).snapshots();
  }

  // Update a task
  Future<void> updateTask(String id, String title, String description) async {
    await _tasksCollection.doc(id).update({
      'title': title,
      'description': description,
    });
  }

  // Delete a task
  Future<void> deleteTask(String id) async {
    await _tasksCollection.doc(id).delete();
  }

  // Toggle task completion status
  Future<void> toggleTaskCompletion(String id, bool completed) async {
    await _tasksCollection.doc(id).update({'completed': !completed});
  }
}
