import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_desk/screens/login_screens/clinic_login_screen/controller/clinic_login_screen_controller.dart';
import 'package:medical_desk/screens/login_screens/widgets/login_as_doctor_bottom_button.dart';
import 'package:medical_desk/screens/login_screens/widgets/login_widget.dart';

import '../../../medical_desk.dart';

class ClinicLoginScreen extends StatelessWidget {
  const ClinicLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ClinicLoginScreenController(),
        builder: (_) {
          return AppScaffold(
            showTopRadius: false,
            showAppbar: false,
            bgColor: ThemeColor.white,
            showLeading: false,
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: ImageView(
                          imagePath: AppAssets.appLogo,
                          imageType: ImageType.asset,
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 127.5,
                        ),),
                    ),
                    const LoginWidget(isClinic: true,),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextView("Not a member? ",textColor: ThemeColor.greyLight,fontsize: 14,),
                        InkWell(
                          onTap: (){
                            Get.toNamed("/clinicRegistration");
                          },
                            child: TextView("Register Now",textColor: ThemeColor.primaryBlue90ff,fontsize: 14,)),
                      ],
                    ),
                    const Spacer(),
                    const LoginAsDoctorPatientButton(isClinic: true,),
                  ],
                )
            ),
          );
        });
  }
}
