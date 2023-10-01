import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:time_up/elements/functions.dart';
import 'package:time_up/pages/sample_page.dart';
import 'package:time_up/pages/users_data.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../api/api_controller.dart';
import '../res/getController.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GetController nameController = Get.put(GetController());
  final TextEditingController _controller = TextEditingController();

  final TextEditingController _codeController = TextEditingController();
  var code = '+998';

  final int _secondsRemaining = 120;

  final CountdownController _controllerTimer = CountdownController();

  void startCountdown() {
    _controllerTimer.start();
  }

  String formatDuration(Duration duration) {
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
              color: Colors.grey[200],
            ),
            child: IntlPhoneField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              flagsButtonPadding: const EdgeInsets.only(left: 10, right: 10),
              onChanged: (phone) {
                nameController.changeFinish();
                nameController.sendCode.value = false;
                nameController.code.value = '';
                _codeController.clear();
              },
              decoration: const InputDecoration(
                hintText: 'Telefon raqam',
                hintStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  borderSide: BorderSide.none,
                ),
                counterText: '',
                counter: null,
                semanticCounterText: null,
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
                code = phone.fullCountryCode;
              },
            ),
          ),
          Obx(() => nameController.sendCode.value
              ? SizedBox(
                  height: h * 0.02,
                )
              : const SizedBox()),
          Obx(() => nameController.sendCode.value
              ? Container(
                  width: w * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                    controller: nameController.code.value.isEmpty
                        ? _codeController
                        : _codeController
                      ..text = nameController.code.value,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      if (value.length == 6) {
                        var phone = code + _controller.text;
                        var codes = _codeController.text;
                        ApiController()
                            .verifySms(phone, codes)
                            .then((value) => {
                                  if (value.status == true)
                                    {
                                      _codeController.clear(),
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginUserData()),
                                      ),
                                    }
                                  else
                                    {
                                      _codeController.clear(),
                                      Toast.showToast(
                                          context,
                                          'Kodni noto`g`ri kiritdingiz',
                                          Colors.red,
                                          Colors.red),
                                    }
                                });
                      }
                    },
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
              : const SizedBox()),
          SizedBox(height: h * 0.02),
          Obx(
            () => nameController.sendCode.value
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => nameController.onFinished.value
                            ? Countdown(
                                controller: _controllerTimer,
                                seconds: _secondsRemaining,
                                build: (_, double time) {
                                  final formattedTime = formatDuration(
                                      Duration(seconds: time.toInt()));
                                  return Text(
                                    'Kodni qayta yuborish: $formattedTime',
                                    style: const TextStyle(fontSize: 16),
                                  );
                                },
                                interval: const Duration(seconds: 1),
                                onFinished: () {
                                  nameController.changeOnFinished();
                                },
                              )
                            : Row(
                                children: [
                                  const Text('Kodni qayta yuborish ',
                                      style: TextStyle(fontSize: 16)),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    onPressed: () {
                                      nameController.changeOnFinished();
                                      _codeController.clear();
                                      Timer(const Duration(seconds: 1), () {
                                        startCountdown();
                                      });
                                      ApiController()
                                          .sendSms(code + _controller.text)
                                          .then((value) =>
                                              nameController.changeCode(value));
                                    },
                                    child: const Text('Kod yet kelmadimi?'),
                                  ),
                                ],
                              ),
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
                if (_controller.text.isEmpty) {
                  Toast.showToast(context, 'Telefon raqamni kiriting',
                      Colors.red, Colors.red);
                  return;
                }
                if (!nameController.onFinished.value) {
                  nameController.sendCodes();
                  if (nameController.sendCode.value) {
                    nameController.changeOnFinished();
                    Timer(const Duration(seconds: 1), () {
                      _controllerTimer.restart();
                      startCountdown();
                    });
                  }
                  ApiController()
                      .sendSms(code + _controller.text)
                      .then((value) => nameController.changeCode(value));
                } else {
                  if (_codeController.text == nameController.code.value) {
                    var phone = code + _controller.text;
                    var codes = _codeController.text;
                    ApiController().verifySms(phone, codes).then((value) => {
                          if (value.status == true)
                            {
                              _codeController.clear(),
                              print('shuhsushushushsuhsu   ${value.res!.token}'),
                              if (value.res!.token!.isNotEmpty){
                                  Toast.showToast(
                                      context,
                                      '${value.res?.token}',
                                      Colors.green,
                                      Colors.white),
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SamplePage()),
                                  ),
                                }
                              else
                                {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginUserData()),
                                  ),
                                }
                            }
                          else
                            {
                              _codeController.clear(),
                              Toast.showToast(
                                  context,
                                  'Kodni noto`g`ri kiritdingiz',
                                  Colors.red,
                                  Colors.red),
                            }
                        });
                    return;
                  } else {
                    _codeController.clear();
                    Toast.showToast(context, 'Kodni noto`g`ri kiritdingiz',
                        Colors.red, Colors.red);
                  }
                }
              },
              child: Obx(
                () => nameController.sendCode.value
                    ? Text(
                        'Tasdiqlash',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        'Kodni yuborish',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
