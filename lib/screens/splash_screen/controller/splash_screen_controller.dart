import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Increase the duration to 5 seconds
    );
    animation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut, // Use a custom animation curve
    ),);
    animationController.forward(); // Start the animation
    // Navigate to your desired screen after the animation completes
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offNamed("/userLogin");
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose(); // Dispose the animation controller to prevent memory leaks
    super.onClose();
  }

}
