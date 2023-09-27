import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../models/send_sms.dart';

class ApiController extends GetxController {
  //{{host}}/api/v1/sms/send
  var url = 'http://16.16.182.36:443/api/v1/';
  var smsUrl = 'sms/send';
  //{{host}}/api/v1/sms/last-sent-sms
  var lastSmsUrl = 'sms/last-sent-sms';

  Future<int> sendSms(String phoneNumber) async {
    var response = await http.post(
      Uri.parse(url + smsUrl),
      body: {
        "phone_number": phoneNumber,
      },
    );
    print(response.body);
    return 100;
  }

  Future<SendSms> getLastSms() async {
    var response = await http.get(
      Uri.parse(url + lastSmsUrl),
    );
    print(response.body);
    return sendSmsFromJson(response.body);
  }


}
