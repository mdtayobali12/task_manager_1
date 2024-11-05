import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:task_manager_1/presentation/controllers/add_new_task_screen_conroller.dart';
import 'package:task_manager_1/presentation/controllers/count_task_by_status.dart';
import 'package:task_manager_1/presentation/controllers/new_task_controller.dart';
import 'package:task_manager_1/presentation/controllers/sing_in_controller.dart';
class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingInController());
    Get.lazyPut(() => CountTaskByStatusController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => AddNewTaskScreenController());

  }
}