
import 'package:flutter/material.dart';
import '../../../../medical_desk.dart';



class TimeSlotWidget extends StatelessWidget {
  TextEditingController startController;
  TextEditingController endController;
  Function(DateTime controller) onStartChange;
  Function(DateTime controller) onEndChange;
  String labelTxt;
  String? hint;
  String? Function(String? value)? onValidate;
  VoidCallback? onClick;
  double? height;
  double? width;
  bool isFilled = true;
  DateTime? firstDate;
  DateTime? lastDate;
  Color? labelColor;
  Color? fillColor;
  bool showRequired = false;
  bool bottomPadding = false;


  TimeSlotWidget ({
    super.key,
    required this.startController,
    required this.endController,
    required this.labelTxt,
    required this.onStartChange,
    required this.onEndChange,
    this.onValidate,
    this.hint,
    this.height,
    this.width,
    this.onClick,
    this.firstDate,
    this.lastDate,
    this.labelColor,
    this.fillColor,
    this.showRequired = false,
    this.isFilled= false,
    this.bottomPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: onClick ??
                      () async {
                    var selectedDate = await AppUtils.picktime();
                    if (selectedDate != null) {
                      onStartChange.call(selectedDate);
                    }
                  },
              child: AbsorbPointer(
                absorbing: true,
                child: EditText(
                  showLabel: false,
                  height: height,
                  width: width,
                  controller: startController,
                  textSize: 12,
                  textAlign: TextAlign.center,
                  labelText: labelTxt,
                  labelColor: labelColor,
                  showRequired: showRequired,
                  hint: hint ?? 'HH:MM',
                  filled: isFilled,
                  showBorder: true,
                  fillColor: fillColor,
                  onValidate: onValidate,

                ),
              ),
            ),
            SizedBox(width: 8,),
            InkWell(
              onTap: onClick ??
                      () async {
                    var selectedDate = await AppUtils.picktime();
                    if (selectedDate != null) {
                      onEndChange.call(selectedDate);
                    }
                  },
              child: AbsorbPointer(
                absorbing: true,
                child: EditText(
                  showLabel: false,
                  height: height,
                  width: width,
                  controller: endController,
                  textSize: 12,
                  labelText: labelTxt,
                  labelColor: labelColor,
                  showRequired: showRequired,
                  hint: hint ?? 'HH:MM',
                  filled: isFilled,
                  textAlign: TextAlign.center,
                  showBorder: true,
                  fillColor: fillColor,
                  onValidate: onValidate,

                ),
              ),
            ),
          ],
        ),
        if(bottomPadding)
      SizedBox(height: 8,),
      ],
    );
  }
}
