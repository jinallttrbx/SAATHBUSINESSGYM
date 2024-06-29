import 'package:businessgym/values/assets.dart';
import 'package:flutter/material.dart';


class Loader extends StatelessWidget {
  const Loader(
      {Key? key,
      this.opacity = 0.65,
      this.isCustom = false,
      this.dismissibles = false,
      this.color = Colors.transparent,
      this.loadingTxt = 'Loading...'})
      : super(key: key);

  final bool isCustom;
  final double opacity;
  final bool dismissibles;
  final Color color;
  final String loadingTxt;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: const ModalBarrier(dismissible: false, color: Colors.black),
        ),
        // Container(
        //   child: isCustom
        //       ? SpinKitSquareCircle(
        //     color: TempDataClass.appPrimaryColor,
        //     size: 50.0,
        //   )
        //       : SpinKitSquareCircle(
        //     color: TempDataClass.appPrimaryColor,
        //     size: 50.0,
        //   )
        // ),
        Container(
            child: isCustom
                ? Center(
                    child: Image.asset(
                      AppImages.APP_LOGO,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                  )
                : Center(
                    child: Image.asset(
                      AppImages.APP_LOGO,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                  )),
      ],
    );
  }
}
