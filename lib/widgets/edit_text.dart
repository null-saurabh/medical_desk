// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../medical_desk.dart';

class EditText extends StatelessWidget {
  TextEditingController? controller;
  double? height;
  double? width;
  Widget? prefix;
  Widget? suffix;
  double? suffixSize;
  double? prefixSize;
  FontWeight? textFontWeight;
  double? textSize;
  String? Function(String? value)? onValidate;
  Function(String?)? onSubmit;
  Function(String?)? onChange;
  TextAlign? textAlign;
  String? hint;
  Color? hintColor;
  Color? textColor;
  Color? labelColor;
  Color? fillColor;
  FontWeight? hintFontWeight;
  FontWeight? labelFontWeight;
  TextInputType? inputType;
  double? hintTextSize;
  int? minLine;
  int? maxLength;
  bool? filled;
  bool readOnly;
  EdgeInsets? contentPadding;
  int? maxLine;
  String? labelText = "";
  bool? obscureText;
  bool showBorder = false;
  bool showLabel = false;
  bool showRequired = false;
  double? borderRadius;
  bool showLeading;
  bool enable;
  Color? borderColor;
  String? imagePath;
  bool paddingBottom;

  FocusNode? focusNode;
  Widget? suffixIcon;
  Function()? onTap;
  bool hideError;
  List<TextInputFormatter>? inputformats;

  EditText({
    super.key,
    this.controller,
    this.height,
    this.filled = false,
    this.width,
    this.prefix,
    this.textSize = 12,
    this.suffix,
    this.hideError = false,
    this.maxLength,
    this.borderColor = ThemeColor.hintTextBCBC,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.suffixSize = 24,
    this.prefixSize = 24,
    this.hintFontWeight,
    this.obscureText = false,
    this.textFontWeight,
    this.inputType,
    this.showBorder = true,
    this.labelColor = ThemeColor.black,
    this.textColor = ThemeColor.black,
    this.onTap,
    this.onValidate,
    this.hint,
    this.suffixIcon,
    this.inputformats,
    this.readOnly = false,
    this.paddingBottom = true,
    this.showLeading = false,
    this.labelFontWeight = FontWeight.w500,
    this.labelText = "",
    this.contentPadding,
    // =
    // const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
    this.hintColor = ThemeColor.hintTextBCBC,
    this.fillColor = ThemeColor.textFieldFilledColor,
    this.hintTextSize = 13,
    this.minLine,
    this.maxLine = 1,
    this.imagePath,
    this.borderRadius = 10,
    this.showLabel = false,
    this.showRequired = false,
    this.onChange,
    this.onSubmit,
    this.enable = true,
  }) {
    // if (prefix != null) {
    //   contentPadding ??= const EdgeInsets.only(top: 10, left: 10, right: 10);
    // }
  }

  RxnString showError = RxnString();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLabel) ...[
            Row(
              children: [
                TextView(
                  labelText ?? '',
                  textColor: labelColor,
                  fontweight: labelFontWeight,
                ),
                if (showRequired)
                TextView("*",textColor: ThemeColor.red0000,fontweight: FontWeight.w500,)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
          TextFormField(
             // focusNode: focusNode,
            validator: (value) {
              var result = onValidate?.call(value);
              showError.value = result;
              return showError.value;
            },
            readOnly: readOnly,
            onTap: onTap,
            enabled: enable,
            controller: controller,
            textAlign: textAlign!,
            style: TextStyle(
              fontWeight: textFontWeight,
              color: textColor,
              fontSize: textSize,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            keyboardType: inputType ?? TextInputType.name,
      
            maxLength: maxLength,
            minLines: minLine,
      
            maxLines: maxLine,
            onFieldSubmitted: onSubmit,
            onChanged: onChange,
            obscureText: obscureText!,
            focusNode: focusNode,
      
            decoration: InputDecoration(
              isDense: true,
              counterText: "",
              hintText: hint ?? '',
              filled: filled,
              fillColor:fillColor,
              errorStyle: const TextStyle(height: 0.1, fontSize: 0),
              errorMaxLines: 2,
              hintStyle: TextStyle(
                  color: hintColor,
                  fontSize: hintTextSize,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: hintFontWeight),
              suffixIcon: suffix,
              prefixIcon: prefix,
              contentPadding: contentPadding,
              suffixIconConstraints:
              BoxConstraints(maxWidth: suffixSize!, maxHeight: suffixSize!),
              prefixIconConstraints: BoxConstraints(
                  maxWidth: prefixSize!,
                  maxHeight: prefixSize!,
                  minHeight: prefixSize!,
                  minWidth: prefixSize!),
              border: showBorder
                  ? borderColor != null
                  ? border
                  : Get.theme.inputDecorationTheme.border
                  : InputBorder.none,
              enabledBorder: showBorder
                  ? borderColor != null
                  ? border
                  : Get.theme.inputDecorationTheme.enabledBorder
                  : InputBorder.none,
              errorBorder: showBorder
                  ? borderColor != null
                  ? border
                  : Get.theme.inputDecorationTheme.errorBorder
                  : InputBorder.none,
              focusedBorder: showBorder
                  ? borderColor != null
                  ? border
                  : Get.theme.inputDecorationTheme.focusedBorder
                  : InputBorder.none,
              disabledBorder: showBorder
                  ? borderColor != null
                  ? border
                  : Get.theme.inputDecorationTheme.disabledBorder
                  : InputBorder.none,
              focusedErrorBorder: showBorder
                  ? borderColor != null
                  ? border
                  : Get.theme.inputDecorationTheme.focusedErrorBorder
                  : InputBorder.none,
            ),
            inputFormatters: inputformats,
          ),
          if (!hideError) ...[
            StreamBuilder<String?>(
              stream: showError.stream,
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? Text(
                  snapshot.data ?? '',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(255, 211, 63, 63),
                  ),
                )
                    : const SizedBox(
                  height: 0,
                );
              },
            ),
          ],
          if (showLabel && paddingBottom) ...[
            const SizedBox(
              height: 5,
            ),
          ],
        ],
      ),
    );
  }

  OutlineInputBorder get border => OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      borderRadius ?? 10,
    ),
    borderSide: BorderSide(
      color: ThemeColor.blackDivider,
      width: .5,
    ),
  );
}
