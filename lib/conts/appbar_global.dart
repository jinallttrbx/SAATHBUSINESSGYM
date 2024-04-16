import 'package:businessgym/values/Colors.dart';
import 'package:flutter/material.dart';
import '../../values/const_text.dart';

class APPBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool? back;
  double? elevation;

  APPBar({super.key, required this.title, this.back, this.elevation});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ?? 0,
      automaticallyImplyLeading: false,
      leading: back == false
          ? const SizedBox.shrink()
          : IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed:
                  back == false ? () {} : () => Navigator.of(context).pop(),
            ),
      backgroundColor: Colors.white,
      title: boldtext(AppColors.black, 16, title),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
