import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../medical_desk.dart';

class LoginAsDoctorPatientButton extends StatelessWidget {
  final bool isClinic;
  const LoginAsDoctorPatientButton({
    required this.isClinic,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(isClinic){
          Get.offNamed("/userLogin");
        }
        else{
          Get.offNamed("/clinicLogin");
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconImage(imagePath: AppAssets.loginDoctor, size: 24),
          SizedBox(
            width: 5,
          ),
          TextView(
            "Login as ",
            fontweight: FontWeight.w500,
          ),
          isClinic
              ? TextView(
                  "Patient",
                  fontweight: FontWeight.w500,
                  textColor: ThemeColor.primaryBlue90ff,
                )
              : TextView(
                  "Doctor",
                  fontweight: FontWeight.w500,
                  textColor: ThemeColor.primaryBlue90ff,
                ),
        ],
      ),
    );
  }
}
