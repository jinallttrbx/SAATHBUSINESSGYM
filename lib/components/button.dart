import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../values/Colors.dart';
import '../../values/const_text.dart';

class ButtonMain extends StatefulWidget {
  VoidCallback ontap;
  String text;
  double width;
  bool loader;
  double? height;
  Color? bgcolor;
  bool? noborder;
  Widget? child;
  Color? fcolor;
  double? fsize;

  ButtonMain(
      {super.key,
      required this.ontap,
      required this.text,
      required this.width,
      required this.loader,
      this.height,
      this.bgcolor,
      this.noborder,
      this.child,
      this.fcolor,
      this.fsize});

  @override
  State<ButtonMain> createState() => _ButtonMainState();
}

class _ButtonMainState extends State<ButtonMain> {
  double width = 100;
  double height = 50;
  Color color1 = Colors.green;
  BorderRadiusGeometry borderRadius = BorderRadius.circular(10);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: AnimatedContainer(
        padding: const EdgeInsets.all(10),
        width: widget.loader
            ? 70
            : MediaQuery.of(context).size.width * widget.width,
        height: widget.height ?? height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 14,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: widget.bgcolor ?? AppColors.BGColor,
          borderRadius: borderRadius,
        ),
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        child: widget.loader == true
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: CupertinoActivityIndicator(
                  radius: 20.0,
                  animating: true,
                  color: AppColors.DarkBlue,
                ),
              )
            : widget.child ??
                Center(
                    child: boldtext(widget.fcolor ?? AppColors.DarkBlue,
                        widget.fsize ?? 16, widget.text)),
      ),
    );
  }
}
