import 'dart:async';
import 'package:flutter/services.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GetController _getController = Get.put(GetController());
  final box = GetStorage();
  String? token = '';
  getToken() async {
    token = box.read('token');
    print(token);
    return token;
  }

  @override
  void initState() {
    getToken();
    Timer(const Duration(seconds: 3), () async {
      if (token != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SamplePage()),);
      } else {
        if (GetStorage().read('token') != null) {
          ApiController().getUserData().then((value) => {
            _getController.changeMeUser(value),
            _getController.changeWidgetOptions(),
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SamplePage()),)});
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}