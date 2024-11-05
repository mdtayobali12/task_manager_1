import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_1/presentation/utils/app_colors.dart';
void showSnackBarMessage(BuildContext context, String message,
    [bool isErrorMessage = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(message),
        backgroundColor: isErrorMessage ? ColorRed : null),
  );
}
