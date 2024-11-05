import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:task_manager_1/data/models/response_object.dart';
import 'package:task_manager_1/presentation/controllers/auth_controllers.dart';

import '../../app.dart';
import '../../presentation/screen/auth/sing_in_screen.cpp.dart';


class NetworkCaller {
  static Future<ResponseObject> getRequest(String Url) async {
    try {
      final Response response = await get(Uri.parse(Url),
          headers: {"token": AuthControllers.accessToken ?? ""});

      print(response.statusCode.toString());
      print(response.body.toString());

      if (response.statusCode == 200) {
        final ResponseDecoded = jsonDecode(response.body);
        return ResponseObject(
            isSuccess: true, statusCode: 200, ResponseBody: ResponseDecoded, responseBody: null);
      } else if (response.statusCode == 401) {
        _moveToSingIn();
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            ResponseBody: "", responseBody: null);
      } else {
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            ResponseBody: "", responseBody: null);
      }
    } catch (e) {
      print(e.toString());
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          ResponseBody: "",
          ErrorMessage: e.toString(), responseBody: null);
    }
  }

  static Future<ResponseObject> postRequest(
      String Url, Map<String, dynamic> Body,{bool formInSingIn = false}) async {
    try {
      final Response response = await post(Uri.parse(Url),
          body: jsonEncode(Body),
          headers: {
            "Content-type": "application/json",
            "token": AuthControllers.accessToken ?? ""
          });

      print(response.statusCode.toString());
      print(response.body.toString());

      if (response.statusCode == 200) {
        final ResponseDecoded = jsonDecode(response.body);
        return ResponseObject(
            isSuccess: true, statusCode: 200, ResponseBody: ResponseDecoded, responseBody: null);
      }  else if (response.statusCode == 401) {
        if(formInSingIn){
          return ResponseObject(
              isSuccess: false,
              statusCode: response.statusCode,
              ResponseBody: "",
              ErrorMessage: "Email/password is incorrect ", responseBody: null);
        }else {
          _moveToSingIn();
        }
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            ResponseBody: "", responseBody: null);
      }else {
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            ResponseBody: "",
            ErrorMessage: "Email/password is incorrect ", responseBody: null);
      }
    } catch (e) {
      print(e.toString());
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          ResponseBody: "",
          ErrorMessage: e.toString(), responseBody: null);
    }
  }

  static void _moveToSingIn() async {
    await AuthControllers.ClearUserData();

    Navigator.pushAndRemoveUntil(
        TaskManager.navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => const SingInScreen(),
        ),
            (route) => false);
  }
}