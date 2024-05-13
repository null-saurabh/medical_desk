import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_desk/screens/registration_screens/clinic_registration_screen/controller/doctor_form_controller.dart';

import '../../../../medical_desk.dart';

class DoctorRegistrationForm extends StatelessWidget {
  final DoctorFormController controller;
  const DoctorRegistrationForm({super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext contexgit commit -m "first commit"t) {
    // print("in doctor form");
    return GetBuilder(
        init: controller,
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
                key: _.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditText(
                        hint: "Mr/ Mrs",
                        showLabel: true,
                        labelText: "Name",
                        showRequired: true,
                        controller: _.nameCtrl,
                        onValidate: (p0) {
                          if (p0!.isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        }),
                    SizedBox(height: 8,),
                    ImagePickerButton(
                      title: "Upload your photo",
                      onImagesSelected: (List<XFile> selectedImages) {
                        _.updateSelectedImages(selectedImages);
                      },
                    ),
                    SizedBox(height: 8,),
                    Obx(() =>Column(
                      children: [
                        if(_.selectedImages.isNotEmpty)
                        PickedImageWidget(
                          selectedImages: _.selectedImages,
                          onDelete: (index) {
                            _.deleteImage(index);
                          },
                        ),
                      ],
                    ),),
                    EditText(
                        hint: "Enter Your Number",
                        showLabel: true,
                        labelText: "Contact Information*",
                        showRequired: true,
                        controller: _.numberCtrl,
                        onValidate: (p0) {
                          if (p0!.isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        }),
                    SizedBox(height: 8,),
                    EditText(
                        hint: "Enter your email address",
                        showLabel: true,
                        labelText: "Email",
                        showRequired: true,
                        controller: _.emailCtrl,
                        // onValidate: (p0) {
                        //   if (p0!.isEmpty) {
                        //     return "Please fill out this field";
                        //   }
                        //   return null;
                        // }
                        ),
                    SizedBox(height: 8,),
                    Obx(() => MultiSelectAppDropDown(
                      labelText: "Specialization",
                      showLabel: true,
                      showRequired: true,
                      hintText: "What is your Specialization",
                      items: _.specializationList
                          .dropDownItem(
                            (element) => element,
                      ),
                      selectedItems: _.selectedSpecialization,
                      displaySelectedValues: _.selectedSpecialization.map((element) => element).join(','),
                      onChangeSelection: (value){
                        _.selectedSpecialization.toggleValue(value);
                      },
                      onValidate: (p0) {
                    if (p0 == null) {
                    return "Please select an item from list";
                    }
                    return null;
                    },
                      value: _.selectedSpecialization.isNotEmpty?_.selectedSpecialization.last :null,
                    )),
            
                    SizedBox(height: 8,),
                    Obx(() => MultiSelectAppDropDown(
                      labelText: "Qualification",
                      showLabel: true,
                      showRequired: true,
                      hintText: "Enter your qualification",
                      items: _.qualificationList
                          .dropDownItem(
                            (element) => element,
                      ),
                      selectedItems: _.selectedQualification,
                      displaySelectedValues: _.selectedQualification.map((element) => element).join(','),
                      onChangeSelection: (value){
                        _.selectedQualification.toggleValue(value);
                      },
                      onValidate: (p0) {
                        if (p0 == null) {
                          return "Please select an item from list";
                        }
                        return null;
                      },
                      value: _.selectedQualification.isNotEmpty?_.selectedQualification.last :null,
                    )),
            
                    SizedBox(height: 8,),
                    EditText(
                        hint: "Enter your medical license number",
                        showLabel: true,
                        labelText: "Medical License Number*",
                        showRequired: true,
                        controller: _.medicalLicenseCtrl,
                        onValidate: (p0) {
                          if (p0!.isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        }),
                    SizedBox(height: 8,),
                    Obx(() => MultiSelectAppDropDown(
                        labelText: "Area of Experties",
                        showLabel: true,
                        showRequired: true,
                        hintText: "Select area of experties",
                      items: _.expertiseList
                          .dropDownItem(
                            (element) => element,
                      ),
                      selectedItems: _.selectedExpertise,
                      displaySelectedValues: _.selectedExpertise.map((element) => element).join(','),
                      onChangeSelection: (value){
                        _.selectedExpertise.toggleValue(value);
                      },
                      onValidate: (p0) {
                        if (p0 == null) {
                          return "Please select an item from list";
                        }
                        return null;
                      },
                      value: _.selectedExpertise.isNotEmpty?_.selectedExpertise.last :null,
                    )),
            
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        TextView(
                          "Operating hours",
                          textColor: ThemeColor.black,
                          fontweight: FontWeight.w500,
                          fontsize: 16,
                        ),
                        TextView(
                          "*", // Required indicator
                          textColor: ThemeColor.red0000,
                          fontweight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Obx(() {
                          return Column(
                            children:
                            _.timeSlots.asMap().entries.map((entry) {
                              final index = entry.key;
                              final slot = entry.value;
            
                              return Row(
                                children: [
                                  TimeSlotWidget(
                                    startController: slot.startController,
                                    endController: slot.endController,
                                    width: 82,
                                    showRequired: true,
                                    bottomPadding: true,
                                    labelTxt: "Operating hours",
                                    onStartChange: slot.onStartChange,
                                    onEndChange: slot.onEndChange,
                                    onValidate: slot.onValidate,
            
                                  ),
                                  if (_.timeSlots.length > 1) // Only add button after the last time slot
                                    IconButton(
                                      onPressed: () {
                                        _.removeTimeSlot(index);
                                      },
                                      icon: Icon(Icons.delete_forever_outlined,color: ThemeColor.red0000,),
                                    ),
                                  if (slot == _.timeSlots.last) // Only add button after the last time slot
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          AppElevatedButton(
                                            width:MediaQuery.of(context).size.width >= 104 ? 104 : null,
                                            onPressed: () {
                                              _.addTimeSlot(); // Call the controller method to add a new time slot
                                            },
                                            child: TextView('+ Slot',textColor: ThemeColor.white,),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 8,),
                    // AppElevatedButton(
                    //   title: "Submit",
                    //     onPressed: () {
                    //       if(_.formKey.currentState!.validate()){
                    //         if(_.selectedImages.isNotEmpty){
                    //           _.saveDoctorData();
                    //           _.redirect();
                    //
                    //         }
                    //         else {
                    //           // Show error message using GetX's snackbar
                    //           Get.snackbar(
                    //             'Error',
                    //             'Please add at least one image',
                    //             snackPosition: SnackPosition.BOTTOM,
                    //             backgroundColor: Colors.red,
                    //             colorText: Colors.white,
                    //           );
                    //         }
                    //       }
                    //     },
                    //
                    // ),
                    SizedBox(height: 8,),
            
            
            
                  ],
                )),
          );
        });
  }
}
