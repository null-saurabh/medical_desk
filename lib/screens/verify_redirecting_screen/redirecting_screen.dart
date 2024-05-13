import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_desk/screens/verify_redirecting_screen/redirecting_controller.dart';
import '../../../medical_desk.dart';

class VerifiedRedirectingScreen extends StatelessWidget {
  const VerifiedRedirectingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RedirectingScreenController(),
        builder: (_) {
          return AppScaffold(
            showTopRadius: false,
            showAppbar: false,
            bgColor: ThemeColor.white,
            showLeading: false,
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ImageView(
                        imagePath: AppAssets.verifiedImage,
                        imageType: ImageType.asset,
                        width: 136,
                        height: 132,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    _.isRedirectedFromClinicRegistration.value == false
                        ? _.isRedirectedFromUserLogin.value == true
                        ?TextView(
                            "Otp Verified!",
                            fontweight: FontWeight.w600,
                            fontsize: 24,
                          ):
                    TextView(
                      "Welcome!",
                      fontweight: FontWeight.w600,
                      fontsize: 24,
                    )
                        : TextView(
                            "Registration Completed!",
                            fontweight: FontWeight.w600,
                            fontsize: 24,
                          ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(() {
                      if (_.lastLoginData.value != null) {
                        return Column(
                          children: [
                            TextView(
                              "Last Login Details:",
                              fontweight: FontWeight.w600,
                              fontsize: 18,
                            ),
                            SizedBox(height: 8),
                            TextView(
                              "Clinic Code: ${_.lastLoginData.value!['clinicCode']}",
                              fontsize: 16,
                            ),
                            TextView(
                              "Email: ${_.lastLoginData.value!['email']}",
                              fontsize: 16,
                            ),
                            TextView(
                              "Password: ${_.lastLoginData.value!['password']}",
                              fontsize: 16,
                            ),
                          ],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    TextView(
                      "You will be redirected to the main page",
                      fontweight: FontWeight.w400,
                      fontsize: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(
                          "in ",
                          fontweight: FontWeight.w400,
                        ),
                        Obx(
                              () => TextView(
                            _.countdownSeconds.value.toString(),
                            fontweight: FontWeight.w400,
                            textColor: Colors.red,
                          ),
                        ),
                        TextView(
                          " seconds.",
                          fontweight: FontWeight.w400,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(
                          "If not redirected! ",
                          fontweight: FontWeight.w400,
                          fontsize: 16,
                        ),
                        InkWell(
                            onTap:  (){_.redirect();},
                            child:
                            TextView(
                              "Click Here",
                              fontweight: FontWeight.w400,
                              fontsize: 16,
                              textColor: ThemeColor.primaryBlue90ff,
                            ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        });
  }
}
