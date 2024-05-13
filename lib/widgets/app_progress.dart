import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_desk/medical_desk.dart';

class AppProgress {
  static final AppProgress _singleton = AppProgress._internal();

  factory AppProgress() {
    return _singleton;
  }

  AppProgress._internal();

  DialogRoute? dialog;

  show({String? message}) {
    dialog = DialogRoute(
        builder: (context) => AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: ThemeColor.primaryBlue90ff,),
              SizedBox(
                height: 10,
              ),
              if (message != null) TextView(message),
            ],
          ),
        ),
        context: Get.context!);
    if (dialog != null) {
      Navigator.of(Get.key.currentContext!).push(dialog!);
    }
  }

  dismiss() {
    if (dialog != null) {
      if (dialog!.isActive) {
        Get.removeRoute(dialog!);
      }
    }
  }
}
