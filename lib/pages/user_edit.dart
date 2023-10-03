import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/api_controller.dart';
import '../res/getController.dart';

class EditUserPage extends StatelessWidget {
  EditUserPage({Key? key}) : super(key: key);

  final GetController getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          CircleAvatar(
            radius: w * 0.12,
            foregroundColor: Colors.blue,
            backgroundImage: NetworkImage(
                '${ApiController().url}${ getController.meUsers.value.res?.photoUrl?.substring(33)}'),
          ),
        ],
      )
    );
  }
}