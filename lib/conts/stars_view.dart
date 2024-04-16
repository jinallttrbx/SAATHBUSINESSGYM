import 'package:businessgym/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarsView extends StatelessWidget {
  int total;
  VoidCallback ontap;
  int? colored;
  StarsView(
      {super.key, required this.total, required this.ontap, this.colored});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          itemCount: total,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SvgPicture.asset(
              AppImages.rating,
              color: (colored ?? 0) > index ? Colors.orange : Colors.grey,
              height: 20,
            );
          },
        ),
      ),
    );
  }
}
