import 'package:businessgym/Controller/adresscontroller.dart';
import 'package:businessgym/conts/viewmap.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<addressController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black12),
        child: Row(
          children: [
            const Icon(Icons.place_outlined),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Get.to(() => const ViewMap());
                  },
                  child: boldtext(
                      AppColors.black, 12, controller.address.value.toString())
                  //  Obx(() {
                  //   if (Get.find<SettingsService>().address.value?.isUnknown() ?? true) {
                  //     return Text("Please choose your address".tr, style: Get.textTheme.bodyText1);
                  //   }
                  //   return Text(Get.find<SettingsService>().address.value.address, style: Get.textTheme.bodyText1);
                  // }),
                  ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.gps_fixed),
              onPressed: () async {
                // Get.toNamed(Routes.SETTINGS_ADDRESS_PICKER);
              },
            )
          ],
        ),
      );
    });
  }
}

class ShowAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<addressController>(builder: (controller) {
      return Container(
        height: 50,
          // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10), color: Colors.black12),
          child: Column(
            children: [
              regulartext(
                AppColors.black,
                14,
                controller.address.value.toString(),
              ),
            ],
          ));
    });
  }
}
