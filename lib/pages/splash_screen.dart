import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_up/pages/sample_page.dart';

import '../api/api_controller.dart';
import '../res/getController.dart';
import 'login_page.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final GetController _getController = Get.put(GetController());
  getUsers() async {if (GetStorage().read('token') != null) {_getController.changeMeUser(await ApiController().getUserData());}}

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    Timer(const Duration(seconds: 3), () {
      if (GetStorage().read('token') != null) {
        getUsers();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SamplePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            const Image(image: AssetImage('assets/images/logo.png')),
            SizedBox(height: h * 0.01),
            Image(image: const AssetImage('assets/images/text.png'), height: h * 0.05),
            Expanded(child: Container()),
            const Text('Vaqtingizni tejang!'),
            SizedBox(height: h * 0.06),
          ],
        ),
      ),
    );
  }
}