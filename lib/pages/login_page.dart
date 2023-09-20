import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../res/getController.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GetController nameController = Get.put(GetController());
  final TextEditingController _controller = TextEditingController();
  var code = '+998';

  final int _otpLength = 6; // Adjust this based on your OTP length
  String _otp = '';
  final int _secondsRemaining = 120;

  final CountdownController _controllerTimer = CountdownController();

  void startCountdown() {
    _controllerTimer.start();
  }

  String formatDuration(Duration duration) {
    print(duration.inSeconds);
    return '${(duration.inSeconds ~/ 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/images/logo.png')),
          SizedBox(height: h * 0.01),
          Image(
              image: const AssetImage('assets/images/text.png'),
              height: h * 0.05),
          SizedBox(height: h * 0.06),
          Container(
            width: w * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.grey[300],
            ),
            child: IntlPhoneField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              flagsButtonPadding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const InputDecoration(
                hintText: 'Telefon raqam',
                hintStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  borderSide: BorderSide.none,
                ),
                counterText: '',
                counter: null,
                //counter false
                semanticCounterText: null,
                //counter false
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                error: null,
                errorText: null,
                isDense: true,
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
              ),
              showCountryFlag: false,
              showCursor: false,
              showDropdownIcon: false,
              initialCountryCode: 'UZ',
              onCountryChanged: (phone) {
                print('Country code changed to: ' + phone.fullCountryCode);
                code = phone.fullCountryCode;
              },
            ),
          ),
          Obx(() => nameController.sendCode.value
              ? SizedBox(
                  height: h * 0.02,
                )
              : SizedBox()),
          Obx(() => nameController.sendCode.value
              ? Container(
                  width: w * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey[300],
                  ),
                  child: TextField(
                    //controller: nameController.codeController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: 'Kodni kiriting',
                      hintStyle: TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide.none,
                      ),
                      counterText: '',
                      counter: null,
                      //counter false
                      semanticCounterText: null,
                      //counter false
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      error: null,
                      errorText: null,
                      isDense: true,
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
                    ),
                    showCursor: false,
                    maxLength: 6,
                  ),
                )
              : SizedBox()),
          SizedBox(height: h * 0.02),
          Obx(
            () => nameController.sendCode.value
                ? Row(
                    children: [
                      Countdown(
                        controller: _controllerTimer,
                        seconds: _secondsRemaining,
                        build: (_, double time) {
                          final formattedTime =
                              formatDuration(Duration(seconds: time.toInt()));
                          return Text(
                            'Kodni qayta yuborish: $formattedTime',
                            style: TextStyle(fontSize: 16),
                          );
                        },
                        interval: Duration(seconds: 1),
                        onFinished: () {
                          // Handle the timer finish event here
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        onPressed: () {
                          _controllerTimer.restart();
                        },
                        child: Text('Kod yet kelmadimi?'),
                      ),
                    ],
                  )
                : Text('Royhatdan o`tish uchun raqamingizni yozing!',
                    style: TextStyle(fontSize: w * 0.04 > 20 ? 20 : w * 0.04),
                    textAlign: TextAlign.center),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            height: h * 0.06,
            width: w * 0.9,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              onPressed: () {
                nameController.changeFullName(_controller.text);
                nameController.sendCodes();
                //1 cek time out start conunt down
                Timer(Duration(seconds: 1), () {
                  startCountdown();
                });
              },
              child: Text(
                'Yuborish',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
                  //bold
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
