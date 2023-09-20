
import 'package:get/get.dart';


class GetController extends GetxController {
  var fullName = 'Dilshodjon Abdurahmonov'.obs;
  var sendCode = false.obs;

  void changeFullName(String newFullName) {
    fullName.value = newFullName;
  }

  void sendCodes() {
    if (sendCode.value == true) {
      fullName.value = 'Dilshodjon Abdurahmonov';
    } else{
      fullName.value = 'Dilshodjon Haydarov';
    }
    sendCode.value = !sendCode.value;
  }

}