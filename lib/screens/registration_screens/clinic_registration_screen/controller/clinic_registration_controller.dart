import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_desk/screens/registration_screens/clinic_registration_screen/controller/clinic_form_controller.dart';
import 'package:medical_desk/screens/registration_screens/clinic_registration_screen/controller/doctor_form_controller.dart';
import 'package:medical_desk/screens/registration_screens/clinic_registration_screen/widgets/doctor_registration_form.dart';
import '../widgets/clinic_registration_form.dart';

class ClinicRegistrationController extends GetxController{

  // GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  // GlobalKey<FormState> formKey2 = GlobalKey<FormState>();


  final List<Widget> formWidgets = [];
  // final List<GetxController> formControllers = [];
  final clinicController = ClinicFormController();
  final doctorController = DoctorFormController();
  // final doctorController1 = Get.put(DoctorFormController(formKey: formKey1));


  final RxInt selectedFormIndex = 0.obs;
  // Index of the currently selected form

  @override
  void onInit() {
    super.onInit();
    formWidgets.add(ClinicRegistrationForm(controller: clinicController));
    // formControllers.add(DoctorFormController());
    formWidgets.add(DoctorRegistrationForm(controller: doctorController));
    Get.put<ClinicFormController>(clinicController);
    Get.put<DoctorFormController>(doctorController);
  }
  //
  //
  // void addNewForm() {
  //   if (selectedFormIndex.value == formWidgets.length - 1) {
  //     final doctorController = DoctorFormController(formKey: formKey1);
  //       formControllers.add(doctorController);
  //     formWidgets.add(DoctorRegistrationForm(controller: formControllers.last as DoctorFormController,));
  //     selectedFormIndex.value = formWidgets.length - 1; // Select the newly added form
  //   }
  // }


  void goToDoctorForm() {
    selectedFormIndex.value = 1;
    print("in here 14 ${selectedFormIndex.value}");
    update();
  }


  void redirect() {
    Get.offNamed("/verifiedRedirecting",
      arguments: false,
    );
  }

  Widget getCurrentFormWidget() {
    if (selectedFormIndex.value == 0) {
      return ClinicRegistrationForm(controller: clinicController,);
    } else {
      // final doctorController1 = DoctorFormController(formKey: formKey1);
      return DoctorRegistrationForm(controller: doctorController,);
    }
  }

}