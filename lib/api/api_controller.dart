import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_up/models/last_send_sms.dart';

import '../models/send_sms.dart';
import '../models/verify_sms.dart';

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
      return VerifySms(res: Resurs(register: false, token: ''), status: false);
    }
  }

  //var request = http.MultipartRequest('POST', Uri.parse('16.16.182.36:443/api/v1/auth/register'));
// request.fields.addAll({
//   'fist_name': 'Shaxzod',
//   'last_name': 'Abdullayev',
//   'user_name': 'username',
//   'phone_number': '+988901234567',
//   'address': 'Toshkent'
// });
// request.files.add(await http.MultipartFile.fromPath('profile_photo', '/home/abdullayev65/Downloads/go-smr.png'));
//
// http.StreamedResponse response = await request.send();
//
// if (response.statusCode == 200) {
//   print(await response.stream.bytesToString());
// }
// else {
//   print(response.reasonPhrase);
// }

  Future<void> registerUser(
      fist_name,
      last_name,
      user_name,
      phone_number,
      address,
      profile_photo,
      ) async {
    print(fist_name+'\n'+last_name+'\n'+user_name+'\n'+phone_number+'\n'+address+'\n'+profile_photo);
    var request = http.MultipartRequest('POST', Uri.parse(url + registerUrl));
    request.fields.addAll({
      'fist_name': 'Hoshimjon',
      'last_name': 'Abdullayev',
      'user_name': 'kajdadskjhajksdhkja',
      'phone_number': '+998999999999',
      'address': address
    });
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
    });
    request.files.add(await http.MultipartFile.fromPath('profile_photo', profile_photo));
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
