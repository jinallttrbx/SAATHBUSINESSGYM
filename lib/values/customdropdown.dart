import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class CustomDropdownButton2 extends StatelessWidget {
  double? width;
  final String hint;
  final String title;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  CustomDropdownButton2({
    this.width,
    required this.hint,
    required this.title,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = const Offset(0, 0),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hint==hint? boldtext(Colors.black, 14, title):boldtext(Colors.black, 14, title),
        Stack(
          children: [
            Container(
              width: Get.width * (width ?? 0.9),
              height: 40,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  horizental(15),
                  Expanded(child: regulartext(Colors.black, 12, hint)),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 1, color: Colors.black))),
                    child: const Icon(Icons.keyboard_arrow_down_rounded),
                  )
                ],
              ),
            ),
            SizedBox(
              width: Get.width * (width ?? 0.9),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  //To avoid long text overflowing.
                  isExpanded: true,
                  hint: const SizedBox.shrink(),
                  items: dropdownItems
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      alignment: valueAlignment,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ))
                      .toList(),
                  onChanged: onChanged,
                  selectedItemBuilder: selectedItemBuilder,
                  buttonStyleData: ButtonStyleData(
                    height: buttonHeight ?? 40,
                    width: buttonWidth ?? 140,
                    padding: buttonPadding ??
                        const EdgeInsets.only(left: 14, right: 14),
                    // decoration: buttonDecoration ??
                    //     BoxDecoration(
                    //       borderRadius: BorderRadius.circular(14),
                    //       border: Border.all(
                    //         color: Colors.black45,
                    //       ),
                    //     ),
                    elevation: buttonElevation,
                  ),
                  iconStyleData: IconStyleData(
                    icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
                    iconSize: iconSize ?? 0,
                    // iconEnabledColor: iconEnabledColor,
                    // iconDisabledColor: iconDisabledColor,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
                    maxHeight: dropdownHeight ?? 200,
                    width: dropdownWidth ?? Get.width * (width ?? 0.9),
                    padding: dropdownPadding,
                    // decoration: dropdownDecoration ??
                    //     BoxDecoration(
                    //       borderRadius: BorderRadius.circular(14),
                    //     ),
                    elevation: dropdownElevation ?? 8,
                    //Null or Offset(0, 0) will open just under the button. You can edit as you want.
                    offset: offset,
                    //Default is false to show menu below button
                    isOverButton: false,
                    scrollbarTheme: ScrollbarThemeData(
                      radius: scrollbarRadius ?? const Radius.circular(40),
                      thickness: scrollbarThickness != null
                          ? MaterialStateProperty.all<double>(
                          scrollbarThickness!)
                          : null,
                      thumbVisibility: scrollbarAlwaysShow != null
                          ? MaterialStateProperty.all<bool>(
                          scrollbarAlwaysShow!)
                          : null,
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    height: itemHeight ?? 40,
                    padding: itemPadding ??
                        const EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
