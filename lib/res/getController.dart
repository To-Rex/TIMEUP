import 'package:get/get.dart';
import 'package:time_up/models/category.dart';
import 'package:time_up/models/me_user.dart';

class GetController extends GetxController {
  var fullName = 'Dilshodjon Haydarov'.obs;
  var sendCode = false.obs;
  var onFinished = false.obs;
  var enters = 0.obs;
  var entersUser = 0.obs;
  var index = 0.obs;
  var code = ''.obs;
  var image = ''.obs;

  //var users = ApiController().getUserData();
  var meUsers = MeUser().obs;
  var category = GetCategory().obs;
  var subCategory = GetCategory().obs;

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

  void changeMeUser(MeUser newMeUser) {
    meUsers.value = newMeUser;
  }

  void changeCategory(GetCategory newCategory) {
    category.value = newCategory;
  }

  void changeSubCategory(GetCategory newSubCategory) {
    subCategory.value = newSubCategory;
  }

  void clearMeUser() {
    meUsers.value = MeUser();
  }

  void clearCategory() {
    category.value = GetCategory();
  }

  void clearSubCategory() {
    subCategory.value = GetCategory();
  }

}