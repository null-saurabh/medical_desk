import 'package:image_picker/image_picker.dart';

import '../screens/registration_screens/clinic_registration_screen/modals/clinic_modal.dart';

class DoctorData {
  final String? name;
  final String? email;
  final String? medicalLicenseNumber;
  final String? clinicAffiliation;
  final String? areaOfExpertise;
  final String? phoneNumber;
  final List<OperatingHour>? _operatingHours;
  final List<String>? qualifications;
  final List<String>? specializations;
  final List<String>? expertise;
  final List<XFile>? images;

  DoctorData({
    this.name,
    this.email,
    this.medicalLicenseNumber,
    this.clinicAffiliation,
    this.areaOfExpertise,
    this.phoneNumber,
    this.qualifications,
    this.specializations,
    this.expertise,
    this.images,
    List<OperatingHour>? operatingHours,

  }): _operatingHours = operatingHours ?? [] ;

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
      name: json['name'],
      email: json['email'],
      medicalLicenseNumber: json['medicalLicenseNumber'],
      clinicAffiliation: json['clinicAffiliation'],
      areaOfExpertise: json['areaOfExpertise'],
      phoneNumber: json['phoneNumber'],
      operatingHours: List<OperatingHour>.from(json['_operatingHours'].map((OperatingHourJson) => OperatingHour.fromJson(OperatingHourJson))),
      // operatingHours: json['operatingHours'],
      qualifications: List<String>.from(json['qualifications']),
      specializations: List<String>.from(json['specializations']),
      expertise: List<String>.from(json['expertise']),
      images: List<XFile>.from(json['images'].map((imagePath) => XFile(imagePath))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'medicalLicenseNumber': medicalLicenseNumber,
      'clinicAffiliation': clinicAffiliation,
      'areaOfExpertise': areaOfExpertise,
      'phoneNumber': phoneNumber,
      'operatingHours': _operatingHours?.map((OperatingHour) => OperatingHour.toJson()).toList(),
      'qualifications': qualifications,
      'specializations': specializations,
      'expertise': expertise,
      'images': images?.map((image) => image.path).toList(),
    };
  }
}