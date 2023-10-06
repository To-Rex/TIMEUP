import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_up/api/api_controller.dart';

import '../elements/bio_business.dart';
import '../elements/btn_business.dart';
import '../elements/btn_users.dart';
import '../elements/txt_business.dart';
import '../pages/login_page.dart';
import '../pages/user_edit.dart';
import '../res/getController.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final GetController getController = Get.put(GetController());

  getUsers() async {
    getController.changeMeUser(
        await ApiController().getUserData(GetStorage().read('token')));
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    //getController.clearMeUser();
    getUsers();

    return Obx(() => getController.meUsers.value.status.obs.value == true
        ? SizedBox(
            width: w,
            child: Obx(
              () => getController.entersUser.value == 0
                  ? Column(
                      children: [
                        SizedBox(
                          height: h * 0.01,
                        ),
                        Text(
                          getController.meUsers.value.res?.userName ?? '',
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
                          child: Text(
                              '${getController.meUsers.value.res?.fistName} ${getController.meUsers.value.res?.lastName}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                        ),
                        Obx(() =>
                            getController.meUsers.value.res?.business != null
                                ? Container(
                                    width: w * 0.9,
                                    margin: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${getController.meUsers.value.res?.business?.workCategoryId}',
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: w * 0.01,
                                        ),
                                        Text(
                                          '${getController.meUsers.value.res?.business?.experience} years of experience',
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ))
                                : const SizedBox()),
                        TextEditButton(
                          text:
                              '${getController.meUsers.value.res?.phoneNumber}',
                          color: Colors.blue, icon: Icons.phone,
                        ),
                        Obx(() =>
                            getController.meUsers.value.res?.business != null
                                ? TextEditButton(
                                    text:
                                        '${getController.meUsers.value.res?.business?.officeAddress}',
                                    color: Colors.blue, icon: Icons.location_on,
                                  )
                                : const SizedBox()),
                        Obx(() =>
                            getController.meUsers.value.res?.business != null
                                ? TextEditButton(
                                    text:
                                        '${getController.meUsers.value.res?.business?.officeName}',
                                    color: Colors.blue, icon: Icons.home,
                                  )
                                : const SizedBox()),
                        Obx(() =>
                            getController.meUsers.value.res?.business != null
                                ? TextEditButton(
                                    text:
                                        '${getController.meUsers.value.res?.business?.dayOffs}',
                                    color: Colors.blue, icon: Icons.access_time_outlined,
                                  )
                                : const SizedBox()),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Obx(() =>
                            getController.meUsers.value.res?.business == null
                                ? EditButton(
                                    text: 'Make business profile',
                                    onPressed: () {},
                                  )
                                : SizedBox(
                                    width: w * 0.9,
                                    height: h * 0.06,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w * 0.4,
                                          height: h * 0.063,
                                          child: BusinessEditButton(
                                            text: 'Edit profile',
                                            onPressed: () {
                                              getController.entersUser.value =
                                                  1;
                                            },
                                            color: Colors.blue,
                                            radius: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                        Obx(() => getController.meUsers.value.res?.business ==
                                null
                            ? EditButton(
                                text: 'Edit profile',
                                onPressed: () {
                                  getController.entersUser.value = 1;
                                },
                              )
                            : SizedBox(
                                child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //Biografiya and Ish Jadvali
                                  SizedBox(
                                    width: w * 0.5,
                                    height: h * 0.062,
                                    child: BusinessEditButton(
                                      text: 'Biografiya',
                                      onPressed: () {},
                                      color: Colors.blue,
                                      radius: 0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: w * 0.5,
                                    height: h * 0.062,
                                    child: BusinessEditButton(
                                      text: 'Ish jadvali',
                                      onPressed: () {},
                                      color: Colors.grey,
                                      radius: 0,
                                    ),
                                  ),
                                ],
                              ))),
                        Obx(() =>
                            getController.meUsers.value.res?.business == null
                                ? const SizedBox()
                                : BioBusiness(text: getController.meUsers.value.res?.business?.bio ?? '')),
                      ],
                    )
                  : getController.entersUser.value == 1
                      ? EditUserPage()
                      : EditUserPage(),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ));
  }
}
