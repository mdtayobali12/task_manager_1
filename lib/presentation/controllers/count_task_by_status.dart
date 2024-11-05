import 'package:get/get.dart';
import 'package:task_manager_1/data/models/count_by_status_wrraper.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utility/Urls.dart';


class CountTaskByStatusController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  CountBuyTaskWrapper _countByStatusWrapper = CountBuyTaskWrapper();

  bool get inProgress => _inProgress;

  String? get errorMessage =>
      _errorMessage ?? "Fetch failed count by task status ";

  CountBuyTaskWrapper get countByStatusWrapper => _countByStatusWrapper;

  Future<bool> getCountByTaskStatus() async {
    bool isSuccess = false;

    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);
    _inProgress = true;

    if (response.isSuccess) {
      _countByStatusWrapper =
          CountBuyTaskWrapper.fromJson(response.ResponseBody);
      isSuccess = true;
    } else {
      _errorMessage = response.ErrorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}