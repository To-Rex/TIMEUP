import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_up/elements/functions.dart';

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
  final TextEditingController adressController = TextEditingController();

  getUsers() async {
    getController.changeMeUser(await ApiController().getUserData(GetStorage().read('token')));
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    nameController.text = getController.meUsers.value.res?.lastName ?? '';
    surnameController.text = getController.meUsers.value.res?.fistName ?? '';
    nikNameController.text = getController.meUsers.value.res?.userName ?? '';
    adressController.text = getController.meUsers.value.res?.address ?? '';

    return SizedBox(
      width: w,
      child: Column(
        children: [
          SizedBox(
            height: h * 0.05,
          ),
          Center(
            child: CircleAvatar(
              radius: w * 0.12,
              foregroundColor: Colors.blue,
              backgroundImage: NetworkImage(
                  '${ApiController().url}${getController.meUsers.value.res?.photoUrl?.substring(33)}'),
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
            controller: adressController,
            labelText: 'Adress',
          ),
          SizedBox(height: h * 0.15),
          EditButton(
            text: 'Save data',
            onPressed: () {
              ApiController()
                  .editUser(
                GetStorage().read('token'),
                nameController.text,
                surnameController.text,
                nikNameController.text,
                adressController.text,
              ).then((value) {
                if (value.status == true){
                  getController.entersUser.value = 0;
                  getUsers();
                }else{
                  print('error');
                }
              });
            },
          ),
          SizedBox(height: h * 0.05),
        ],
      ),
    );
  }
}
