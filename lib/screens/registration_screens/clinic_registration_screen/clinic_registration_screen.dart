import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_desk/screens/registration_screens/clinic_registration_screen/controller/clinic_registration_controller.dart';
import 'package:medical_desk/screens/registration_screens/clinic_registration_screen/controller/doctor_form_controller.dart';
import '../../../medical_desk.dart';
import 'controller/clinic_form_controller.dart';

class ClinicRegistrationScreen extends StatelessWidget {
  const ClinicRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ClinicRegistrationController(),
        builder: (_) {
          return AppScaffold(
            bgColor: ThemeColor.white,
            centerTitle: true,
            title: "Registration",
            footerWidget: Obx(
              () => Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppElevatedButton(
                  title: _.selectedFormIndex.value == 0 ? "Next" : "Submit",
                  onPressed: () {
                    // print("in here 0");
                    // _.selectedFormIndex.value = 1;
                    if (_.selectedFormIndex.value == 0) {
                      print("in here 2");

                      ClinicFormController controller =
                          Get.find<ClinicFormController>();
                      if (controller.formKey.currentState!.validate()) {
                        print("in here 3");

                        if (controller.selectedImages.isNotEmpty) {
                          print("in here 4");
                          controller.saveClinicData();
                          _.selectedFormIndex.value = 1;
                        } else {
                          print("in here 5");

                          Get.snackbar(
                            'Error',
                            'Please add at least one image',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      }
                    } else {
                      print("in here 6");
                      DoctorFormController controller =
                          Get.find<DoctorFormController>();
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.selectedImages.isNotEmpty) {
                          print("in here 7");

                          controller.saveDoctorData();
                          controller.redirect();
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please add at least one image',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      }
                    }
                  },
                ),
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          // for (int i = 0; i < _.formWidgets.length; i++)
                          //   Expanded(
                          //     child: InkWell(
                          //       onTap: () {
                          //         _.selectedFormIndex.value = i;
                          //       },
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           border: _.selectedFormIndex.value == i
                          //               ? Border(
                          //             bottom: BorderSide(
                          //               color: ThemeColor.primaryBlue90ff,
                          //               width: 4,
                          //             ),
                          //           )
                          //               : null,
                          //         ),
                          //         child: Center(
                          //           child: TextView(
                          //             _.formWidgets[i] is ClinicRegistrationForm ? "Clinic" : "Doctor",
                          //             fontweight: _.selectedFormIndex.value == i
                          //                 ? FontWeight.w600
                          //                 : FontWeight.w400,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),

                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _.selectedFormIndex.value = 0;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: _.selectedFormIndex.value == 0
                                      ? Border(
                                          bottom: BorderSide(
                                            color: ThemeColor.primaryBlue90ff,
                                            width: 4,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Center(
                                  child: TextView(
                                    "Clinic",
                                    fontweight: _.selectedFormIndex.value == 0
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _.selectedFormIndex.value = 1;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: _.selectedFormIndex.value == 1
                                      ? Border(
                                          bottom: BorderSide(
                                            color: ThemeColor.primaryBlue90ff,
                                            width: 4,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Center(
                                  child: TextView(
                                    "Doctor",
                                    fontweight: _.selectedFormIndex.value == 1
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // IconButton(
                          //   icon: Icon(Icons.add),
                          //   onPressed: () {
                          //     // _.addNewForm();
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Obx(() => Expanded(
                          child: _.formWidgets[_.selectedFormIndex.value],
                        )),
                  ],
                )),
          );
        });
  }
}
