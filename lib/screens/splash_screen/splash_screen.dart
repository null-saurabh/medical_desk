import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:medical_desk/screens/splash_screen/controller/splash_screen_controller.dart';

import '../../medical_desk.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<SplashScreenController>(
          init: SplashScreenController(),
          builder: (_) {
            return ScaleTransition(
              scale: _.animation, // Apply animation to scale the icon
              child: ImageView(
                imagePath: AppAssets.appLogo, // Use your provided image
                imageType: ImageType.asset,
                width: MediaQuery.of(context).size.width / 1.5,
              ),
            );
          },
        ),
      ),
    );
  }
}

//AnimatedSplashScreen(
//       splash: ImageView(
//         imagePath: AppAssets.appLogo, // Use your provided image
//         imageType: ImageType.asset,
//         width: MediaQuery.of(context).size.width / 1.5,
//       ),
//       nextScreen: UserLoginScreen(), // Navigate to your desired screen after the animation completes
//       splashTransition: SplashTransition.scaleTransition, // Use scale transition for splash animation
//       duration: 3000, // Set the duration of the splash animation (in milliseconds)
//       backgroundColor: Colors.white, // Change the background color as needed
//     );