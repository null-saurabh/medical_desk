import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWidgetController extends GetxController{

  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey3 = GlobalKey<FormState>();


  var numberCtrl = TextEditingController();
  var otpCtrl = TextEditingController();

  var clinicCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  RxBool isOtpSend = false.obs;
  RxBool wrongCredential = false.obs;

  RxString errorMessage = RxString("Wrong Credential");
  RxBool isEmailExists = RxBool(false);

  static List<Map<String, dynamic>> dummyData = [
    {'phoneNumber': '1234567890', 'otp': '123456'},
    {'phoneNumber': '9876543210', 'otp': '654321'},
  ];

  // static List<Map<String, dynamic>> dummyClinicData = [
  //   {'email': 'admin@gmail.com', 'clinicCode': 'CLINIC01', 'password': '123456'},
  //   {'email': 'admin@gmail.com', 'clinicCode': 'CLINIC02', 'password': '123456'},
  // ];

  String? verifyCredentials() {
    String phoneNumber = numberCtrl.text;
    String otp = otpCtrl.text;

    var entry = dummyData.firstWhere(
          (element) => element['phoneNumber'] == phoneNumber && element['otp'] == otp,
      orElse: () => {'phoneNumber': '', 'otp': ''},
    );

    if (entry['otp'] != "") {
      Get.offNamed('/verifiedRedirecting',
        arguments: [false,true]
      );
      return null;
    } else {
      return "Invalid Otp";
      // Get.snackbar('Error', 'Invalid OTP');
    }
  }

  void verifyClinicCredentials() async {
    String clinicCode = clinicCtrl.text;
    String email = emailCtrl.text;
    String password = passwordCtrl.text;

    final prefs = await SharedPreferences.getInstance();
    final loginData = prefs.getString('login_data');
    if (loginData != null) {
      List<Map<String, dynamic>> loginList = List<Map<String, dynamic>>.from(jsonDecode(loginData));
      print("in here ${loginList}");
      print("in here ${clinicCode}");
      var entry = loginList.firstWhere(
            (element) => element['clinicCode'] == clinicCode,
        orElse: () => <String, dynamic>{},      );
      print("in here ${entry}");

      if (entry.isEmpty) {
        // Case 2: Clinic code not found
        errorMessage.value = "Wrong clinic code";
        wrongCredential.value = true;

      } else {
        if (entry['email'] == email) {
          if (entry['password'] == password) {
            // Successful login
            Get.toNamed('/verifiedRedirecting',
            arguments: [false,false]
            );
          } else {
            // Case 4: Wrong password
            errorMessage.value = "Wrong password";
            wrongCredential.value = true;


          }
        } else {
          // Case 3: User not found
          errorMessage.value = "User not found";
          wrongCredential.value = true;

        }
      }
    } else {
      // Case 1: No registered clinic
      errorMessage.value = "No registered clinic";
      wrongCredential.value = true;

    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Please enter an email";
    } else if (!GetUtils.isEmail(email)) {
      return "Please enter a valid email address";
    } else if (isEmailExists.value) {
      return "Email already exists";
    }
    return null; // Return null for no validation errors
  }

  void isEmailAlreadyExists(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final loginData = prefs.getString('login_data');

    if (loginData != null) {
      final List<dynamic> loginList = jsonDecode(loginData);
       if(loginList.any((login) => login['email'] == email)) {
         isEmailExists.value = true;
       } else{
         isEmailExists.value = false;
       }
    }
    else{
      isEmailExists.value = false;
    }
  }

}