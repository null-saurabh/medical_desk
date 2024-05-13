import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_desk/screens/registration_screens/clinic_registration_screen/controller/clinic_form_controller.dart';
import '../../../../medical_desk.dart';

class ClinicRegistrationForm extends StatelessWidget {
  final ClinicFormController controller;
  const ClinicRegistrationForm({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
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
                        hint: "Enter Name of the Clinic(Required)*",
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
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                        hint: "Enter your Clinic Mobile number",
                        showLabel: true,
                        labelText: "Contact",
                        showRequired: true,
                        controller: _.numberCtrl,
                        inputType: TextInputType.number,
                        inputformats: [FilteringTextInputFormatter.digitsOnly],
                        onValidate: (p0) {
                          if (p0!.isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                      hint: "Enter your Clinic Email",
                      showLabel: true,
                      labelText: "Email",
                      showRequired: true,
                      inputType: TextInputType.emailAddress,
                      controller: _.emailCtrl,
                      onValidate: (p0) {
                        if (p0!.isEmpty) {
                          return "Please fill out this field";
                        }
                        return null;
                      }
                    ),
            
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                        hint: "Password",
                        showLabel: true,
                        labelText: "Create New Password",
                        showRequired: true,
                        inputType: TextInputType.name,
                        controller: _.passwordCtrl,
                        onValidate: (p0) {
                          if (p0!.isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                        hint: "House No, Building Name(Required)*",
                        showLabel: true,
                        labelText: "Address",
                        showRequired: true,
                        controller: _.addressLine1Ctrl,
                        onValidate: (p0) {
                          if (p0!.isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                      hint: "Road name, Area, Colony(Required)*",
                      showRequired: true,
                      controller: _.addressLine2Ctrl,
                      // onValidate: (p0) {
                      //   if (p0!.isEmpty) {
                      //     return "Please fill out this field";
                      //   }
                      //   return null;
                      // }
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                        hint: "Pincode(Required)*",
                        showRequired: true,
                        controller: _.pinCodeCtrl,
                        inputType: TextInputType.number,
                        onValidate: (p0) {
                          if (p0!.isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                        hint: "State(Required)*",
                        showRequired: true,
                        controller: _.stateCtrl,
                        onValidate: (p0) {
                          if (p0!.isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                        hint: "City(Required)*",
                        showRequired: true,
                        controller: _.cityCtrl,
                        onValidate: (p0) {
                          if (p0!.isEmpty) {
                            return "Please fill out this field";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 8,
                    ),
                    AppElevatedButton(
                      width: 226,
                      height: 48,
                      child: Row(
                        children: [
                          Icon(
                            Icons.my_location,
                            color: ThemeColor.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          TextView(
                            "Use my location",
                            fontweight: FontWeight.w500,
                            textColor: ThemeColor.white,
                          )
                        ],
                      ),
                      // title: ,
                      onPressed: () {},
                    ),
            
                    SizedBox(
                      height: 8,
                    ),
                    Obx(() => MultiSelectAppDropDown(
            
                          labelText: "Speciality/Department",
                          hintText: "Select Speciality/Department",
                          showLabel: true,
                          showRequired: true,
                          items: _.departmentList.dropDownItem(
                            (element) => element,
                          ),
                          selectedItems: _.selectedDepartment,
                          displaySelectedValues: _.selectedDepartment
                              .map((element) => element)
                              .join(','),
                          onChangeSelection: (value) {
                            _.selectedDepartment.toggleValue(value);
                          },
                          onValidate: (value) {
                            print("on vali");
                            if (value == null) {
                              print("on valia");
                              return "Please select an item from list";
                            }
                            return null;
                          },
                          value: _.selectedDepartment.isNotEmpty
                              ? _.selectedDepartment.last
                              : null,
                        )),
                    SizedBox(
                      height: 8,
                    ),
            
                    // TimeSlotWidget(
                    //   startController: _.slotStartCtrl,
                    //   endController: _.slotEndCtrl,
                    //   width: 80,
                    //   showRequired: true,
                    //
                    //   labelTxt: "Operating hours",
                    //   onStartChange: (selectedDate) {
                    //     _.slotStartCtrl.text = selectedDate.tohhmma();
                    //   },
                    //   onEndChange: (selectedDate) {
                    //     _.slotEndCtrl.text = selectedDate.tohhmma();
                    //   },
                    //   onValidate: (value) {
                    //     if (value!.isEmpty) {
                    //       return "Please select Time Slot";
                    //     }
                    //     return null;
                    //   },
                    // ),
            
            
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
                                  Spacer(),
                                  if (slot == _.timeSlots.last) // Only add button after the last time slot
                                    AppElevatedButton(
                                      width:104,
                                      onPressed: () {
                                        _.addTimeSlot(); // Call the controller method to add a new time slot
                                      },
                                      child: TextView('+ Slot',textColor: ThemeColor.white,),
                                    ),
                                ],
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
            
                    ImagePickerButton(
                      title: "Upload clinic photo",
                      onImagesSelected: (List<XFile> selectedImages) {
                        _.updateSelectedImages(selectedImages);
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Obx(() {
                      if (_.selectedImages.isNotEmpty) {
                        return PickedImageWidget(
                          selectedImages: _.selectedImages,
                          onDelete: (index) {
                            _.deleteImage(index);
                          },
                        );
                      } else {
                        return SizedBox
                            .shrink(); // Example: returning an empty SizedBox
                      }
                    }),
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                      hint: "Number",
                      showLabel: true,
                      labelText: "Emergency Contact Details",
                      showRequired: true,
                      controller: _.emergencyContactCtrl,
                      inputformats: [FilteringTextInputFormatter.digitsOnly],
                      inputType: TextInputType.number,
                      // onValidate: (p0) {
                      //   if (p0!.isEmpty) {
                      //     return "Please fill out this field";
                      //   }
                      //   return null;
                      // }
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // AppElevatedButton(
                    //   title: "Next",
                    //   onPressed: () {
                    //     // if (_.formKey.currentState!.validate()) {
                    //       if (_.selectedImages.isNotEmpty) {
                    //         print("in here 11");
                    //         _.saveClinicData();
                    //         print("in here 112");
                    //         _.nextForm();
                    //       } else {
                    //         // Show error message using GetX's snackbar
                    //         Get.snackbar(
                    //           'Error',
                    //           'Please add at least one image',
                    //           snackPosition: SnackPosition.BOTTOM,
                    //           backgroundColor: Colors.red,
                    //           colorText: Colors.white,
                    //         );
                    //       }
                    //     // }
                    //   },
                    // ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                )),
          );
        });
  }
}
