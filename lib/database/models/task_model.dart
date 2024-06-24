import 'package:flutter_do/screens/add_edit_task_screen/screen_add_edit_task.dart';

class TaskModel {
  String taskId;
  String task;
  String? taskDescription;
  String taskPriority;

  TaskModel(
      {required this.taskId,
      required this.task,
      this.taskDescription,
      required this.taskPriority});

  Map<String, dynamic> toMap() {
    return {
      "Task Id": taskId,
      "Task": task,
      "Task Description": taskDescription,
      "Task Priority": taskPriority
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> taskMap) {
    return TaskModel(
        taskId: taskMap['Task Id'],
        task: taskMap["Task"],
        taskPriority: taskMap["Task Priority"],
        taskDescription: taskMap["Task Description"]);
  }
}
