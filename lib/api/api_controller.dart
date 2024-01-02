import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:time_up/elements/functions.dart';
import 'package:time_up/models/last_send_sms.dart';
import 'package:time_up/models/register_model.dart';
import '../models/booking_business_category_get.dart';
import '../models/booking_business_get.dart';
import '../models/booking_category_get.dart';
import '../models/category.dart';
import '../models/follov_model.dart';
import '../models/followers_model.dart';
import '../models/following_model.dart';
import '../models/get_by_category.dart';
import '../models/get_follow_model.dart';
import '../models/get_follow_post.dart';
import '../models/get_id_post.dart';
import '../models/get_post.dart';
import '../models/get_region.dart';
import '../models/profile_by_id.dart';
import '../models/sub_category.dart';
import '../models/verify_sms.dart';
import '../models/me_user.dart';
import '../res/getController.dart';

class ApiController extends GetxController {
  final GetController _getController = Get.put(GetController());

  //var context;

  //var url = 'http://16.16.182.36:443/api/v1/';
  var url = 'https://timeup.dizinfeksiya.uz/api/v1/';
  var smsUrl = 'sms/send';
  var lastSmsUrl = 'sms/last-sent-sms';
  var verifyUrl = 'sms/verify';
  var registerUrl = 'auth/register';
  var meUrl = 'user/me';
  var editMeUrl = 'user/edit-me';
  var categoryUrl = 'category/get';
  var subCategoryUrl = 'category/get?parent_id=';
  var regionUrl = 'region/get';
  var businessCreateUrl = 'business/create';
  var businessUpdateMeUrl = 'business/update-me';
  var editPhotoUrl = 'user/edit-photo';
  var deleteMeUrl = 'user/delete-me';
  var getByCategoryUrl = 'business/get-by-category/';
  var profileByIdUrl = 'business/profile/';
  var bookingBusinessGetListUrl = 'booking/business/get-list/';
  var bookingListBookingAndBookingCategoryUrl = 'booking/list-booking-and-booking-category/';
  var bookingClientGetListUrl = 'booking/client/get-list?date=';
  var businessFollowUrl = 'business/';
  var businessFollowedListUrl = 'business/followed/list?limit=300&offset=0';
  var bookingClientCreateUrl = 'booking/client/create';
  var businessUnFollowUrl = 'business/';
  var businessUnFollowUrl2 = '/unfollow';
  var postListUrl = 'post/list/';
  var postCreateUrl = 'post/create';
  var postGetUrl = 'post/get/';
  var postDeleteUrl = 'post/delete/';
  var postListFollowedProfilesUrl = 'post/list/followed-profiles';
  var postUpdateUrl = 'post/update/';
  var deleteBookingBusinessUrl = 'booking/business/delete/';
  var deleteBookingClientUrl = 'booking/client/delete/';
  var bookingUpdateUrl = 'booking/update/';
  var bookingCategoryListUrl = 'booking-category/list/';
  var bookingCategoryDeleteUrl = 'booking-category/delete/';
  var bookingCategoryListCreateUrl = 'booking-category/create';
  //{{host}}/api/v1/following/list/following/1
  var followingListFollowingUrl = 'following/list/following/';
  //{{host}}/api/v1/following/list/followers/36
  var followingListFollowersUrl = 'following/list/followers/';

  Future<String> sendSms(String phoneNumber) async {
    print(phoneNumber);
    var response = await http.post(
      Uri.parse(url + smsUrl),
      body: jsonEncode({
        "phone_number": phoneNumber.toString(),
      }),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return getLastSms(phoneNumber).then((value) => value.res?.code ?? '');
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      return '400';
    } else {
      return '';
    }
  }

  Future<LastSendSms> getLastSms(String phoneNumber) async {
    print(phoneNumber);
    var response = await http.post(Uri.parse(url + lastSmsUrl),
        body: jsonEncode({
          "phone_number": phoneNumber.toString(),
        }),
        headers: {"Content-Type": "application/json"}
    );
    print(response.body);
    if (response.statusCode == 200) {
      return LastSendSms.fromJson(jsonDecode(response.body));
    } else {
      return LastSendSms(res: LastSendSmsRes(), status: false);
    }
  }

