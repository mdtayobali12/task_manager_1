import 'package:get/get.dart';
import 'package:task_manager_1/data/models/response_object.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utility/Urls.dart';


import '../../data/models/login_response.dart';
import 'auth_controllers.dart';


class SingInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? "Login failed try again";

  Future<bool> singIn(String email, String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "password": password,
    };

    final ResponseObject response = await NetworkCaller.postRequest(
        Urls.login, inputParams,
        formInSingIn: true);

    _inProgress = false;
    update();
    if (response.isSuccess) {
      LoginResponse loginResponse =
      LoginResponse.fromJson(response.ResponseBody);

      await AuthControllers.SaveUserData(loginResponse.userdata!);
      await AuthControllers.SaveToken(loginResponse.token!);
      update();
      return true;
    } else {
      _errorMessage = response.ErrorMessage;
      update();
      return false;
    }
  }
}
