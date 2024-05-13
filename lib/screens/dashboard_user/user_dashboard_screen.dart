import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_desk/medical_desk.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Get.offNamed("/userLogin");
            },
            child: TextView("Log Out"),
          ),
        )
      ],
    ));
  }
}
