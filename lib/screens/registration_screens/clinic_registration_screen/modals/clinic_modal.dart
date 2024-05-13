import 'package:image_picker/image_picker.dart';

import '../../../../modals/doctor_modal.dart';

class Clinic {
  final String? name;
  final String? email;
  final String? password;
  final String? addressLine1;
  final String? addressLine2;
  final String? pinCode;
  final String? state;
  final String? city;
  final String? number;
  final String? emergencyContact;
  final List<OperatingHour>? _operatingHours;
  final List<String>? selectedDepartment;
  final List<XFile>? selectedImages;
  List<DoctorData>? _doctors;

  Clinic({
    this.name,
    this.password,
    this.email,
    this.addressLine1,
    this.addressLine2,
    this.pinCode,
    this.state,
    this.city,
    this.number,
    this.emergencyContact,
    this.selectedDepartment,
    this.selectedImages,
    List<DoctorData>? doctors,
    List<OperatingHour>? operatingHours,
  }): _doctors = doctors ?? [],_operatingHours = operatingHours ?? [] ;



  // Setter for doctors
  set doctors(List<DoctorData> doctors) {
    _doctors = doctors;
  }

  // Method to add a new doctor
  void addDoctor(DoctorData doctor) {
    _doctors?.add(doctor);
  }

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      pinCode: json['pinCode'],
      state: json['state'],
      city: json['city'],
      number: json['number'],
      emergencyContact: json['emergencyContact'],
      operatingHours: List<OperatingHour>.from(json['_operatingHours'].map((OperatingHourJson) => OperatingHour.fromJson(OperatingHourJson))),
      selectedDepartment: List<String>.from(json['selectedDepartment']),
      selectedImages: List<XFile>.from(json['selectedImages'].map((imagePath) => XFile(imagePath))),
      doctors: List<DoctorData>.from(json['_doctors'].map((doctorJson) => DoctorData.fromJson(doctorJson))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'pinCode': pinCode,
      'state': state,
      'city': city,
      'number': number,
      'emergencyContact': emergencyContact,
      'operatingHours': _operatingHours?.map((OperatingHour) => OperatingHour.toJson()).toList(),
      'selectedDepartment': selectedDepartment,
      'selectedImages': selectedImages?.map((image) => image.path).toList(),
      'doctors': _doctors?.map((doctor) => doctor.toJson()).toList(),
    };
  }
}



class OperatingHour {
  final String startTime;
  final String endTime;

  OperatingHour({
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory OperatingHour.fromJson(Map<String, dynamic> json) {
    return OperatingHour(
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}



