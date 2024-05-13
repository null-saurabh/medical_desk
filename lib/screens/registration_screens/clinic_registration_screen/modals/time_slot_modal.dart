import 'package:flutter/material.dart';
import 'package:medical_desk/medical_desk.dart';

class TimeSlot {
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  void onStartChange(DateTime selectedDate) {
    startController.text = selectedDate.tohhmma();
  }

  void onEndChange(DateTime selectedDate) {
    endController.text = selectedDate.tohhmma();
  }

  String? onValidate(String? value) {
    if (value!.isEmpty) {
      return "Please select Time Slot";
    }
    return null;
  }
}
