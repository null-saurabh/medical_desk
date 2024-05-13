import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medical_desk/widgets/app_progress.dart';

class RegistrationFormService {
  static final RegistrationFormService _singleton = RegistrationFormService
      ._internal();

  factory RegistrationFormService() {
    return _singleton;
  }

  RegistrationFormService._internal();



  Future<Map<String, String>> getDataFromPinCode(String pinCode,{bool showProgress = true}) async {
    final url = "http://www.postalpincode.in/api/pincode/$pinCode";
    Map<String, String> pinCodeDetails = {};

    if (showProgress) {
      AppProgress().show();
    }
    try {
      final response = await http.get(Uri.parse(url));

      if (showProgress) {
        AppProgress().dismiss();
      }

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['Status'] == 'Error') {
          // Pin code is not valid
          pinCodeDetails['error'] = 'Pin Code is not valid.';
        } else {
          // Parse and return details if the PIN code is valid
          final postOfficeArray = jsonResponse['PostOffice'] as List;
          final obj = postOfficeArray[0];

          final district = obj['District'];
          final state = obj['State'];
          final country = obj['Country'];

          pinCodeDetails['district'] = district;
          pinCodeDetails['state'] = state;
          pinCodeDetails['country'] = country;
        }
      } else {
        // Failed to fetch data
        pinCodeDetails['error'] = 'Failed to fetch data. Please try again.';
      }
    } catch (e) {
      // Error occurred during the API call
      pinCodeDetails['error'] = 'Error occurred. Please try again.';
    }

    return pinCodeDetails;
  }

}