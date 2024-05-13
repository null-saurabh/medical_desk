import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_desk/screens/dashboard_clinic/clinic_dashbaord_screen.dart';
import 'package:medical_desk/screens/dashboard_user/user_dashboard_screen.dart';
import 'package:medical_desk/screens/login_screens/clinic_login_screen/clinic_login_screen.dart';
import 'package:medical_desk/screens/login_screens/user_login_screen/user_login_screen.dart';
import 'package:medical_desk/screens/registration_screens/clinic_registration_screen/clinic_registration_screen.dart';
import 'package:medical_desk/screens/splash_screen/splash_screen.dart';
import 'package:medical_desk/screens/verify_redirecting_screen/redirecting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Teaching App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/userLogin', page: () => const UserLoginScreen()),
        GetPage(name: '/clinicLogin', page: () => const ClinicLoginScreen()),
        GetPage(name: '/verifiedRedirecting', page: () => const VerifiedRedirectingScreen(),),
        GetPage(name: '/clinicRegistration', page: () => const ClinicRegistrationScreen()),
        GetPage(name: '/clinicDashboard', page: () => const ClinicDashboardScreen()),
        GetPage(name: '/userDashboard', page: () => const UserDashboardScreen()),
      ],
    );
  }
}
