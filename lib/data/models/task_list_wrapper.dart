
import 'package:task_manager_1/data/models/task_items.dart';

class TaskListWrapper {
  String? status;
  List<TaskItems>? taskList;

  TaskListWrapper({this.status, this.taskList});

  TaskListWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskItems>[];
      json['data'].forEach((v) {
        taskList!.add(TaskItems.fromJson(v));
      });
    }
  }
}