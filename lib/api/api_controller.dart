import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:time_up/models/last_send_sms.dart';
import 'package:time_up/models/register_model.dart';
import '../models/category.dart';
import '../models/get_region.dart';
import '../models/sub_category.dart';
import '../models/verify_sms.dart';
import '../models/me_user.dart';

class ApiController extends GetxController {
  var url = 'http://16.16.182.36:443/api/v1/';
  //var url = 'https://timeup.jprq.site/api/v1/';

  //var url = 'http://timeup.jprq.live:80/api/v1/';
  //var url = 'https://timeup-production.up.railway.app/api/v1/';
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
  //{{host}}/api/v1/business/get-by-category/11
  var getByCategoryUrl = 'business/get-by-category/';


  Future<String> sendSms(String phoneNumber) async {
    var response = await http.post(
      Uri.parse(url + smsUrl),
      body: jsonEncode({
        "phone_number": phoneNumber.toString(),
      }),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return getLastSms(phoneNumber).then((value) => value.res?.code ?? '');
    } else {
      return '';
    }
  }

  Future<LastSendSms> getLastSms(String phoneNumber) async {
    var response = await http.post(
      Uri.parse(url + lastSmsUrl),
      body: jsonEncode({
        "phone_number": phoneNumber.toString(),
      }),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    return LastSendSms.fromJson(jsonDecode(response.body));
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

  Future<Register> registerUser(String fistName,
      String lastName,
      userName,
      phoneNumber,
      address,
      profilePhoto,) async {
    var request = http.MultipartRequest('POST', Uri.parse(url + registerUrl));
    request.fields.addAll({
      'fist_name': fistName,
      'last_name': lastName,
      'user_name': userName,
      'phone_number': phoneNumber,
      'address': address
    });
    request.files.add(await http.MultipartFile.fromPath('profile_photo', profilePhoto));
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return Register.fromJson(jsonDecode(responseBody));
      } else {
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

  Future<MeUser> getUserData(token) async {
    var response = await http.get(Uri.parse(url + meUrl),
        headers: {
          'Authorization':
          'Bearer $token',
        });
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

  Future<MeUser> editUser(token, name, surName, address, nikName) async {
    var response = await http.put(Uri.parse(url + editMeUrl),
      body: jsonEncode({
        "fist_name": name,
        "last_name": surName,
        "address": address,
        "user_name": nikName,
      }),
      headers: {
        'Authorization': 'Bearer $token',
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
      return GetCategory.fromJson(jsonDecode(response.body));
    } else {
      return GetCategory(res: [], status: false);
    }
  }

  Future<GetSubCategory> getSubCategory(int id) async {
    var response = await http.get(
        Uri.parse(url + subCategoryUrl + id.toString()));
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return GetSubCategory.fromJson(jsonDecode(response.body));
    } else {
      return GetSubCategory(res: [], status: false);
    }
  }

  Future<GetRegion> getRegion() async {
    var response = await http.get(Uri.parse(url + regionUrl));
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return GetRegion.fromJson(jsonDecode(response.body));
    } else {
      return GetRegion(res: [], status: false);
    }
  }

  Future<bool> createBusiness(token, int categoryId, officeAddress, officeName,
      experience, bio, dayOffs) async {
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
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        });
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateBusiness(token,int id, int categoryId, officeAddress, officeName,
      experience, bio, dayOffs) async {
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
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        });
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editUserPhoto(token, photo) async {
    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('PUT', Uri.parse(url + editPhotoUrl));
    request.files.add(await http.MultipartFile.fromPath('profile_photo', photo));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> deleteMe(token) async {
    var response = await http.delete(Uri.parse(url+deleteMeUrl),
        headers: {
          'Authorization':
          'Bearer $token',
        });
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }



}
