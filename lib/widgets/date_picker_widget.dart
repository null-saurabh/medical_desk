
import 'package:flutter/material.dart';
import '../medical_desk.dart';

class DatePicker extends StatelessWidget {
  TextEditingController controller;
  Function(DateTime controller) onDateChange;
  String labelTxt;
  String? hint;
  String? Function(String? value)? onValidate;
  VoidCallback? onClick;
  double? height;
  bool fillColor = true;
  DateTime? firstDate;
  DateTime? lastDate;
  Color? labelColor;
  bool showRequired = false;

  DatePicker({
    super.key,
    required this.controller,
    required this.labelTxt,
    required this.onDateChange,
    this.onValidate,
    this.hint,
    this.height = 40,
    this.onClick,
    this.firstDate,
    this.lastDate,
    this.labelColor,
    this.showRequired = false,
    this.fillColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick ??
              () async {
            var date = controller.text.yymmddtoDate();
            if (lastDate != null && lastDate!.isBefore(date)) {
              date = lastDate!;
            }

            var selectedDate = await AppUtils.pickDate(
              selectedDate: date,
              firstDate: firstDate,
              lastDate: lastDate,
            );
            if (selectedDate != null) {
              onDateChange.call(selectedDate);
            }
          },
      child: AbsorbPointer(
        absorbing: true,
        child: EditText(
          showLabel: labelTxt.isNotEmpty,
          height: height,
          controller: controller,
          textSize: 12,
          labelText: labelTxt,
          labelColor: labelColor,
          showRequired: showRequired,
          hint: hint ?? 'dd-mm-yyyy',
          filled: fillColor,
          showBorder: true,
          fillColor: ThemeColor.textFieldFilledColor,
          onValidate: onValidate,
          // borderColor:
          suffix: Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: IconImage(
              imagePath: AppAssets.pick_date_icon,
              color: ThemeColor.redBgColor,
            ),
          ),
        ),
      ),
    );
  }
}
