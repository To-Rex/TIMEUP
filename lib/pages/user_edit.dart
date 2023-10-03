import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/api_controller.dart';
import '../elements/btn_users.dart';
import '../elements/text_filds.dart';
import '../res/getController.dart';

class EditUserPage extends StatelessWidget {
  EditUserPage({Key? key}) : super(key: key);

  final GetController getController = Get.put(GetController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nikNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: h * 0.05,
          ),
          Center(
            child: CircleAvatar(
              radius: w * 0.12,
              foregroundColor: Colors.blue,
              backgroundImage: NetworkImage(
                  '${ApiController().url}${ getController.meUsers.value.res?.photoUrl?.substring(33)}'),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Edit profile photo',
              style: TextStyle(
                fontSize: w * 0.04,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: h * 0.05),
          TextFildWidget(
            controller: nameController,
            labelText: 'Name',
          ),
          SizedBox(height: h * 0.015),
          TextFildWidget(
            controller: surnameController,
            labelText: 'Surname',
          ),
          SizedBox(height: h * 0.015),
          TextFildWidget(
            controller: nikNameController,
            labelText: 'Nikname',
          ),
          SizedBox(height: h * 0.015),
          TextFildWidget(
            controller: phoneNumberController,
            labelText: 'Phone number',
          ),
          //take up all the space
          const Expanded(child: SizedBox()),
          EditButton(
            text: 'Save data',
            onPressed: () {

            },
          ),
          SizedBox(height: h * 0.05),
        ],
      )
    );
  }
}