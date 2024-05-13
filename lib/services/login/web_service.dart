import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static const _clinicCodeLength = 4;


  Future<String> _generateRandomClinicCode(List<String> previousCodes) async {
    final random = Random();
    String clinicCode;
    do {
      final codeDigits = List.generate(
        _clinicCodeLength,
            (index) => random.nextInt(10),
      );
      clinicCode = 'CLINIC' + codeDigits.join();
    } while (previousCodes.contains(clinicCode));
    return clinicCode;
  }

  Future<void> saveLoginData(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final loginData = prefs.getString('login_data');
    List<Map<String, dynamic>> loginList = [];

    if (loginData != null) {
      loginList = List<Map<String, dynamic>>.from(jsonDecode(loginData));
    }

    final clinicCodes = loginList.map<String>((data) => data['clinicCode']).toList();
    final clinicCode = await _generateRandomClinicCode(clinicCodes);
    final newLoginData = {
      'email': email,
      'clinicCode': clinicCode,
      'password': password,
    };
    loginList.add(newLoginData);

    await prefs.setString('login_data', jsonEncode(loginList));
  }
}
