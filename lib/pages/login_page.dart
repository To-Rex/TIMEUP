import 'dart:async';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
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

  showDialogValidation(BuildContext context,title,description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title,style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.red)),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Center(
            child: Text(description),
          ),
        ),
        actions: [
          Center(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Bekor qilish',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ))),
                ),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Text('Ok',
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                          const HeroIcon(HeroIcons.check, color: Colors.white)
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: h * 0.01),
                Image(image: const AssetImage('assets/images/text.png'), height: h * 0.05),
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
                    ? Container(
                  width: w * 0.9,
                  margin: EdgeInsets.only(top: h * 0.02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                    /*controller: nameController.code.value.isEmpty
                        ? _codeController
                        : _codeController
                      ..text = nameController.code.value,*/
                    controller: _codeController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      if (value.length == 6) {
                        var phone = code + _controller.text;
                        var codes = _codeController.text;
                        ApiController().verifySms(phone, codes).then((value) => {
                          if (value.status == true){
                              _codeController.clear(),
                              if (value.res!.token != ''){
                                  GetStorage().write('token', value.res?.token),
                                  nameController.code.value = '',
                                  _codeController.clear(),
                                ApiController().getUserData().then((value) => {
                                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SamplePage()),),
                                  if (value.status == true){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SamplePage()),),
                                  } else {
                                    Toast.showToast(context, 'Xatolik yuz berdi', Colors.red, Colors.red),
                                  }
                                }),
                              } else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUserData(phoneNumber: code + _controller.text)),),
                                }
                            } else {
                              _codeController.clear(),
                              Toast.showToast(context, 'Kodni noto`g`ri kiritdingiz', Colors.red, Colors.red),
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
                    showCursor: false,
                    maxLength: 6,
                  ),
                )
                    : const SizedBox()),
                SizedBox(height: h * 0.02),
                Obx(() => nameController.sendCode.value
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => nameController.onFinished.value
                            ? Countdown(
                          controller: _controllerTimer,
                          seconds: _secondsRemaining,
                          build: (_, double time) {
                            final formattedTime = formatDuration(Duration(seconds: time.toInt()));
                            return Text('Kodni qayta yuborish: $formattedTime', style: const TextStyle(fontSize: 16),);
                          },
                          interval: const Duration(seconds: 1),
                          onFinished: () {
                            nameController.changeOnFinished();
                          },
                        ) : Row(
                          children: [
                            //Text('Kodni qayta yuborish ', style: TextStyle(fontSize: 16)),
                            Text('Kodni qayta yuborish ', style: TextStyle(fontSize: w * 0.04 > 20 ? 20 : w * 0.04)),
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(7),
                                ),
                              ),
                              onPressed: () {
                                nameController.changeOnFinished();
                                _codeController.clear();
                                Timer(const Duration(seconds: 1), () {
                                  startCountdown();
                                });
                                ApiController().sendSms(code + _controller.text).then((value) => nameController.changeCode(value));
                              },
                              child: const Text('Kod yet kelmadimi?'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ) : Text('Royhatdan o`tish uchun raqamingizni yozing!',
                      style: TextStyle(fontSize: w * 0.04 > 20 ? 20 : w * 0.04),
                      textAlign: TextAlign.center)),
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
                        Toast.showToast(context, 'Telefon raqamni kiriting', Colors.red, Colors.red);
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
                        ApiController().sendSms(code + _controller.text).then((value) => {
                          if (value == '400'){
                            showDialogValidation(context, '!Diqqat', 'Siz ko\'p urunishlar almalga oshirdingiz. Iltimos keynroq urinib ko`ring'),
                            nameController.changeCode('')
                          }else{
                            nameController.changeCode(value)
                          }
                        });
                      } else {
                        if (_codeController.text == nameController.code.value) {
                          var phone = code + _controller.text;
                          ApiController().verifySms(phone, _codeController.text).then((value) => {
                            if (value.status == true){
                                _codeController.clear(),
                                if (value.res!.token != ''){
                                    GetStorage().write('token', value.res?.token),
                                    nameController.code.value = '',
                                    _codeController.clear(),
                                  ApiController().getUserData().then((value) => {
                                    if (value.status == true){
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SamplePage()),),
                                    } else {
                                      Toast.showToast(context, 'Xatolik yuz berdi', Colors.red, Colors.red),
                                    }
                                  }),
                                  } else {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUserData(phoneNumber: code + _controller.text,)),),
                                  }
                              } else {
                                _codeController.clear(),
                                Toast.showToast(context, 'Kodni noto`g`ri kiritdingiz', Colors.red, Colors.red),
                              }
                          });
                          return;
                        } else {
                          _codeController.clear();
                          Toast.showToast(context, 'Kodni noto`g`ri kiritdingiz', Colors.red, Colors.red);
                        }
                      }
                    },
                    child: Obx(() => nameController.sendCode.value
                          ? Text('Tasdiqlash',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                          : Text('Kodni yuborish',
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
          )),
    );
  }
}