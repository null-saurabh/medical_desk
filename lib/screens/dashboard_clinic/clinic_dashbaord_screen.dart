import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../medical_desk.dart';

class ClinicDashboardScreen extends StatelessWidget {
  const ClinicDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Get.offNamed("/clinicLogin");
            },
            child: TextView("Log Out from clinic"),
          ),
        )
      ],
    ));
  }
}
