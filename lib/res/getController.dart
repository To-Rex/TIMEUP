
import 'package:get/get.dart';


class GetController extends GetxController {
  var fullName = 'Dilshodjon Abdurahmonov'.obs;
  var sendCode = false.obs;
  var onFinished = false.obs;

  void changeFullName(String newFullName) {
    fullName.value = newFullName;
  }

  void sendCodes() {
    sendCode.value = !sendCode.value;
  }

  void finished() {
    onFinished.value = !onFinished.value;
  }

  void changeOnFinished() {
    onFinished.value = !onFinished.value;
  }

}