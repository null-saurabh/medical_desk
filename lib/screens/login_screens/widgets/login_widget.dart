import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medical_desk/screens/login_screens/widgets/login_widget_controller.dart';
import 'package:pinput/pinput.dart';
import '../../../../medical_desk.dart';

class LoginWidget extends StatelessWidget {
  final bool isClinic;
  const LoginWidget({super.key, required this.isClinic});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LoginWidgetController(),
        builder: (_) {
          if (!isClinic) {
            return Obx(() => Form(
                  key: _.formKey1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView(
                            "Login",
                            fontsize: 24,
                            fontweight: FontWeight.w600,
                            textColor: ThemeColor.primaryBlue90ff,
                          ),
                          TextView(" to Your Account",
                              fontsize: 24, fontweight: FontWeight.w400)
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      EditText(
                          prefixSize: 40,
                          // height: 22,
                          fillColor: ThemeColor.lightBlueF7ff,
                          filled: true,
                          readOnly: _.isOtpSend.value ? true: false,
                          prefix: const Icon(Icons.call),
                          suffix: _.isOtpSend.value
                              ? InkWell(
                                  onTap: () {
                                    _.isOtpSend.value = false;
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Icon(Icons.edit_outlined),
                                  ),
                                )
                              : null,
                          hint: "Enter Your Mobile Number",
                          suffixSize: 40,
                          controller: _.numberCtrl,
                          inputType: TextInputType.phone,
                          inputformats: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 10,
                          onValidate: (p0) {
                            if (p0!.isEmpty || p0.length != 10) {
                              return "Please Enter Number";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      if (_.isOtpSend.value) ...[
                        TextView(
                          "Enter 6 digit verification code",
                          fontweight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Pinput(
                            length: 6,
                            defaultPinTheme: Constants.defaultPinTheme,
                            controller: _.otpCtrl,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) {
                            },
                            forceErrorState: true,
                            validator: (p0) {
                              if (p0!.isEmpty ||p0.length != 6 ) {
                                return "Invalid Otp";

                              }
                              return _.verifyCredentials();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextView(
                              "Don't receive the OTP ? ",
                              fontweight: FontWeight.w400,
                            ),
                            TextView(
                              "RESEND OTP",
                              fontweight: FontWeight.w500,
                              textColor: ThemeColor.red0000,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                      AppElevatedButton(
                        title: _.isOtpSend.value
                            ? "Verify and Proceed"
                            : "Get OTP",
                        onPressed: () {
                          if (_.isOtpSend.value) {
                            if (_.formKey1.currentState!.validate()) {
                              print("in here 2");
                              _.verifyCredentials();}

                          } else {
                            if (_.formKey1.currentState!.validate()) {
                              _.isOtpSend.value = true;
                            }
                          }
                        },
                      )
                    ],
                  ),
                ));
          }

          else {
            return Form(
              key: _.formKey2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        "Login",
                        fontsize: 24,
                        fontweight: FontWeight.w600,
                        textColor: ThemeColor.primaryBlue90ff,
                      ),
                      TextView(" to Your Account",
                          fontsize: 24, fontweight: FontWeight.w400)
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  EditText(
                      prefixSize: 40,
                      fillColor: ThemeColor.lightBlueF7ff,
                      filled: true,
                      prefix: IconImage(
                        imagePath: AppAssets.clinicCode,
                        size: 24,
                      ),
                      hint: "Enter Your Clinic Code",
                      controller: _.clinicCtrl,
                      inputType: TextInputType.name,
                      inputformats: [
                        UpperCaseTextFormatter(), // Convert text to uppercase
                      ],
                      maxLength: 10,
                      onValidate: (p0) {
                        if (p0!.isEmpty) {
                          return "Please Enter Clinic Code";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  EditText(
                      prefixSize: 40,
                      // height: 22,
                      fillColor: ThemeColor.lightBlueF7ff,
                      filled: true,
                      prefix: IconImage(imagePath: AppAssets.mailIcon),
                      hint: "Enter Your Email",
                      controller: _.emailCtrl,
                      inputType: TextInputType.emailAddress,
                    onValidate:_.validateEmail,
                      // onValidate: (p0) {
                      //   if (p0!.isEmpty) {
                      //     return "Please Enter Email";
                      //   }
                      //   else if(!p0.isEmail){
                      //     return "Please Enter Valid Email";
                      //   }
                      //   else if ( await _.isEmailAlreadyExists(p0)) {
                      //     return "Email already exists";
                      //   }
                      //   return null;
                      // }
                      ),
                  const SizedBox(
                    height: 16,
                  ),
                  EditText(
                      prefixSize: 40,
                      fillColor: ThemeColor.lightBlueF7ff,
                      filled: true,
                      prefix: IconImage(imagePath: AppAssets.passwordIcon),
                      hint: "Password",
                      controller: _.passwordCtrl,
                      inputType: TextInputType.name,
                      onValidate: (p0) {
                        if (p0!.isEmpty) {
                          return "Please Enter Password";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  AppElevatedButton(
                    title: "Sign In",
                    onPressed: () {
                      _.wrongCredential.value = false;
                      if (_.formKey2.currentState!.validate()) {
                        _.verifyClinicCredentials();
                      }
                    },
                  ),
                  Obx(() {
                    return
                    _.wrongCredential.value == true
                      ?Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextView(_.errorMessage.value,textColor: ThemeColor.red,fontsize: 14,),
                        ],
                      ):SizedBox();
                  })

                ],
              ),
            );
          }
        });
  }
}


