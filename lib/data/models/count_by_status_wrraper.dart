
import 'package:task_manager_1/data/models/task_by_status_data.dart';

class CountBuyTaskWrapper {
  String? status;
  List<TaskCountBuyStatusData>? listOfTaskStatusData;

  CountBuyTaskWrapper({this.status, this.listOfTaskStatusData});

  CountBuyTaskWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfTaskStatusData = <TaskCountBuyStatusData>[];
      json['data'].forEach((v) {
        listOfTaskStatusData!.add(TaskCountBuyStatusData.fromJson(v));
      });
    }
  }
}