import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:time_up/models/last_send_sms.dart';
import 'package:time_up/models/register_model.dart';
import '../models/verify_sms.dart';
import '../models/me_user.dart';

class ApiController extends GetxController {
  //{{host}}/api/v1/sms/send
  var url = 'http://16.16.182.36:443/api/v1/';

  //var url = 'http://timeup.jprq.live:80/api/v1/';
  //var url = 'https://timeup-production.up.railway.app/api/v1/';
  var smsUrl = 'sms/send';

  //{{host}}/api/v1/sms/last-sent-sms
  var lastSmsUrl = 'sms/last-sent-sms';

  //{{host}}/api/v1/sms/verify
  var verifyUrl = 'sms/verify';

  //{{host}}/api/v1/auth/register
  var registerUrl = 'auth/register';

  //{{host}}/api/v1/user/me
  var meUrl = 'user/me';

  //showToast error
  void showToastError(String message) {
    Get.snackbar(
      'Xatolik',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

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

  //get user info
  Future<MeUser> getUserData() async {
    var response = await http.get(Uri(path: url + meUrl), headers: {
      //bearer token
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjEwMzM2MjYxMzE2LCJpYXQiOjE2OTYyNjEzMTYsInN1YiI6IjM5In0.maTMhE_GbdnvmyW-gQuag3N_j6lpnTetP3AEL_EoY-g'
    });
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
}
