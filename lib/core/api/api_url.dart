import 'package:cloud_firestore/cloud_firestore.dart';

class ApiUrl {
  const ApiUrl._();

  static final users = FirebaseFirestore.instance.collection("users");
  static final todos = FirebaseFirestore.instance.collection("todos");

  static CollectionReference<Map<String, dynamic>> userTasks(String userId) {
    return todos.doc(userId).collection("user_tasks");
  }

  static DocumentReference<Map<String, dynamic>> singleTask(String userId, String taskId) {
    return userTasks(userId).doc(taskId);
  }

}
