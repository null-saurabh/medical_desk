import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_desk/medical_desk.dart';


class AppUtils {
  static showProgress() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  static Future<DateTime?> pickDateAndTime(
      {DateTime? selectedDate,
        DateTime? lastDate,
        DateTime? firstDate,
        bool checkFuture = false}) async {
    var initialDate = selectedDate ?? DateTime.now();
    var fDate = firstDate ?? DateTime(1920);
    var lDate = lastDate ?? DateTime.now().add((20 * 365).days);

    DateTime? date = await pickDate(
        selectedDate: initialDate, firstDate: fDate, lastDate: lDate);
    if (date != null) {
      date = DateTime(date.year, date.month, date.day, DateTime.now().hour,
          DateTime.now().minute);
      return await picktime(selectedDate: date, checkFuture: checkFuture);
    }
    return null;
  }

  static Future<DateTime?> pickDate(
      {DateTime? selectedDate,
        DateTime? lastDate,
        DateTime? firstDate,
        bool checkFuture = false}) async {
    var initialDate = selectedDate ?? DateTime.now();
    var fDate = firstDate ?? DateTime(1920);
    var lDate = lastDate ?? DateTime.now().add(const Duration(days: 365 * 20));
    DateTime? date = await showDatePicker(
        context: Get.context!,
        initialDate: initialDate,
        firstDate: fDate,
        lastDate: lDate,
        builder: (context, child) {
          return Theme(
            data: ThemeData().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xffa9a9a9),
                onPrimary: ThemeColor.black,
                surface: Colors.white,
                onSurface: ThemeColor.black,
              ),
              dialogBackgroundColor: const Color.fromARGB(255, 240, 239, 239),
            ),
            child: child!,
          );
        });
    return date;
  }

  static Future<DateTime?> picktime({
    DateTime? selectedDate,
    bool checkFuture = false,
  }) async {
    var dateTime = selectedDate ?? DateTime.now();
    var time = TimeOfDay.fromDateTime(dateTime);
    TimeOfDay? date = await showTimePicker(
        context: Get.context!,
        initialTime: time,
        builder: (context, child) {
          return Theme(
            data: ThemeData().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xffa9a9a9),
                onPrimary: ThemeColor.black,
                surface: Colors.white,
                onSurface: ThemeColor.black,
              ),
              dialogBackgroundColor: const Color.fromARGB(255, 240, 239, 239),
            ),
            child: child!,
          );
        });

    if (date != null) {
      var d = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        date.hour,
        date.minute,
      );
      if (d.isAfter(DateTime.now()) && checkFuture) {
        AppUtils.showSnackBar("Time cannot be from future");
        return null;
      }
      return d;
    }
    return null;
  }

  static Future<File?> pickImage(
      {ImageSource source = ImageSource.gallery}) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      return File(file.path);
    }
    return null;
  }

  static Future<List<XFile>> pickMultiImage(
      {ImageSource source = ImageSource.gallery}) async {
    var file = await ImagePicker().pickMultiImage();

    return file;
  }

  static Future<List<File>> pickDocuments() async {
    var file = await FilePicker.platform.pickFiles(
      allowedExtensions: ["doc", "pdf"],
      allowMultiple: true,
      type: FileType.custom,
    );
    if (file != null && file.files != null && file.files.isNotEmpty) {
      return file.files.map((e) => File(e.path!)).toList();
    }

    return [];
  }

  static Future<List<File>> pickOnlyDocuments() async {
    var file = await FilePicker.platform.pickFiles(
      allowedExtensions: ["doc", "pdf"],
      allowMultiple: true,
      type: FileType.custom,
    );
    if (file != null) {
      return file.files
          .where((element) =>
      element.extension.toString() == "pdf" ||
          element.extension.toString() == "doc")
          .toList()
          .map((e) => File(e.path!))
          .toList();
    }

    return [];
  }

  static Future<bool> showConfrimationDilaog(
      String confirmMsg, {
        String negativeBtntxt = "No",
        String posativeBtnTxt = "Yes",
      }) async {
    var result = await Get.dialog(
      AlertDialog(
        title: TextView(
          Constants.appName,
          fontsize: 16,
          fontweight: FontWeight.w600,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(confirmMsg),
          ],
        ),
        actions: [
          AppElevatedButton(
            title: posativeBtnTxt,
            titleTextSize: 12,
            onPressed: () {
              Get.back(result: true);
            },
          ),
          AppElevatedButton(
            title: negativeBtntxt,
            titleTextSize: 12,
            titleTextColor: ThemeColor.itemCardTxtColor,
            backgroundColor: Colors.white,
            onPressed: () {
              Get.back(result: false);
            },
          ),
        ],
      ),
    );
    if (result != null && result is bool) {
      return result;
    }
    return false;
  }

  static Future<bool> showMessageDialog(
      String msg, {
        String posativeBtnTxt = "",
      }) async {
    var result = await Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          title: TextView(
            Constants.appName,
            fontweight: FontWeight.w600,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextView(msg),
            ],
          ),
          actions: [
            AppElevatedButton(
              title: posativeBtnTxt,
              titleTextSize: 12,
              onPressed: () {
                Get.back();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
    if (result != null && result is bool) {
      return result;
    }
    return false;
  }

  static showSnackBar(String? message, {bool error = false, String? title}) {
    Get.snackbar(
      title ?? Constants.appName,
      message ?? "",
      backgroundColor: error ? ThemeColor.red : ThemeColor.msgBG,
      isDismissible: true,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );
  }

  static showSnackBarTitle(String? title, String? message,
      {bool error = false}) {
    Get.snackbar(
      title ?? "",
      message ?? "",
      backgroundColor: error ? ThemeColor.red : ThemeColor.msgBG,
      isDismissible: true,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );
  }


  static Future<List<String>> pickFile() async {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ["pdf", "png", "jpeg", "jpg"],
      dialogTitle: "Pick file",
    );
    if (files != null) {
      return files.files.map((e) => e.path!).toList();
    }
    return [];
  }

  static Future<String?> pickExcelFile() async {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ["xls", "xlsx"],
      dialogTitle: "Pick file",
    );
    if (files != null && files.isSinglePick) {
      return files.files.first.path;
    }
    return null;
  }

  static Future<List<File>> pickVideos() async {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
      dialogTitle: "Pick Videos",
    );
    if (files != null) {
      return files.files.map((e) => File(e.path!)).toList();
    }
    return [];
  }

  static Future<List<File>> pickImages() async {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      dialogTitle: "Pick Images",
    );
    if (files != null) {
      return files.files.map((e) => File(e.path!)).toList();
    }
    return [];
  }


  bool status = "a".isEmail;
  static List<String> wingList =
  List.generate(26, (index) => String.fromCharCode(index + 65));

  static String getDayGreetings() {
    var dt = DateTime.now();
    if (dt.hour > 12 && dt.hour < 18) {
      return "Good afternoon";
    }
    if (dt.hour > 18 && dt.hour < 6) {
      return "Good evening";
    }
    return "Good morning";
  }


  static Color getColorFromPriority(String priority) {
    if (priority.toLowerCase() == "medium") {
      return ThemeColor.priorityMediumBg;
    }
    if (priority.toLowerCase() == "high") {
      return ThemeColor.priorityHighBg;
    }
    return ThemeColor.priorityLowBg;
  }

  static int getColorFromHex(String hexColor) {
    if (hexColor.isEmpty) {
      return Colors.black.value;
    }
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  // static Future<bool> checkConnectivity() async {
  //   final connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
