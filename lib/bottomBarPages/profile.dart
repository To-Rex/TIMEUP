import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_up/api/api_controller.dart';

import '../elements/btn_users.dart';
import '../pages/login_page.dart';
import '../pages/user_edit.dart';
import '../res/getController.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);


  final GetController getController = Get.put(GetController());

  getUsers() async {
    getController.changeMeUser(await ApiController().getUserData(GetStorage().read('token')));
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    getController.clearMeUser();
    getUsers();

    return Obx(() => getController.meUsers.value.status.obs.value == true
        ? SizedBox(
      width: w,
      child: Obx(() => getController.entersUser.value == 0
        ? Column(
        children: [
          SizedBox(
            height: h * 0.01,
          ),
          Text(
            'Doctor_sobit',
            style: TextStyle(
              fontSize: w * 0.04,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: h * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: w * 0.05),
              //network image
              CircleAvatar(
                radius: w * 0.12,
                foregroundColor: Colors.blue,
                backgroundImage: NetworkImage(
                    '${ApiController().url}${getController.meUsers.value.res?.photoUrl?.substring(17, getController.meUsers.value.res?.photoUrl?.length)}'),
              ),
              const Expanded(child: SizedBox()),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: TextButton(
                  onPressed: () {
                    GetStorage().remove('token');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: w * 0.9,
            margin: const EdgeInsets.only(top: 15),
            child: Text('${getController.meUsers.value.res?.fistName} ${getController.meUsers.value.res?.lastName}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            width: w * 0.9,
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.blue,
                  size: 20,
                ),
                SizedBox(
                  width: w * 0.01,
                ),
                Text(
                  '${getController.meUsers.value.res?.phoneNumber}',
                  style: TextStyle(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          //Make business profile button
          EditButton(
            text: 'Make business profile',
            onPressed: () {},
          ),

          EditButton(
            text: 'Edit profile',
            onPressed: () {
              getController.entersUser.value = 1;
            },
          ),
        ],
      )
      : getController.entersUser.value == 1
          ? EditUserPage()
          :EditUserPage(),
      ),

    ) : const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    ));
  }
}