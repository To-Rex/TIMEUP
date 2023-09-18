
import 'package:get/get.dart';


class GetController extends GetxController {
  var fullName = 'Dilshodjon Abdurahmonov'.obs;
  var fullNameSize = false.obs;

  void changeFullName(String newFullName) {
    fullName.value = newFullName;
  }

  void changeFullNameSize() {
    if (fullNameSize.value == true) {
      fullName.value = 'Dilshodjon Abdurahmonov';
    } else{
      fullName.value = 'Dilshodjon Haydarov';
    }
    fullNameSize.value = !fullNameSize.value;
  }

}