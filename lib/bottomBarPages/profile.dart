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
  final PageController pageController = PageController();
  final TextEditingController _dateController = TextEditingController();

  getUsers() async {
    getController.changeMeUser(await ApiController().getUserData());
  }

  showDialogs(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(''),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: const Center(
            child: Text('Do you want delete you accaount ? '),
          ),
        ),
        actions: [
          Center(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ))),
                ),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        ApiController().deleteMe().then((value) => {
                              if (value == true)
                                {
                                  GetStorage().remove('token'),
                                  getController.clearMeUser(),
                                  getController.clearCategory(),
                                  Navigator.pop(context),
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  ),
                                }
                              else
                                {
                                  Toast.showToast(context, 'Xatolik yuz berdi',
                                      Colors.red, Colors.white)
                                }
                            });
                      },
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Text('Delete',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                          const Icon(Icons.check, color: Colors.white),
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  showClosDialogs(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(''),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: const Center(
            child: Text('Do you want log out ? '),
          ),
        ),
        actions: [
          Center(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ))),
                ),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                        GetStorage().remove('token');
                        getController.clearMeUser();
                        getController.clearCategory();
                      },
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Text('Log out',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                          const Icon(Icons.check, color: Colors.white),
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  showBottomSheetList(context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: h * 0.1),
              Row(
                children: [
                  SizedBox(width: w * 0.05),
                  const Text('kunni tanlang'),
                ],
              ),
              SizedBox(
                width: w * 0.9,
                height: h * 0.07,
                child: TextField(
                  controller: _dateController,
                  onChanged: (value) {
                    if (value != '') {
                      ApiController().bookingBusinessGetList(getController.meUsers.value.res!.business!.id!, '').then((value) => getController.changeBookingBusinessGetList(value));
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: _dateController.text == '' ? DateTime.now() : DateTime.parse('${_dateController.text.substring(6, 10)}-${_dateController.text.substring(3, 5)}-${_dateController.text.substring(0, 2)}'),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2025),
                        ).then((value) => {
                              if (value != null){
                                _dateController.text = '${value.day < 10 ? '0${value.day}' : value.day}/${value.month < 10 ? '0${value.month}' : value.month}/${value.year}',
                                ApiController().bookingBusinessGetList(getController.meUsers.value.res!.business!.id!, _dateController.text).then((value) => getController.changeBookingBusinessGetList(value))
                              }else{
                                _dateController.text = ''
                              }
                        });
                      },
                      child: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: 'MM / DD / YYYY',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Expanded(child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                child: Obx(() => getController.bookingBusinessGetList.value.res == null
                    ? const Center(child: Text('Ma\'lumotlar topilmadi'))
                    : ListView.builder(
                    shrinkWrap: true,
                    itemCount: getController.bookingBusinessGetList.value.res!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: w * 0.08,
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: w * 0.7,
                                child: Text(
                                  'Ushbu mijoz'
                                      ' ${getController.bookingBusinessGetList.value.res![index].date!.replaceAll('/', '-')} '
                                      '${getController.bookingBusinessGetList.value.res![index].time!} keladi',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      );
                    }),),
              )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (GetStorage().read('token') == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    getUsers();
    /*return Obx(() => getController.meUsers.value.res != null
        ? SizedBox(
            width: w,
            child: Obx(
              () => getController.entersUser.value == 0
                  ? Column(
                      children: [
                        SizedBox(height: h * 0.01),
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
                                      showClosDialogs(context);
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
                                      showDialogs(context);
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
                        SizedBox(height: h * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: w * 0.05),
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
                                    text:
                                        '${getController.meUsers.value.res?.business?.officeAddress}',
                                    color: Colors.blue,
                                    icon: Icons.location_on,
                                  )
                                : const SizedBox()),
                        Obx(() =>
                            getController.meUsers.value.res?.business != null
                                ? TextEditButton(
                                    text:
                                        '${getController.meUsers.value.res?.business?.officeName}',
                                    color: Colors.blue,
                                    icon: Icons.home,
                                  )
                                : const SizedBox()),
                        Obx(() =>
                            getController.meUsers.value.res?.business != null
                                ? TextEditButton(
                                    text:
                                        '${getController.meUsers.value.res?.business?.dayOffs}',
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
                                  Obx(() => getController
                                              .nextPagesUserDetails.value ==
                                          0
                                      ? SizedBox(
                                          width: w * 0.5,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Biografiya',
                                            onPressed: () {
                                              pageController.animateToPage(0,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.blue,
                                            radius: 0,
                                          ),
                                        )
                                      : SizedBox(
                                          width: w * 0.5,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Biografiya',
                                            onPressed: () {
                                              pageController.animateToPage(0,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.grey,
                                            radius: 0,
                                          ),
                                        )),
                                  Obx(() => getController
                                              .nextPagesUserDetails.value ==
                                          1
                                      ? SizedBox(
                                          width: w * 0.5,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Ish jadvali',
                                            onPressed: () {
                                              pageController.animateToPage(1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.blue,
                                            radius: 0,
                                          ),
                                        )
                                      : SizedBox(
                                          width: w * 0.5,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Ish jadvali',
                                            onPressed: () {
                                              pageController.animateToPage(1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.grey,
                                            radius: 0,
                                          ),
                                        )),
                                ],
                              ))),
                        Obx(
                          () =>
                              getController.meUsers.value.res?.business == null
                                  ? const SizedBox()
                                  : SizedBox(
                                      width: w * 0.95,
                                      height: h * 0.3,
                                      child: PageView(
                                        //physics: const NeverScrollableScrollPhysics(),
                                        onPageChanged: (index) {
                                          getController.nextPagesUserDetails
                                              .value = index;
                                        },
                                        controller: pageController,
                                        children: [
                                          BioBusiness(
                                            text: getController.meUsers.value
                                                    .res?.business?.bio ??
                                                '',
                                          ),
                                          SizedBox(
                                            width: w * 0.9,
                                            height: h * 0.22,
                                            child: Obx(
                                              () => getController
                                                          .bookingBusinessGetList
                                                          .value
                                                          .res ==
                                                      null
                                                  ? const Center(
                                                      child: Text(
                                                          'Ma\'lumotlar topilmadi'))
                                                  : Container(
                                                      height: h * 0.22,
                                                      margin: EdgeInsets.only(
                                                          top: h * 0.02),
                                                      padding: EdgeInsets.all(
                                                          w * 0.02),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: h * 0.205,
                                                            child: ListView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount: getController
                                                                        .bookingBusinessGetList
                                                                        .value
                                                                        .res!
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              SizedBox(
                                                                                width: w * 0.08,
                                                                                child: Text(
                                                                                  '${index + 1}',
                                                                                  style: TextStyle(
                                                                                    fontSize: w * 0.04,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: w * 0.7,
                                                                                child: Text(
                                                                                  'Ushbu mijoz' ' ${getController.bookingBusinessGetList.value.res![index].date!.replaceAll('/', '-')} ' '${getController.bookingBusinessGetList.value.res![index].time!} keladi',
                                                                                  style: TextStyle(
                                                                                    fontSize: w * 0.04,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const Divider(),
                                                                        ],
                                                                      );
                                                                    }),
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Expanded(
                                                                  child:
                                                                      SizedBox()),
                                                              SizedBox(
                                                                height:
                                                                    h * 0.05,
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    showBottomSheetList(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    'Barchasini ko\'rish',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          w * 0.04,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                        ),
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
          ));*/
    return WillPopScope(
      onWillPop: () async {
        if (getController.entersUser.value == 0) {
          return true;
        } else if (getController.entersUser.value == 1) {
          getController.entersUser.value = 0;
          return false;
        } else if (getController.entersUser.value == 2) {
          getController.entersUser.value = 1;
          return false;
        } else {
          return false;
        }
      },
      child: Obx(() => getController.meUsers.value.res != null
        ? SizedBox(
            width: w,
            child: Obx(
              () => getController.entersUser.value == 0
                  ? Column(
                      children: [
                        SizedBox(height: h * 0.01),
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
                                      showClosDialogs(context);
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
                                      showDialogs(context);
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
                        SizedBox(height: h * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: w * 0.05),
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
                                    text:
                                        '${getController.meUsers.value.res?.business?.officeAddress}',
                                    color: Colors.blue,
                                    icon: Icons.location_on,
                                  )
                                : const SizedBox()),
                        Obx(() =>
                            getController.meUsers.value.res?.business != null
                                ? TextEditButton(
                                    text:
                                        '${getController.meUsers.value.res?.business?.officeName}',
                                    color: Colors.blue,
                                    icon: Icons.home,
                                  )
                                : const SizedBox()),
                        Obx(() =>
                            getController.meUsers.value.res?.business != null
                                ? TextEditButton(
                                    text:
                                        '${getController.meUsers.value.res?.business?.dayOffs}',
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
                                  Obx(() => getController
                                              .nextPagesUserDetails.value ==
                                          0
                                      ? SizedBox(
                                          width: w * 0.5,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Biografiya',
                                            onPressed: () {
                                              pageController.animateToPage(0,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.blue,
                                            radius: 0,
                                          ),
                                        )
                                      : SizedBox(
                                          width: w * 0.5,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Biografiya',
                                            onPressed: () {
                                              pageController.animateToPage(0,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.grey,
                                            radius: 0,
                                          ),
                                        )),
                                  Obx(() => getController
                                              .nextPagesUserDetails.value ==
                                          1
                                      ? SizedBox(
                                          width: w * 0.5,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Ish jadvali',
                                            onPressed: () {
                                              pageController.animateToPage(1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.blue,
                                            radius: 0,
                                          ),
                                        )
                                      : SizedBox(
                                          width: w * 0.5,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Ish jadvali',
                                            onPressed: () {
                                              pageController.animateToPage(1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.grey,
                                            radius: 0,
                                          ),
                                        )),
                                ],
                              ))),
                        Obx(
                          () =>
                              getController.meUsers.value.res?.business == null
                                  ? const SizedBox()
                                  : SizedBox(
                                      width: w * 0.95,
                                      height: h * 0.3,
                                      child: PageView(
                                        //physics: const NeverScrollableScrollPhysics(),
                                        onPageChanged: (index) {
                                          getController.nextPagesUserDetails
                                              .value = index;
                                        },
                                        controller: pageController,
                                        children: [
                                          BioBusiness(
                                            text: getController.meUsers.value
                                                    .res?.business?.bio ??
                                                '',
                                          ),
                                          SizedBox(
                                            width: w * 0.9,
                                            height: h * 0.22,
                                            child: Obx(
                                              () => getController
                                                          .bookingBusinessGetList
                                                          .value
                                                          .res ==
                                                      null
                                                  ? const Center(
                                                      child: Text(
                                                          'Ma\'lumotlar topilmadi'))
                                                  : Container(
                                                      height: h * 0.22,
                                                      margin: EdgeInsets.only(
                                                          top: h * 0.02),
                                                      padding: EdgeInsets.all(
                                                          w * 0.02),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: h * 0.205,
                                                            child: ListView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount: getController
                                                                        .bookingBusinessGetList
                                                                        .value
                                                                        .res!
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              SizedBox(
                                                                                width: w * 0.08,
                                                                                child: Text(
                                                                                  '${index + 1}',
                                                                                  style: TextStyle(
                                                                                    fontSize: w * 0.04,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: w * 0.7,
                                                                                child: Text(
                                                                                  'Ushbu mijoz' ' ${getController.bookingBusinessGetList.value.res![index].date!.replaceAll('/', '-')} ' '${getController.bookingBusinessGetList.value.res![index].time!} keladi',
                                                                                  style: TextStyle(
                                                                                    fontSize: w * 0.04,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const Divider(),
                                                                        ],
                                                                      );
                                                                    }),
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Expanded(
                                                                  child:
                                                                      SizedBox()),
                                                              SizedBox(
                                                                height:
                                                                    h * 0.05,
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    showBottomSheetList(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    'Barchasini ko\'rish',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          w * 0.04,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                        ),
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
          )),
    );
  }
}
