import 'dart:convert';
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

  Future<String> sendSms(String phoneNumber) async {
    var response = await http.post(
      Uri.parse(url + smsUrl),
      body: {
        "phone_number": phoneNumber,
      },
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
      body: {
        "phone_number": phoneNumber,
      },
    );
    return LastSendSms.fromJson(jsonDecode(response.body));
  }

  Future<VerifySms> verifySms(phoneNumber, code) async {
    var response = await http.post(
      Uri.parse(url + verifyUrl),
      body: jsonEncode(
          {"phone_number": phoneNumber.toString(), "code": code.toString()}),
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

  Future<Register> registerUser(
    String fistName,
    String lastName,
    userName,
    phoneNumber,
    address,
    profilePhoto,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(url + registerUrl));
    request.fields.addAll({
      'fist_name': fistName,
      'last_name': lastName,
      'user_name': userName,
      'phone_number': phoneNumber,
      'address': address
    });
    request.files
        .add(await http.MultipartFile.fromPath('profile_photo', profilePhoto));
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
  Future<MeUser> editUser(token,name,surName,address,nikName) async{
    var response = await http.put(Uri.parse(url+editMeUrl),
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
    var response = await http.get(Uri.parse(url + subCategoryUrl+id.toString()));
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

  //Bearer token and body {
//     "category_id": 3,
//     "office_address": "office_address...",
//     "office_name": "office_name..",
//     "experience": 3,
//     "bio": "bio...",
//     "day_offs": " Shanba, Yakshanba"
// } Post

}
