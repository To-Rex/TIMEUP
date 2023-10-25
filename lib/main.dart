import 'dart:async';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:time_up/pages/login_page.dart';
import 'package:time_up/pages/sample_page.dart';
import 'package:time_up/pages/splash_screen.dart';

main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
