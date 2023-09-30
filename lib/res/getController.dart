
import 'package:get/get.dart';


class GetController extends GetxController {
  var fullName = 'Dilshodjon Abdurahmonov'.obs;
  var sendCode = false.obs;
  var onFinished = false.obs;
  var enters = 0.obs;
  var index = 0.obs;
  var code = ''.obs;
  var image = ''.obs;

  //bottombar index
  void changeIndex(int newIndex) {
    index.value = newIndex;
  }

  void changeFullName(String newFullName) {
    fullName.value = newFullName;
  }

  void sendCodes() {
    sendCode.value = !sendCode.value;
  }

  void changeOnFinished() {
    onFinished.value = !onFinished.value;
  }

  void changeFinish() {
    onFinished.value = false;
  }

  changeCode(String newCode) {
    code.value = newCode;
  }

  changeImage(String newImage) {
    image.value = newImage;
  }

}