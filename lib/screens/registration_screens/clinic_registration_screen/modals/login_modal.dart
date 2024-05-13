
class LoginModel {
  final String email;
  final String clinicCode;
  final String password;

  LoginModel({
    required this.email,
    required this.clinicCode,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      clinicCode: json['clinicCode'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'clinicCode': clinicCode,
      'password': password,
    };
  }
}

