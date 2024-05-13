import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_desk/modals/doctor_modal.dart';
import '../modals/clinic_modal.dart';
import '../modals/time_slot_modal.dart';
import 'clinic_form_controller.dart';

class DoctorFormController extends GetxController{

  // GlobalKey<FormState> formKey;
  //
  // DoctorFormController({required this.formKey});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  var nameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var medicalLicenseCtrl = TextEditingController();
  var clinicAffiliation = TextEditingController();
  var areaOfExpertise = TextEditingController();

  var numberCtrl = TextEditingController();
  var operatingHoursCtrl = TextEditingController();

  RxList<String> selectedQualification = RxList.empty();
  RxList<String> qualificationList = ['Allergists/Immunologists', 'Anesthesiologists'].obs;

  RxList<String> selectedSpecialization = RxList.empty();
  RxList<String> specializationList = ['Allergists/Immunologists', 'Anesthesiologists'].obs;

  RxList<String> selectedExpertise = RxList.empty();
  RxList<String> expertiseList = ['Allergists/Immunologists', 'Anesthesiologists'].obs;

  RxList<XFile> selectedImages = <XFile>[].obs;

  final doctorData = Rx<DoctorData?>(null);

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

  void saveDoctorData() {
    if (formKey.currentState!.validate()) {

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

      // Save doctor data
      final doctor = DoctorData(
        name: nameCtrl.text,
        email: emailCtrl.text,
        medicalLicenseNumber: medicalLicenseCtrl.text,
        clinicAffiliation: clinicAffiliation.text,
        areaOfExpertise: areaOfExpertise.text,
        phoneNumber: numberCtrl.text,
        operatingHours: operatingHours,
        qualifications: selectedQualification,
        specializations: selectedSpecialization,
        expertise: selectedExpertise,
        images: selectedImages,
      );
      doctorData.value = doctor;

      if(doctorData.value != null) {
        final ClinicFormController clinicController = Get.find<
            ClinicFormController>();
        clinicController.addDoctor(doctorData.value!);
        clinicController.saveDataLocally();
      }
    }
  }


  void updateSelectedImages(List<XFile> images) {
    selectedImages.addAll(images);
  }

  void redirect() {
    Get.offNamed('/verifiedRedirecting',
      arguments: [true,false]
    );
  }

  void deleteImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  // @override
  // void onClose() {
  //   // Dispose all text controllers to prevent memory leaks
  //   nameCtrl.dispose();
  //   emailCtrl.dispose();
  //   medicalLicenseCtrl.dispose();
  //   clinicAffiliation.dispose();
  //   areaOfExpertise.dispose();
  //   numberCtrl.dispose();
  //   operatingHoursCtrl.dispose();
  //
  //   super.onClose();
  // }

}