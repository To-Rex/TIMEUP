import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_up/api/api_controller.dart';
import '../res/getController.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());
  final TextEditingController _dateController = TextEditingController();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    _getController.nextPagesUserDetails.value = 0;
    //26/11/2023
    var currentDate = '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
    print(currentDate);
    currentDate = '';
    if (_getController.meUsers.value.res?.business == null) {
      //ApiController().bookingClientGetList('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjEwMzM2MDY2MTEyLCJpYXQiOjE2OTYwNjYxMTIsInN1YiI6IjMifQ.ueJ0RCf8pLq_5yUcuon7MDjP8a56IIaZw4maWPp-ZKA').then((value) => _getController.changeBookingBusinessGetList(value));
      ApiController().bookingClientGetList(currentDate).then((value) => _getController.changeBookingBusinessGetList(value));
    } else {
      ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value).then((value) => _getController.changeBookingBusinessGetList(value));
      //ApiController().bookingClientGetList('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjEwMzM2MDY2MTEyLCJpYXQiOjE2OTYwNjYxMTIsInN1YiI6IjMifQ.ueJ0RCf8pLq_5yUcuon7MDjP8a56IIaZw4maWPp-ZKA').then((value) => _getController.changeBookingBusinessGetList1(value));
      ApiController().bookingClientGetList(currentDate).then((value) => _getController.changeBookingBusinessGetList1(value));
    }

    return SizedBox(
      width: w,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title:
                  Obx(() => _getController.meUsers.value.res?.business == null
                      ? SizedBox(
                          height: h * 0.045,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Eslatma',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(() => _getController.nextPagesUserDetails.value ==
                                    0
                                ? SizedBox(
                                    width: w * 0.45,
                                    child: TextButton(
                                      onPressed: () {
                                        pageController.animateToPage(
                                          0,
                                          duration: const Duration(
                                              milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                      child: const Text(
                                        'Eslatma',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: w * 0.45,
                                    child: TextButton(
                                      onPressed: () {
                                        pageController.animateToPage(
                                          0,
                                          duration: const Duration(
                                              milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                      child: const Text(
                                        'Eslatma',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )),
                            Container(
                              width: w * 0.005,
                              height: h * 0.03,
                              color: Colors.grey,
                            ),
                            Obx(() => _getController.nextPagesUserDetails.value ==
                                    1
                                ? SizedBox(
                                    width: w * 0.45,
                                    child: TextButton(
                                      onPressed: () {
                                        pageController.animateToPage(
                                          1,
                                          duration: const Duration(
                                              milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                      child: const Text(
                                        'Sizning Mijozlaringiz',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: w * 0.45,
                                    child: TextButton(
                                      onPressed: () {
                                        pageController.animateToPage(
                                          1,
                                          duration: const Duration(
                                              milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                      child: const Text(
                                        'Sizning Mijozlaringiz',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )),
                          ],
                        )),
              centerTitle: true,
            ),
            SizedBox(
              width: w * 0.9,
              height: h * 0.07,
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2025),
                      ).then((value) => {
                        //cler bookingClientGetList
                        _getController.clearBookingBusinessGetList(),
                        _getController.clearBookingBusinessGetList1(),
                        _dateController.text = '${value!.day}/${value.month}/${value.year}',
                        //ApiController().bookingClientGetList('${value.day}/${value.month}/${value.year}').then((value) => _getController.changeBookingBusinessGetList(value)),
                        //ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value).then((value) => _getController.changeBookingBusinessGetList1(value)),
                        if (_getController.meUsers.value.res?.business == null) {
                          ApiController().bookingClientGetList('${value.day}/${value.month}/${value.year}').then((value) => _getController.changeBookingBusinessGetList(value)),
                        }else{
                          ApiController().bookingClientGetList('${value.day}/${value.month}/${value.year}').then((value) => _getController.changeBookingBusinessGetList(value)),
                          ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value).then((value) => _getController.changeBookingBusinessGetList1(value)),
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
            SizedBox(
              height: h * 0.02,
            ),
            if (_getController.meUsers.value.res?.business != null)
              Obx(() => _getController.bookingBusinessGetList.value.res != null
                  ? SizedBox(
                  height: h * 0.75,
                  child: PageView(
                    //physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      _getController.nextPagesUserDetails.value = index;
                    },
                    controller: pageController,
                    children: [
                      SizedBox(
                        child: Obx(() => _getController.bookingBusinessGetList.value.res!.isEmpty
                            ? const Center(
                                child: Text('Ma`lumot mavjud emas'),
                              )
                            : SizedBox(
                                height: h * 0.68,
                                child: ListView.builder(
                                  itemCount: _getController
                                      .bookingBusinessGetList.value.res!.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _getController
                                                    .bookingBusinessGetList
                                                    .value
                                                    .res![index]
                                                    .photoUrl ==
                                                null
                                            ? const CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage(
                                                  'assets/images/doctor.png',
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                  //"${ApiController().url.substring(0, ApiController().url.length - 1)}${_getController.bookingBusinessGetList.value.res![index].photoUrl!}",
                                                  "http://${_getController.bookingBusinessGetList.value.res![index].photoUrl!}",
                                                ),
                                              ),
                                        SizedBox(
                                          width: w * 0.6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _getController
                                                    .bookingBusinessGetList
                                                    .value
                                                    .res![index]
                                                    .userName!,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              //User profession
                                              Text(
                                                '${_getController.bookingBusinessGetList.value.res![index].fistName!} ${_getController.bookingBusinessGetList.value.res![index].lastName!}',
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone,
                                                    size: 15,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    _getController
                                                        .bookingBusinessGetList
                                                        .value
                                                        .res![index]
                                                        .phoneNumber!,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //if _getController.meUsers.value.res?.business != null Mijozingiz navbati: else Sizning navbatingiz:
                                              Text(
                                                _getController.meUsers.value.res
                                                            ?.business !=
                                                        null
                                                    ? 'Mijozingiz navbati: ${_getController.bookingBusinessGetList.value.res![index].date!} ${_getController.bookingBusinessGetList.value.res![index].time!}'
                                                    : 'Sizning navbatingiz: ${_getController.bookingBusinessGetList.value.res![index].date!} ${_getController.bookingBusinessGetList.value.res![index].time!}',
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )),
                      ),
                      SizedBox(
                        child: Obx(() => _getController.bookingBusinessGetList1.value.res!.isEmpty||_getController.bookingBusinessGetList1.value.res == null
                            ? const Center(
                                child: Text('Ma`lumot mavjud emas'),
                              )
                            : SizedBox(
                                height: h * 0.68,
                                child: ListView.builder(
                                  itemCount: _getController
                                      .bookingBusinessGetList1
                                      .value
                                      .res!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _getController
                                                    .bookingBusinessGetList1
                                                    .value
                                                    .res![index]
                                                    .photoUrl ==
                                                null
                                            ? const CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage(
                                                  'assets/images/doctor.png',
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                  //"${ApiController().url.substring(0, ApiController().url.length - 1)}${_getController.bookingBusinessGetList1.value.res![index].photoUrl!}",
                                                  "http://${_getController.bookingBusinessGetList1.value.res![index].photoUrl!}",
                                                ),
                                              ),
                                        SizedBox(
                                          width: w * 0.6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _getController
                                                    .bookingBusinessGetList1
                                                    .value
                                                    .res![index]
                                                    .userName!,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              //User profession
                                              Text(
                                                '${_getController.bookingBusinessGetList1.value.res![index].fistName!} ${_getController.bookingBusinessGetList1.value.res![index].lastName!}',
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone,
                                                    size: 15,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    _getController
                                                        .bookingBusinessGetList1
                                                        .value
                                                        .res![index]
                                                        .phoneNumber!,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //if _getController.meUsers.value.res?.business != null Mijozingiz navbati: else Sizning navbatingiz:
                                              Text(
                                                _getController.meUsers.value.res
                                                            ?.business !=
                                                        null
                                                    ? 'Mijozingiz navbati: ${_getController.bookingBusinessGetList1.value.res![index].date!} ${_getController.bookingBusinessGetList1.value.res![index].time!}'
                                                    : 'Sizning navbatingiz: ${_getController.bookingBusinessGetList1.value.res![index].date!} ${_getController.bookingBusinessGetList1.value.res![index].time!}',
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )),
                      ),
                    ],
                  ))
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
            if (_getController.meUsers.value.res?.business == null)
              Obx(() => _getController.bookingBusinessGetList.value.res != null
                  ? SizedBox(
                child: Obx(() => _getController
                    .bookingBusinessGetList.value.res!.isEmpty
                    ? const Center(
                  child: Text('Ma`lumot mavjud emas'),
                )
                    : SizedBox(
                  height: h * 0.68,
                  child: ListView.builder(
                    itemCount: _getController
                        .bookingBusinessGetList.value.res!.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          _getController
                              .bookingBusinessGetList
                              .value
                              .res![index]
                              .photoUrl ==
                              null
                              ? const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/images/doctor.png',
                            ),
                          )
                              : CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              //"${ApiController().url.substring(0, ApiController().url.length - 1)}${_getController.bookingBusinessGetList.value.res![index].photoUrl!}",
                              "http://${_getController.bookingBusinessGetList.value.res![index].photoUrl!}",
                            ),
                          ),
                          SizedBox(
                            width: w * 0.6,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getController
                                      .bookingBusinessGetList
                                      .value
                                      .res![index]
                                      .userName!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                //User profession
                                Text(
                                  '${_getController.bookingBusinessGetList.value.res![index].fistName!} ${_getController.bookingBusinessGetList.value.res![index].lastName!}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      _getController
                                          .bookingBusinessGetList
                                          .value
                                          .res![index]
                                          .phoneNumber!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight:
                                        FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                //if _getController.meUsers.value.res?.business != null Mijozingiz navbati: else Sizning navbatingiz:
                                Text(
                                  _getController.meUsers.value.res?.business !=
                                      null
                                      ? 'Mijozingiz navbati: ${_getController.bookingBusinessGetList.value.res![index].date!} ${_getController.bookingBusinessGetList.value.res![index].time!}'
                                      : 'Sizning navbatingiz: ${_getController.bookingBusinessGetList.value.res![index].date!} ${_getController.bookingBusinessGetList.value.res![index].time!}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )),
              )
                  : const Center(
                child: CircularProgressIndicator(),
              )),
          ],
        ),
      ),
    );
  }
}
