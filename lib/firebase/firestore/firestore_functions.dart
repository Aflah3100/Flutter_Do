import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_do/database/models/task_model.dart';
import 'package:flutter_do/utils/firestore_collections.dart';
import 'package:flutter_do/utils/enums.dart';

//Firebase-FireStore-Functions
class FireStoreFunctions {
  //Singleton-Object
  FireStoreFunctions._internal();
  static FireStoreFunctions instance = FireStoreFunctions._internal();
  factory FireStoreFunctions() => instance;

  //Save-Task-To-Firestore
  Future<dynamic> saveTask({required TaskModel task}) async {
    try {
      await FirebaseFirestore.instance
          .collection(taskCollections)
          .doc(task.taskId)
          .set(task.toMap());

      return true;
    } on FirebaseException catch (e) {
      return e;
    }
  }

  //Fetch-Tasks-By-Priority
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchTaskByPriority(
      Priorities priority) {
    if (priority == Priorities.today) {
      return FirebaseFirestore.instance
          .collection(taskCollections)
          .where("Task Priority", isEqualTo: "Today")
          .snapshots();
    } else if (priority == Priorities.tomorow) {
      return FirebaseFirestore.instance
          .collection(taskCollections)
          .where("Task Priority", isEqualTo: "Tomorrow")
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(taskCollections)
          .where("Task Priority", isEqualTo: "Next Week")
          .snapshots();
    }
  }

  //Update-Task-In-Firebase
  Future<dynamic> updateTask({required TaskModel task}) async {
    try {
      await FirebaseFirestore.instance
          .collection(taskCollections)
          .doc(task.taskId)
          .update({
        "Task": task.task,
        "Task Description": task.taskDescription,
        "Task Priority": task.taskPriority
      });
      return true;
    } on FirebaseException catch (e) {
      return e;
    }
  }

  //Update-Task-Status
  Future<dynamic> updateTaskStatus(
      {required String taskId, required bool status}) async {
    try {
      await FirebaseFirestore.instance
          .collection(taskCollections)
          .doc(taskId)
          .update({"Task Status": status});
      return true;
    } on FirebaseException catch (e) {
      return e;
    }
  }

  //Delete-Task-On-Firebase
  Future<dynamic> deleteTask({required String taskId}) async {
    try {
      await FirebaseFirestore.instance
          .collection(taskCollections)
          .doc(taskId)
          .delete();
      return true;
    } on FirebaseException catch (e) {
      return e;
    }
  }
}
