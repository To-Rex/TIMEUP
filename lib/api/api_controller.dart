import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:time_up/models/last_send_sms.dart';

import '../models/send_sms.dart';
import '../models/verify_sms.dart';

class ApiController extends GetxController {
  //{{host}}/api/v1/sms/send
  var url = 'http://16.16.182.36:443/api/v1/';
  var smsUrl = 'sms/send';
  //{{host}}/api/v1/sms/last-sent-sms
  var lastSmsUrl = 'sms/last-sent-sms';
  //{{host}}/api/v1/sms/verify
  var verifyUrl = 'sms/verify';

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

  Future<VerifySms> verifySms(String phoneNumber, String code) async {
    var response = await http.post(
      Uri.parse(url + verifyUrl),
      body: {
        "phone_number": phoneNumber,
        "code": code,
      },
    );
    if (response.statusCode == 200) {
      return VerifySms.fromJson(jsonDecode(response.body));
    } else {
      return VerifySms();
    }
  }


}
