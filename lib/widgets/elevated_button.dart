// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../medical_desk.dart';

import 'text_view.dart';

class AppElevatedButton extends StatelessWidget {
  Widget? child;
  String? title;
  VoidCallback? onPressed;
  Color? backgroundColor;
  Color? titleTextColor;
  Color? borderColor;
  double? width;
  double? height;
  double? titleTextSize;
  double? borderWidth;
  double? borderRadius;
  double? elevation;
  EdgeInsets? contentPadding;
  Alignment childAlign;
  bool? showBorder;
  FontWeight? titleFontWeight;


  AppElevatedButton({
    super.key,
    this.child,
    this.title,
    this.onPressed,
    this.backgroundColor,
    this.titleTextColor = ThemeColor.white,
    this.showBorder = false,
    this.borderColor = ThemeColor.darkBlue4392,
    this.width,
    this.height,
    this.childAlign = Alignment.center,
    this.titleTextSize = 16,
    this.borderWidth = 1,
    this.borderRadius = 10,
    this.elevation = 0,
    this.contentPadding,
    this.titleFontWeight = FontWeight.w600,
  }) {
    width ??= double.infinity;
    height ??= 48;
    backgroundColor ??=  ThemeColor.primaryBlue90ff;
    // borderColor ??= ThemeColor.darkBlue4392;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed != null
            ? () {
          if (Get.isSnackbarOpen) {
            Get.back();
          }
          onPressed?.call();
        }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          alignment: childAlign,
          disabledBackgroundColor: ThemeColor.disableColor,
          elevation: elevation,
          padding: contentPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            side: showBorder!
                ? BorderSide(color: borderColor!, width: borderWidth!)
                : BorderSide.none,
          ),
        ),
        child: child ??
            TextView(
              title ?? '',
              textColor: titleTextColor,
              fontsize: titleTextSize,
              fontweight: titleFontWeight,
              maxLine: 1,
              textAlign: TextAlign.center,
            ),
      ),
    );
  }
}
