import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:time_up/pages/login_page.dart';
import 'package:time_up/pages/sample_page.dart';
import 'package:time_up/pages/splash_screen.dart';
import 'package:time_up/res/getController.dart';

import 'api/api_controller.dart';

main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GetController _getController = Get.put(GetController());
  getUsers() async {if (GetStorage().read('token') != null) {_getController.changeMeUser(await ApiController().getUserData());}}
  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 3), () {
      if (GetStorage().read('token') != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SamplePage()),
        );
        getUsers();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
