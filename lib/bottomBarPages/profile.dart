import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/elements/functions.dart';

import '../elements/bio_business.dart';
import '../elements/btn_business.dart';
import '../elements/btn_users.dart';
import '../elements/txt_business.dart';
import '../pages/login_page.dart';
import '../pages/make_business.dart';
import '../pages/user_bussines_edit.dart';
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
    getUsers();

    return Obx(() => getController.meUsers.value.res != null
        ? SizedBox(
            width: w,
            child: Obx(
              () => getController.entersUser.value == 0
                  ? Column(
                      children: [
                        SizedBox(
                          height: h * 0.01,
                        ),
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          surfaceTintColor: Colors.transparent,
                          centerTitle: true,
                          title: Text(
                            getController.meUsers.value.res?.userName ?? '',
                            style: TextStyle(
                              fontSize: w * 0.04,
                              color: Colors.black,
                            ),
                          ),
                          actions: [
                            PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
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
                                PopupMenuItem(
                                  child: TextButton(
                                    onPressed: () {
                                      ApiController().deleteMe(
                                          GetStorage().read('token')).then((value) => {
                                            if(value == true){
                                              GetStorage().remove('token'),
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LoginPage(),
                                                ),
                                              )
                                            }else{
                                              Toast.showToast(context, 'Xatolik yuz berdi', Colors.red, Colors.white)
                                            }
                                      }
                                      );
                                    },
                                    child: Text(
                                      'Delete accaunt',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                            ),
                          ],
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
                                  'http://${getController.meUsers.value.res?.photoUrl}'),
                            ),
                            const Expanded(child: SizedBox()),
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
                                          '${getController.meUsers.value.res?.business?.categoryName}',
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
                          color: Colors.blue,
                          icon: Icons.phone,
                        ),
                        Obx(() =>
                            getController.meUsers.value.res?.business != null
                                ? TextEditButton(
                                    text: '${getController.meUsers.value.res?.business?.officeAddress}',
                                    color: Colors.blue,
                                    icon: Icons.location_on,
                                  )
                                : const SizedBox()),
                        Obx(() => getController.meUsers.value.res?.business != null
                                ? TextEditButton(
                                    text: '${getController.meUsers.value.res?.business?.officeName}',
                                    color: Colors.blue,
                                    icon: Icons.home,
                                  )
                                : const SizedBox()),
                        Obx(() => getController.meUsers.value.res?.business != null
                                ? TextEditButton(
                                    text: '${getController.meUsers.value.res?.business?.dayOffs}',
                                    color: Colors.blue,
                                    icon: Icons.access_time_outlined,
                                  )
                                : const SizedBox()),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Obx(() =>
                            getController.meUsers.value.res?.business == null
                                ? EditButton(
                                    text: 'Make business profile',
                                    onPressed: () {
                                      getController.nextPages.value = 0;
                                      getController.entersUser.value = 2;
                                    },
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
                        Obx(() => getController.meUsers.value.res?.business == null
                                ? const SizedBox()
                                : BioBusiness(text: getController.meUsers.value.res?.business?.bio ?? '')),
                      ],
                    )
                  : getController.entersUser.value == 1
                      ? getController.meUsers.value.res?.business == null
                          ? EditUserPage()
                          : EditBusinessUserPage()
                      : getController.entersUser.value == 2
                          ? MakeBusinessPage()
                          : const SizedBox(),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ));
  }
}
