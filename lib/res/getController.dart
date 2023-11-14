import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_up/bottomBarPages/home.dart';
import 'package:time_up/models/category.dart';
import 'package:time_up/models/get_follow_model.dart';
import 'package:time_up/models/me_user.dart';
import '../bottomBarPages/add_post.dart';
import '../bottomBarPages/history.dart';
import '../bottomBarPages/profile.dart';
import '../bottomBarPages/search.dart';
import '../models/booking_business_get.dart';
import '../models/get_by_category.dart';
import '../models/get_region.dart';
import '../models/profile_by_id.dart';
import '../models/sub_category.dart';

class GetController extends GetxController {
  var fullName = 'Dilshodjon Haydarov'.obs;
  var sendCode = false.obs;
  var onFinished = false.obs;
  var enters = 0.obs;
  var entersUser = 0.obs;
  var index = 0.obs;
  var code = ''.obs;
  var image = ''.obs;
  var nextPages = 0.obs;
  var nextPagesUserDetails = 0.obs;
  var widgetOptions = <Widget>[];
  var postFile = ''.obs;

  void changePostFile(String newPostFile) {
    postFile.value = newPostFile;
  }

  void changeWidgetOptions() {
    if (meUsers.value.res?.business == null) {
      widgetOptions.clear();
      widgetOptions.add(HomePage());
      widgetOptions.add(SearchPage());
      widgetOptions.add(HistoryPage());
      widgetOptions.add(ProfilePage());
    } else {
      widgetOptions.clear();
      widgetOptions.add(HomePage());
      widgetOptions.add(SearchPage());
      widgetOptions.add(AddPostPage());
      widgetOptions.add(HistoryPage());
      widgetOptions.add(ProfilePage());
    }
  }

  //var users = ApiController().getUserData();
  var meUsers = MeUser().obs;
  var category = GetCategory().obs;
  var subCategory = GetSubCategory().obs;
  var getRegion = GetRegion().obs;
  var getByCategory = GetByCategory().obs;
  var getProfileById = ProfileById().obs;
  var bookingBusinessGetList = BookingBusinessGetList().obs;
  var bookingBusinessGetList1 = BookingBusinessGetList().obs;
  var followList = GetFollowModel().obs;
  var categoryIndex = 0.obs;
  var subCategoryIndex = 0.obs;
  var regionIndex = 0.obs;
  var categoryByID = 0.obs;
  var profileByID = 0.obs;
  var bookingBusinessGetListByID = 0.obs;
  var titleListElements = ''.obs;

  void changeTitleListElements(String newTitleListElements) {
    titleListElements.value = newTitleListElements;
  }

  void changeCategoryID(int newCategoryID) {
    categoryIndex.value = newCategoryID;
  }

  void changeSubCategoryID(int newSubCategoryID) {
    subCategoryIndex.value = newSubCategoryID;
  }

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

  void changeSubCategory(GetSubCategory newSubCategory) {
    subCategory.value = newSubCategory;
  }

  void changeByCategory(GetByCategory newGetByCategory) {
    getByCategory.value = newGetByCategory;
  }

  void changeBookingBusinessGetList(BookingBusinessGetList newBookingBusinessGetList) {
    bookingBusinessGetList.value = newBookingBusinessGetList;
  }
  void changeBookingBusinessGetList1(BookingBusinessGetList newBookingBusinessGetList) {
    bookingBusinessGetList1.value = newBookingBusinessGetList;
  }

  void changeFollowList(GetFollowModel newFollowList) {
    followList.value = newFollowList;
  }

  void clearFollowList() {
    followList.value = GetFollowModel();
  }

  //clear data GetByCategory
  void clearByCategory() {
    getByCategory.value = GetByCategory();
  }

  void clearBookingBusinessGetList() {
    bookingBusinessGetList.value = BookingBusinessGetList();
  }
  void clearBookingBusinessGetList1() {
    bookingBusinessGetList1.value = BookingBusinessGetList();
  }

  void clearMeUser() {
    meUsers.value = MeUser();
  }

  void changeProfileById(ProfileById newProfileById) {
    getProfileById.value = newProfileById;
  }

  void clearProfileById() {
    getProfileById.value = ProfileById();
  }

  void clearCategory() {
    category.value = GetCategory();
  }

  void clearSubCategory() {
    subCategory.value = GetSubCategory();
  }

  void changeRegion(GetRegion newRegion) {
    getRegion.value = newRegion;
  }

  void clearRegion() {
    getRegion.value = GetRegion();
  }

  void changeRegionIndex(int newRegionIndex) {
    regionIndex.value = newRegionIndex;
  }


}