import 'package:get/get.dart';
import 'package:task_manager_1/data/models/task_list_wrapper.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utility/Urls.dart';


class NewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  TaskListWrapper _newTaskListWrapper = TaskListWrapper();

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage ?? "Fetch New task failed!";

  TaskListWrapper get newTaskListWrapper => _newTaskListWrapper;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.newTaskList);

    if (response.isSuccess) {
      _newTaskListWrapper = TaskListWrapper.fromJson(response.ResponseBody);
    } else {
      _errorMessage = response.ErrorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}

