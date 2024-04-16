import 'package:get/get.dart';
 import 'package:translator/translator.dart';

class TranslationController extends GetxController {
   final translator = GoogleTranslator();
  var lan = 'en'.obs;
  var score = "SCORE".obs;
  var club = "Collective".obs;

  updatelan() async {
 translator.translate(score.value,to:lan.value ).then((res) => score.value=res.toString());
 translator.translate(club.value,to:lan.value ).then((res) => club.value=res.toString());
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updatelan();
  }
}
