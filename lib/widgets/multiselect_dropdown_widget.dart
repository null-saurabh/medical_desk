import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../medical_desk.dart';

class MultiSelectAppDropDown<T> extends StatelessWidget {
  T? value;
  String? selectedValue;
  Function(T? value)? onChange;
  List<DropdownMenuItem<T>> items;
  List<T> selectedItems;
  double? width;
  double? height;
  bool? filled;
  Color? fillColor;
  bool showBorder;
  String? hintText;
  String? displaySelectedValues;
  EdgeInsets? contentPadding;
  Color? borderColor;
  Color? labelColor;
  bool showLabel;
  String? labelText;
  bool paddingBottom;
  double? iconSize;
  double? borderRadius;

  Color? iconColor;
  bool showSearch;
  String? Function(T? value)? onValidate;
  bool Function(DropdownMenuItem<T> item, String searchValue)? searchMatchFn;
  TextEditingController? searchCtrl;
  Color? dropDownColor;
  bool showRequired = false;

  // FocusNode? focusNode;
  Function(T? value)? onChangeSelection;
  bool hideError = false;

  MultiSelectAppDropDown({
    Key? key,
    this.value,
    required this.selectedItems,
    this.showLabel = false,
    this.onChange,
    required this.items,
    this.borderColor = ThemeColor.blackDivider,
    this.showBorder = true,
    this.filled = false,
    this.displaySelectedValues = '',
    this.height = 40,
    this.contentPadding,
    this.hintText,
    this.labelText = "",
    this.borderRadius,
    this.hideError = false,
    this.paddingBottom = false,
    this.showRequired = false,
    this.dropDownColor,
    this.width,
    this.iconColor,
    this.iconSize,
    this.showSearch = false,
    this.onValidate,
    // this.focusNode,
    this.searchCtrl,
    this.labelColor,
    this.searchMatchFn,
    this.onChangeSelection,
    this.fillColor = Colors.white,
  }) : super(key: key);
  RxnString showError = RxnString();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel || labelText!.isNotEmpty) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextView(
                labelText ?? '',
                textColor: labelColor ?? ThemeColor.black,
                fontsize: 16,
                fontweight: FontWeight.w500,
              ),
              if(showRequired)
              TextView("*",textColor: ThemeColor.red0000,fontweight: FontWeight.w500,)
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: DropdownButtonFormField2<T>(
              items: items.map((item) {
                return DropdownMenuItem<T>(
                  value: item.value,
                  //disable default onTap to avoid closing menu when selecting an item
                  enabled: false,
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      final isSelected = selectedItems.contains(item.value);
                      return InkWell(
                        onTap: () {
                          onChangeSelection?.call(item.value);
                          menuSetState(() {});
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isSelected)
                              const Icon(Icons.check_box_outlined)
                            else
                              const Icon(Icons.check_box_outline_blank),
                            const SizedBox(width: 16),
                            Expanded(
                              child: item.child,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              autofocus: true,
              selectedItemBuilder: (context) {
                return items.map(
                      (item) {
                    return Text(
                      displaySelectedValues ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ).toList();
              },
              onChanged: onChange ?? (value) {},
              focusNode: focusNode,
              value: value,
              validator: (value) {
                var result = onValidate?.call(value);
                showError.value = result;
                return result;
              },
              onSaved: onChange,
              hint: TextView(
                hintText ?? '',
                fontsize: 12,
                textColor: ThemeColor.edtLabelColor,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                errorStyle: TextStyle(height: 0.1, fontSize: 0),
                errorMaxLines: 2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide.none,
                ),
              ),
              buttonStyleData: ButtonStyleData(
                decoration: BoxDecoration(
                  color: filled! ? fillColor : Colors.white,
                  border: showBorder
                      ? Border.all(
                      color: borderColor ?? ThemeColor.blackDivider,
                      width: .5)
                      : const Border(),
                  borderRadius: BorderRadius.circular(borderRadius ?? 10),
                ),
                height: height,
                width: width,
                padding: contentPadding ??
                    const EdgeInsets.only(
                      right: 5,
                      left: 5,
                    ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                ),
              ),
              dropdownSearchData: showSearch
                  ? DropdownSearchData(
                searchInnerWidget: Container(
                  height: 90,
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: EditText(
                    showBorder: true,
                    height: 45,
                    controller: searchCtrl,
                    // focusNode: focusNode,
                  ),
                ),
                searchController: searchCtrl,
                searchInnerWidgetHeight: 45,
                searchMatchFn: searchMatchFn,
              )
                  : null,
              dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: width,
                  elevation: 1,
                  decoration: BoxDecoration(
                    color: filled! ? fillColor : Colors.white,
                  )),
              isExpanded: true,
            ),
          ),
        ),
        if (!hideError)
          StreamBuilder<String?>(
            stream: showError.stream,
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? Text(
                snapshot.data ?? '',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color.fromARGB(255, 252, 70, 70),
                ),
              )
                  : const SizedBox(
                height: 14,
              );
            },
          ),
        if (showLabel && paddingBottom) ...[
          const SizedBox(
            height: 3,
          ),
        ],
      ],
    );
  }

  InputBorder getBorder() {
    return showBorder
        ? OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? ThemeColor.blackDivider,
      ),
    )
        : InputBorder.none;
  }
}
