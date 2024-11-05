
import 'package:task_manager_1/data/models/user_data.dart';

class LoginResponse {
  String? status;
  String? token;
  UserData? userdata;

  LoginResponse({this.status, this.token, this.userdata});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userdata =
    json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}