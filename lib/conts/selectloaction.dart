// ignore_for_file: must_be_immutable

import 'package:businessgym/conts/to_map_scree.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomSelectMapfrom extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<LatLng>? onLocationChange;
  final Color? fieldColor;
  CustomSelectMapfrom({
    Key? key,
    required this.controller,
    this.fieldColor,
    this.onLocationChange,
  }) : super(key: key);

  @override
  State<CustomSelectMapfrom> createState() => _CustomSelectfromMapState();
}

class _CustomSelectfromMapState extends State<CustomSelectMapfrom> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var value = await Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => ToMapScreen(),
          ),
        )
            .then((value) {
          if (value != null) {
            if (value is List) {
              setState(() {
                widget.controller.text = value[1];
                widget.onLocationChange!(value[0]);
              });
              print("Print Selected Location ${value[0]}");
            }
          }
        });
      },
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: widget.fieldColor ?? AppColors.lightblue,
          borderRadius: BorderRadius.circular(12),
        ),
        height: 50,
        margin: const EdgeInsets.only(left: 0, right: 0),
        child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
                SvgPicture.asset(AppImages.map),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    widget.controller.text.isEmpty
                        ? "Select Location"
                        : widget.controller.text,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.55),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                    maxLines: 5,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
