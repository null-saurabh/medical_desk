import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_desk/services/login/web_service.dart';
import 'package:medical_desk/services/registration_form/web_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/clinic_modal.dart';
import '../../../../modals/doctor_modal.dart';
import '../modals/time_slot_modal.dart';
import 'clinic_registration_controller.dart';

class ClinicFormController extends GetxController{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegistrationFormService registrationFormService = RegistrationFormService();

  var nameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var addressLine1Ctrl = TextEditingController();
  var addressLine2Ctrl = TextEditingController();
  var pinCodeCtrl = TextEditingController();
  var stateCtrl = TextEditingController();
  var cityCtrl = TextEditingController();

  var numberCtrl = TextEditingController();
  var emergencyContactCtrl = TextEditingController();

  var slotStartCtrl = TextEditingController();
  var slotEndCtrl = TextEditingController();

  RxList<String> selectedDepartment = RxList.empty();
  RxList<String> departmentList = ['Allergists/Immunologists', 'Anesthesiologists'].obs;

  RxList<XFile> selectedImages = <XFile>[].obs;

  final clinicData = Rx<Clinic?>(null);

  final timeSlots = <TimeSlot>[TimeSlot()].obs;



  // Method to add a new time slot widget
  void addTimeSlot() {
    timeSlots.add(TimeSlot());
  }

  void removeTimeSlot(int index) {
    if (timeSlots.length > 1) {
      timeSlots.removeAt(index);
    }
  }

  @override
  void onInit() {
    super.onInit();
    pinCodeCtrl.addListener(() {
      if (pinCodeCtrl.text.length == 6) {
        getDataFromPinCode(pinCodeCtrl.text);
      }
    });
  }


  void saveClinicData() {

    List<OperatingHour> operatingHours = [];

// Populate the operatingHours list from your UI data
    for (final slot in timeSlots) {
      operatingHours.add(
        OperatingHour(
          startTime: slot.startController.text,
          endTime: slot.endController.text,
        ),
      );
    }

      // Collect data from form fields
    final clinic = Clinic(
      name: nameCtrl.text,
      email: emailCtrl.text,
      password: passwordCtrl.text,
      addressLine1: addressLine1Ctrl.text,
      addressLine2: addressLine2Ctrl.text,
      pinCode: pinCodeCtrl.text,
      state: stateCtrl.text,
      city: cityCtrl.text,
      number: numberCtrl.text,
      emergencyContact: emergencyContactCtrl.text,
      operatingHours: operatingHours,
      selectedDepartment: selectedDepartment.toList(),
      selectedImages: selectedImages.toList(),
    );

      clinicData.value = clinic;
      print("saved");
  }

  void addDoctor(DoctorData doctorData) {
    if (clinicData.value != null) {
      clinicData.value!.addDoctor(doctorData);
    }
  }

  void nextForm() {
    ClinicRegistrationController controller = ClinicRegistrationController();
    controller.goToDoctorForm();
    print("in here 13");

  }

  void saveDataLocally()async {
    if (clinicData.value != null) {
      final prefs = await SharedPreferences.getInstance();
      final clinicJson = json.encode(clinicData.value!.toJson());
      await prefs.setString('clinic_data', clinicJson);
    }
    final String email = clinicData.value!.email!;
    final String password = clinicData.value!.password!;
    LoginService().saveLoginData(email, password);
  }


  //   Future<void> loadClinicData() async {
  //     final prefs = await SharedPreferences.getInstance();
  //     final clinicJson = prefs.getString('clinic_data');
  //     if (clinicJson != null) {
  //       final clinic = Clinic.fromJson(clinicJson);
  //       clinicData.value = clinic;
  //     }
  //   }

  void updateSelectedImages(List<XFile> images) {
    selectedImages.addAll(images);
  }

  void deleteImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }



  Future<void> getDataFromPinCode(String pinCode) async {
    final pinCodeDetails = await registrationFormService.getDataFromPinCode(pinCode);

    if (pinCodeDetails.containsKey('error')) {
      Get.snackbar('Error', pinCodeDetails['error'] ?? "Unknown Error");

    } else {
      cityCtrl.text = pinCodeDetails['district'] ?? "";
      stateCtrl.text = pinCodeDetails['state'] ?? "";
    }
  }

  // @override
  // void onClose() {
  //   // Dispose your text controllers here to prevent memory leaks
  //   nameCtrl.dispose();
  //   emailCtrl.dispose();
  //   addressLine1Ctrl.dispose();
  //   addressLine2Ctrl.dispose();
  //   pinCodeCtrl.dispose();
  //   stateCtrl.dispose();
  //   cityCtrl.dispose();
  //   numberCtrl.dispose();
  //   emergencyContactCtrl.dispose();
  //   slotStartCtrl.dispose();
  //   slotEndCtrl.dispose();
  //   // Dispose other text controllers
  //   super.onClose();
  // }

}