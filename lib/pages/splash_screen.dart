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
  @override
  Widget build(BuildContext context) {
    ApiController().getUserData();
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            SizedBox(height: h * 0.15, child: const Image(image: AssetImage('assets/images/logoss.png')),),
            SizedBox(height: h * 0.015),
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