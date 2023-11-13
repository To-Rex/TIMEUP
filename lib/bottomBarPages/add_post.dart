import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons/heroicons.dart';
import 'package:time_up/api/api_controller.dart';
import '../pages/login_page.dart';
import '../res/getController.dart';

class AddPostPage extends StatelessWidget {
  AddPostPage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());
  final TextEditingController _dateController = TextEditingController();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    if (GetStorage().read('token') == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Center(
          child: Text(
            'Post qo\'shish',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Camera
      ],
    );
  }
}
