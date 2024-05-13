import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedirectingScreenController extends GetxController{

  RxBool isRedirectedFromClinicRegistration = false.obs;
  RxBool isRedirectedFromUserLogin = false.obs;

  Rx<Map<String, dynamic>?> lastLoginData = Rx<Map<String, dynamic>?>(null);
  @override
  void onInit() {
    super.onInit();
    startCountdown();
    List<bool> arguments = Get.arguments ?? [];
    // Assign arguments
    if (arguments.isNotEmpty) {
      isRedirectedFromClinicRegistration.value = arguments[0];
      isRedirectedFromUserLogin.value = arguments[1];
    }
    if (isRedirectedFromClinicRegistration.value == true) {
      getLastSavedLoginData();
    }
  }

  final countdownSeconds = 10.obs;
  late Timer _timer;

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdownSeconds.value == 0) {
        _timer.cancel();
        redirect();
      } else {
        countdownSeconds.value--;
      }
    });
  }

  void redirect() {
    if(isRedirectedFromClinicRegistration.value){
      Get.offNamed("/clinicLogin");
    }
    else if (isRedirectedFromUserLogin.value){
      Get.offNamed("/userDashboard");
    }
    else {
      Get.offNamed("/clinicDashboard");

    }
  }

  Future<void> getLastSavedLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final loginData = prefs.getString('login_data');
    if (loginData != null) {
      final List<Map<String, dynamic>> loginList =
      List<Map<String, dynamic>>.from(jsonDecode(loginData));
      if (loginList.isNotEmpty) {
        lastLoginData.value = loginList.last;
      }
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}