  Future<VerifySms> verifySms(phoneNumber, code) async {
    var response = await http.post(
      Uri.parse(url + verifyUrl),
      body: jsonEncode({
        "phone_number": phoneNumber.toString(),
        "code": code.toString(),
      }),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    var verifySms = VerifySms.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return verifySms;
    } else {
      return VerifySms(res: Resurse(register: false, token: ''), status: false);
    }
  }

  Future<Register> registerUser(String fistName, String lastName, userName, phoneNumber, address, profilePhoto, birthDate) async {
    print(lastName);
    print(userName);
    print(phoneNumber);
    print(address);
    print(profilePhoto);
    print(birthDate);

    var request = http.MultipartRequest('POST', Uri.parse(url + registerUrl));
    request.fields.addAll({
      'fist_name': fistName,
      'last_name': lastName,
      'user_name': userName,
      'phone_number': phoneNumber,
      'address': address,
      'birth_date': birthDate,
    });
    request.files
        .add(await http.MultipartFile.fromPath('profile_photo', profilePhoto));
    try {
      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      print(response.reasonPhrase);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        return Register.fromJson(jsonDecode(responseBody));
      } else {
        return Register(
            res: Responses(user: User(id: 0, fistName: '', lastName: '', userName: '', phoneNumber: '', address: '', photoUrl: ''), token: ''),
            status: false);
      }
    } catch (e) {
      return Register(
          res: Responses(
              user: User(
                  id: 0,
                  fistName: '',
                  lastName: '',
                  userName: '',
                  phoneNumber: '',
                  address: '',
                  photoUrl: ''),
              token: ''),
          status: false);
    }
  }

  Future<MeUser> getUserData() async {
    print(GetStorage().read('token'));
    var response = await http.get(Uri.parse(url + meUrl), headers: {
      'Authorization': 'Bearer ${GetStorage().read('token')}',
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeMeUser(MeUser.fromJson(jsonDecode(response.body)));
      _getController.changeWidgetOptions();
      return MeUser.fromJson(jsonDecode(response.body));
    } else {
      return MeUser(res: MeRes(fistName: '', lastName: '', userName: '', phoneNumber: '', address: '', photoUrl: '',), status: false);
    }
  }

  Future<MeUser> editUser(name, surName, nikName, address) async {
    print(name);
    print(surName);
    print(nikName);
    print(address);
    var response = await http.put(
      Uri.parse(url + editMeUrl),
      body: jsonEncode({
        "fist_name": name,
        "last_name": surName,
        "address": address,
        "user_name": nikName,
      }),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
        'Content-Type': 'application/json'
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return MeUser.fromJson(jsonDecode(response.body));
    } else {
      return MeUser(
          res: MeRes(
            fistName: '',
            lastName: '',
            userName: '',
            phoneNumber: '',
            address: '',
            photoUrl: '',
          ),
          status: false);
    }
  }

  Future<GetCategory> getCategory() async {
    var response = await http.get(Uri.parse(url + categoryUrl));
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeCategory(GetCategory.fromJson(jsonDecode(response.body)));
      _getController.changeCategoryID(_getController.category.value.res![0].id!);
      return GetCategory.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeCategory(GetCategory(res: [], status: false));
      return GetCategory(res: [], status: false);
    }
  }

  Future<GetSubCategory> getSubCategory(id) async {
    var response = await http.get(
      Uri.parse(url + subCategoryUrl + id.toString()),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeSubCategory(GetSubCategory.fromJson(jsonDecode(response.body)));
      //getController.subCategoryIndex.value = value.res![0].id!;
      _getController.changeSubCategoryID(_getController.subCategory.value.res![0].id!);
      return GetSubCategory.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeSubCategory(GetSubCategory(res: [], status: false));
      return GetSubCategory(res: [], status: false);
    }
  }

  Future<GetRegion> getRegion() async {
    var response = await http.get(Uri.parse(url + regionUrl));
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeRegion(GetRegion.fromJson(jsonDecode(response.body)));
      return GetRegion.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeRegion(GetRegion(res: [], status: false));
      return GetRegion(res: [], status: false);
    }
  }

  Future<bool> createBusiness(int categoryId, officeAddress, officeName, experience, bio, dayOffs) async {
    var response = await http.post(Uri.parse(url + businessCreateUrl),
        body: jsonEncode({
          "category_id": categoryId,
          "office_address": officeAddress,
          "office_name": officeName,
          "experience": experience,
          "bio": bio,
          "day_offs": dayOffs
        }),
        headers: {
          'Authorization': 'Bearer ${GetStorage().read('token')}',
          'Content-Type': 'application/json'
        });
    print("business ========= ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateBusiness(int id, int categoryId, officeAddress, officeName, experience, bio, dayOffs) async {
    var response = await http.put(Uri.parse(url + businessUpdateMeUrl),
        body: jsonEncode({
          "id": id,
          "category_id": categoryId,
          "office_address": officeAddress,
          "office_name": officeName,
          "experience": experience,
          "bio": bio,
          "day_offs": dayOffs
        }),
        headers: {
          'Authorization': 'Bearer ${GetStorage().read('token')}',
          'Content-Type': 'application/json'
        });
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editUserPhoto(photo) async {
    var headers = {
      'Authorization': 'Bearer ${GetStorage().read('token')}',
    };
    var request = http.MultipartRequest('PUT', Uri.parse(url + editPhotoUrl));
    request.files
        .add(await http.MultipartFile.fromPath('profile_photo', photo));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteMe() async {
    var response = await http.delete(Uri.parse(url + deleteMeUrl), headers: {
      'Authorization': 'Bearer ${GetStorage().read('token')}',
    });
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<GetByCategory> getByCategory(int id) async {
    var response = await http.get(
        Uri.parse(url + getByCategoryUrl + id.toString()),
        headers: {'Authorization': 'Bearer ${GetStorage().read('token')}'});
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeByCategory(GetByCategory.fromJson(jsonDecode(response.body)));
      return GetByCategory.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeByCategory(GetByCategory(res: [], status: false));
      return GetByCategory(res: [], status: false);
    }
  }

  Future<ProfileById> profileById(int id) async {
    var response = await http.get(
      Uri.parse(url + profileByIdUrl + id.toString()),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //changeProfileById
      _getController.changeProfileById(ProfileById.fromJson(jsonDecode(response.body)));
      return ProfileById.fromJson(jsonDecode(response.body));
    } else {
      _getController
          .changeProfileById(ProfileById(res: ProfileByIdRes(), status: false));
      return ProfileById(res: ProfileByIdRes(), status: false);
    }
  }

  Future<BookingBusinessGetList> bookingBusinessGetList(id, date) async {
    var response = await http.get(
      Uri.parse('$url$bookingBusinessGetListUrl$id?date=$date'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //_getController.bookingBusinessGetList.value = BookingBusinessGetList.fromJson(jsonDecode(response.body));
      _getController.changeBookingBusinessGetList(BookingBusinessGetList.fromJson(jsonDecode(response.body)));
      return BookingBusinessGetList.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeBookingBusinessGetList(BookingBusinessGetList(res: [], status: false));
      return BookingBusinessGetList(res: [], status: false);
    }
  }

  Future<BookingBusinessGetListCategory> bookingListBookingAndBookingCategory(id,date) async {
    var response = await http.get(
      Uri.parse('$url$bookingListBookingAndBookingCategoryUrl$id?date=$date'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeGetBookingBusinessGetListCategory(BookingBusinessGetListCategory.fromJson(jsonDecode(response.body)));
      return BookingBusinessGetListCategory.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeGetBookingBusinessGetListCategory(BookingBusinessGetListCategory(res: Res(), status: false));
      return BookingBusinessGetListCategory(res: Res(), status: false);
    }
  }


  Future<BookingBusinessGetList> bookingClientGetList(date) async {
    var response = await http.get(
      Uri.parse(url + bookingClientGetListUrl + date),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.bookingBusinessGetList1.value = BookingBusinessGetList.fromJson(jsonDecode(response.body));
      _getController.changeBookingBusinessGetList(BookingBusinessGetList.fromJson(jsonDecode(response.body)));
      return BookingBusinessGetList.fromJson(jsonDecode(response.body));
    } else {
      return BookingBusinessGetList(res: [], status: false);
    }
  }

  Future<FollowModel> follow(id) async {
    var response = await http.post(
      Uri.parse('$url$businessFollowUrl$id/follow'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return FollowModel.fromJson(jsonDecode(response.body));
    } else {
      return FollowModel(res: FollowModelRes(), status: false);
    }
  }

  Future<GetFollowModel> getFollowList() async {
    var response = await http.get(
      Uri.parse('$url$businessFollowedListUrl'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return GetFollowModel.fromJson(jsonDecode(response.body));
    } else {
      return GetFollowModel(res: [], status: false);
    }
  }

  Future<bool> createBookingClientCreate(businessId, date, time, categoryId) async {
    var response = await http.post(Uri.parse(url + bookingClientCreateUrl),
        body: jsonEncode({
          "business_id": businessId,
          "booking_category_id": categoryId,
          "date": date,
          "time": time,
        }),
        headers: {
          'Authorization': 'Bearer ${GetStorage().read('token')}',
          'Content-Type': 'application/json'
        });
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> unFollow(id) async {
    var response = await http.delete(
      Uri.parse('$url$businessFollowUrl$id$businessUnFollowUrl2'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<GetMePost> getMePostList(id) async {
    var response = await http.get(
      Uri.parse('$url$postListUrl$id'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeGetPostList(GetMePost.fromJson(jsonDecode(response.body)));
      return GetMePost.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeGetPostList(GetMePost(res: [], status: false));
      return GetMePost(res: [], status: false);
    }
  }

  Future<GetByIdPostModel> getByIdPost(id) async {
    var response = await http.get(
      Uri.parse('$url$postGetUrl$id'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeGetByIdPost(
          GetByIdPostModel.fromJson(jsonDecode(response.body)));
      return GetByIdPostModel.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeGetByIdPost(
          GetByIdPostModel(res: GetByIdPostModelRes(), status: false));
      return GetByIdPostModel(res: GetByIdPostModelRes(), status: false);
    }
  }

  Future<bool> deletePost(id) async {
    var response = await http.delete(
      Uri.parse('$url$postDeleteUrl$id'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      getMePostList(_getController.meUsers.value.res?.business?.id);
      return true;
    } else {
      return false;
    }
  }

  Future<GetFollowPost> getFollowPostList(limit, offset) async {
    var response = await http.get(
      Uri.parse('$url$postListFollowedProfilesUrl?limit=$limit&offset=$offset'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeGetFollowPost(
          GetFollowPost.fromJson(jsonDecode(response.body)));
      return GetFollowPost.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeGetFollowPost(GetFollowPost(res: [], status: false));
      return GetFollowPost(res: [], status: false);
    }
  }

  Future<bool> createPost(String title, String description, businessId, photo, video,context) async {
    _getController.uplAodVideo.value = true;
    var headers = {
      'Authorization': 'Bearer ${GetStorage().read('token')}',
    };
    var request = http.MultipartRequest('POST', Uri.parse(url + postCreateUrl));
    request.fields.addAll({
      'title': title,
      'description': description,
      'business_id': businessId.toString(),
    });
    if (photo != '') {
      request.files.add(await http.MultipartFile.fromPath('photo', photo));
    }
    //request.files.add(await http.MultipartFile.fromPath('photo', _getController.postFile.value));
    if (video != '') {
      request.files.add(await http.MultipartFile.fromPath('video', video));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      _getController.uplAodVideo.value = false;
      Toast.showToast(context, '${jsonResponse['res']['spending_minute'].toString()} daqiqa ichida postizni tasdiqlash kerak', Colors.blue, Colors.white);
      return true;
    } else {
      _getController.uplAodVideo.value = false;
      return false;
    }
  }

  Future<bool> updatePost(id, businessId, String title, String description) async {
    _getController.uplAodVideo.value = true;
    var headers = {
      'Authorization': 'Bearer ${GetStorage().read('token')}',
    };
    var request =
        http.MultipartRequest('PUT', Uri.parse('$url$postUpdateUrl$id'));
    request.fields.addAll({
      'title': title,
      'description': description,
      'business_id': businessId.toString(),
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      _getController.uplAodVideo.value = false;
      return true;
    } else {
      _getController.uplAodVideo.value = false;
      return false;
    }
  }

  Future<bool> deleteBusinessBooking(id,context) async{
    var response = await http.delete(
      Uri.parse('$url$deleteBookingBusinessUrl$id'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Toast.showToast(context, 'Sizning buyurtmangiz o\'chirildi', Colors.blue, Colors.white);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteClientBooking(id,context) async{
    var response = await http.delete(
      Uri.parse('$url$deleteBookingClientUrl$id'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Toast.showToast(context, 'Sizning buyurtmangiz o\'chirildi', Colors.blue, Colors.white);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateBooking(id, date, time,context) async{
    var response = await http.put(
      Uri.parse('$url$bookingUpdateUrl$id'),
      body: jsonEncode({
        "date": date,
        "time": time,
      }),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
        'Content-Type': 'application/json'
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Toast.showToast(context, 'Sizning buyurtmangiz o\'zgartirildi', Colors.blue, Colors.white);
      return true;
    } else {
      Toast.showToast(context, 'Sizning buyurtmangiz o\'zgartirilmadi', Colors.red, Colors.white);
      return false;
    }
  }

  Future<GetBookingCategory> bookingCategoryList(id) async{
    var response = await http.get(
      Uri.parse('$url$bookingCategoryListUrl$id'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeGetBookingCategory(GetBookingCategory.fromJson(jsonDecode(response.body)));
      return GetBookingCategory.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeGetBookingCategory(GetBookingCategory(res: [], status: false));
      return GetBookingCategory(res: [], status: false);
    }
  }

  Future<bool> bookingCategoryListDelete(businessId,id,context) async{
    var response = await http.delete(
      Uri.parse('$url$bookingCategoryDeleteUrl$id'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Toast.showToast(context, 'Sizning buyurtmangiz o\'chirildi', Colors.blue, Colors.white);
      bookingCategoryList(businessId);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> bookingCategoryListCreate(businessId,name,description,duration,price,context) async{
    var response = await http.post(
      Uri.parse('$url$bookingCategoryListCreateUrl'),
      body: jsonEncode({
        "business_id": businessId,
        "name": name,
        "description": description,
        "duration": duration,
        "price": price
      }),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
        'Content-Type': 'application/json'
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Toast.showToast(context, 'Sizning buyurtmangiz qo\'shildi', Colors.blue, Colors.white);
      bookingCategoryList(businessId);
      return true;
    } else {
      return false;
    }
  }

  Future<Following> getMyFollowing(context,id) async{
    print(id);
    var response = await http.get(
      Uri.parse('$url$followingListFollowingUrl$id'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeFollowing(Following.fromJson(jsonDecode(response.body)));
      return Following.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeFollowing(Following(res: [], status: false));
      return Following(res: [], status: false);
    }
  }

  Future<Followers> getMyFollowers(context,businessId) async{
    print(businessId);
    var response = await http.get(
      Uri.parse('$url$followingListFollowersUrl$businessId'),
      headers: {
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeFollowers(Followers.fromJson(jsonDecode(response.body)));
      return Followers.fromJson(jsonDecode(response.body));
    } else {
      _getController.changeFollowers(Followers(res: [], status: false));
      return Followers(res: [], status: false);
    }
  }

}
