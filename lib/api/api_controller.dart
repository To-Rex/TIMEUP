import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../models/send_sms.dart';

class ApiController extends GetxController {
  //{{host}}/api/v1/sms/send
  var url = 'http://16.16.182.36:443/api/v1/';
  var smsUrl = 'sms/send';

  //post {
//     "phone_number": "+998901234567"
// }
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
}
