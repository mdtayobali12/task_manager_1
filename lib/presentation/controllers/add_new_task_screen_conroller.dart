import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utility/Urls.dart';
import 'package:task_manager_1/presentation/controllers/count_task_by_status.dart';
import 'package:task_manager_1/presentation/controllers/new_task_controller.dart';
import 'package:task_manager_1/presentation/widgets/show_snack_bar_message.dart';



class AddNewTaskScreenController extends GetxController {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool addNewTaskInProgress = false;


  Future<void> addNewTask(BuildContext context) async {
    addNewTaskInProgress = true;
    update();
    Map<String, dynamic> inputParams = {
      "title": titleController.text.trim(),
      "description": descriptionController.text.trim(),
      "status": "New",
    };
    final response =
    await NetworkCaller.postRequest(Urls.createTask, inputParams);
    addNewTaskInProgress = false;
    update();
    if (response.isSuccess) {
      if (context.mounted) {
        showSnackBarMessage(context, "Task Added Successful");
        Get.find<CountTaskByStatusController>().getCountByTaskStatus();
        Get.find<NewTaskController>().getNewTaskList();
      }
    } else {
      if (context.mounted) {
        showSnackBarMessage(
            context, response.ErrorMessage ?? "Task added failed", true);
      }
    }
    update();
  }


}