import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_desk/screens/login_screens/user_login_screen/controller/user_login_screen_controller.dart';
import 'package:medical_desk/screens/login_screens/widgets/login_as_doctor_bottom_button.dart';
import 'package:medical_desk/screens/login_screens/widgets/login_widget.dart';
import '../../../medical_desk.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: UserLoginScreenController(),
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
                  const LoginWidget(isClinic: false,),
                  const Spacer(),
                  const LoginAsDoctorPatientButton(isClinic: false,),
                ],
              )
            ),
          );
        });
  }
}

