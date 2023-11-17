import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:time_up/api/api_controller.dart';
import '../res/getController.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());
  final TextEditingController _dateController = TextEditingController();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    _getController.clearBookingBusinessGetList();
    _getController.clearBookingBusinessGetList1();
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    _getController.nextPagesUserDetails.value = 0;
    if (_getController.meUsers.value.res?.business == null) {
      ApiController().bookingClientGetList('');
    } else {
      ApiController().bookingClientGetList('');
      ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, '');
    }
    return SizedBox(
      width: w,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Obx(() => _getController.meUsers.value.res?.business == null
                ? SizedBox(
              height: h * 0.05,
              child: TextButton(
                onPressed: () {
                  pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease,
                  );
                },
                child: Text(
                  'Eslatma',
                  style: TextStyle(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() => _getController.nextPagesUserDetails.value == 0
                    ? SizedBox(
                  width: w * 0.45,
                  child: TextButton(
                    onPressed: () {
                      pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Text(
                      'Eslatma',
                      style: TextStyle(
                        fontSize: w * 0.04,
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
                      pageController.animateToPage(0,
                        duration:
                        const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Text(
                      'Eslatma',
                      style: TextStyle(
                        fontSize: w * 0.04,
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
                Obx(() => _getController.nextPagesUserDetails.value == 1
                    ? SizedBox(
                  width: w * 0.45,
                  child: TextButton(
                    onPressed: () {
                      pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease,);
                    },
                    child: Text(
                      'Sizning Mijozlaringiz',
                      style: TextStyle(
                        fontSize: w * 0.04,
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
                      pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease,);
                    },
                    child: Text(
                      'Sizning Mijozlaringiz',
                      style: TextStyle(
                        fontSize: w * 0.04,
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
              onChanged: (value) {
                if (value == '') {
                  if (_getController.meUsers.value.res?.business == null) {
                    ApiController().bookingClientGetList('');
                  } else {
                    if (_getController.nextPagesUserDetails.value == 1) {
                      ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, '');
                    } else {
                      ApiController().bookingClientGetList('');
                    }
                  }
                }
              },
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: _dateController.text == '' ? DateTime.now() : DateTime.parse('${_dateController.text.substring(6, 10)}-${_dateController.text.substring(3, 5)}-${_dateController.text.substring(0, 2)}'), firstDate: DateTime(1900), lastDate: DateTime(2025),).then((value) => {_dateController.text = '${value!.day < 10 ? '0${value.day}' : value.day}/${value.month < 10 ? '0${value.month}' : value.month}/${value.year}',
                      if (_getController.meUsers.value.res?.business == null){
                        ApiController().bookingClientGetList(_dateController.text)
                        //ApiController().bookingClientGetList(_dateController.text).then((value) => _getController.changeBookingBusinessGetList(value))
                      } else {
                        if (_getController.nextPagesUserDetails.value == 1){
                          ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, _dateController.text)
                          //ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value, _dateController.text).then((value) => _getController.changeBookingBusinessGetList(value)),
                        } else {
                          //ApiController().bookingClientGetList(_dateController.text).then((value) => _getController.changeBookingBusinessGetList1(value))
                          ApiController().bookingClientGetList(_dateController.text)
                        }
                      }
                    });
                  },
                  child: const HeroIcon(
                    HeroIcons.calendar,
                    color: Colors.black,
                  ),
                ),
                hintText: 'MM / DD / YYYY',
                hintStyle: TextStyle(
                  fontSize: w * 0.04,
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
          if (_getController.meUsers.value.res?.business != null)
            Obx(() => _getController.bookingBusinessGetList.value.res != null
                ? SizedBox(
                height: h * 0.67,
                child: PageView(
                  onPageChanged: (index) {
                    _getController.nextPagesUserDetails.value = index;
                    _dateController.text = '';
                    if (_getController.meUsers.value.res?.business == null) {
                      ApiController().bookingClientGetList('');
                    } else {
                      if (_getController.nextPagesUserDetails.value == 1) {
                        ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, '');
                      } else {
                        ApiController().bookingClientGetList('');
                      }
                    }
                  },
                  controller: pageController,
                  children: [
                    SizedBox(
                      child: Obx(() => _getController.bookingBusinessGetList.value.res!.isEmpty
                          ? const Center(child: Text('Ma`lumot mavjud emas'),)
                          : SizedBox(
                        height: h * 0.68,
                        child: ListView.builder(
                          itemCount: _getController.bookingBusinessGetList.value.res!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                _getController.bookingBusinessGetList.value.res![index].photoUrl == null
                                    ? CircleAvatar(
                                  radius: w * 0.08,
                                  backgroundImage: const AssetImage(
                                    'assets/images/doctor.png',
                                  ),
                                )
                                    : CircleAvatar(radius: w * 0.08, backgroundImage: NetworkImage(_getController.bookingBusinessGetList.value.res![index].photoUrl!,),),
                                SizedBox(
                                  width: w * 0.6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(_getController.bookingBusinessGetList.value.res![index].userName!,
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      //User profession
                                      Text(
                                        '${_getController.bookingBusinessGetList.value.res![index].fistName!} ${_getController.bookingBusinessGetList.value.res![index].lastName!}',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          HeroIcon(
                                            HeroIcons.phone,
                                            size: w * 0.04,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(width: w * 0.01),
                                          Text(_getController.bookingBusinessGetList.value.res![index].phoneNumber!,
                                            style: TextStyle(
                                              fontSize: w * 0.04,
                                              fontWeight:
                                              FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text('Sizning navbatingiz: ${_getController.bookingBusinessGetList.value.res![index].date!} ${_getController.bookingBusinessGetList.value.res![index].time!}',
                                        style: TextStyle(
                                          fontSize: w * 0.03,
                                          fontWeight:
                                          FontWeight.w400,
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
                      child: Obx(() => _getController.bookingBusinessGetList1.value.res!.isEmpty
                          ? const Center(child: Text('Ma`lumot mavjud emas'),)
                          : SizedBox(
                        height: h * 0.68,
                        child: ListView.builder(
                          itemCount: _getController.bookingBusinessGetList1.value.res!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                _getController.bookingBusinessGetList1.value.res![index].photoUrl == null
                                    ? CircleAvatar(
                                  radius: w * 0.08,
                                  backgroundImage: const AssetImage(
                                    'assets/images/doctor.png',
                                  ),
                                )
                                    : CircleAvatar(
                                  radius: w * 0.08,
                                  backgroundImage:
                                  NetworkImage(
                                    //"${ApiController().url.substring(0, ApiController().url.length - 1)}${_getController.bookingBusinessGetList1.value.res![index].photoUrl!}",
                                    _getController.bookingBusinessGetList1.value.res![index].photoUrl!,
                                  ),
                                ),
                                SizedBox(
                                  width: w * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(_getController.bookingBusinessGetList1.value.res![index].userName!,
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight:
                                          FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      //User profession
                                      Text(
                                        '${_getController.bookingBusinessGetList1.value.res![index].fistName!} '
                                            '${_getController.bookingBusinessGetList1.value.res![index].lastName!}',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight:
                                          FontWeight.w400,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          HeroIcon(
                                            HeroIcons.phone,
                                            size: w * 0.04,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                            width: w * 0.01,
                                          ),
                                          Text(_getController.bookingBusinessGetList1.value.res![index].phoneNumber!,
                                            style: TextStyle(
                                              fontSize: w * 0.04,
                                              fontWeight:
                                              FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Mijozingiz navbati: ${_getController.bookingBusinessGetList1.value.res![index].date!} ${_getController.bookingBusinessGetList1.value.res![index].time!}',
                                        style: TextStyle(
                                          fontSize: w * 0.03,
                                          fontWeight:
                                          FontWeight.w400,
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: w * 0.01,
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
            ),
            ),
          if (_getController.meUsers.value.res?.business == null)
            Obx(() => _getController.bookingBusinessGetList.value.res != null
                ? SizedBox(
              child: Obx(() => _getController.bookingBusinessGetList.value.res!.isEmpty
                  ? const Center(child: Text('Ma`lumot mavjud emas'),)
                  : SizedBox(
                height: h * 0.68,
                child: ListView.builder(
                  itemCount: _getController.bookingBusinessGetList.value.res!.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _getController.bookingBusinessGetList.value.res![index].photoUrl == null
                            ? CircleAvatar(radius: w * 0.08, backgroundImage: const AssetImage('assets/images/doctor.png',),)
                            : CircleAvatar(radius: w * 0.08, backgroundImage: NetworkImage(_getController.bookingBusinessGetList.value.res![index].photoUrl!,),),
                        SizedBox(
                          width: w * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_getController.bookingBusinessGetList.value.res![index].userName!,
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${_getController.bookingBusinessGetList.value.res![index].fistName!} ${_getController.bookingBusinessGetList.value.res![index].lastName!}',
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: [
                                  HeroIcon(
                                    HeroIcons.phone,
                                    size: w * 0.04,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(width: w * 0.01),
                                  Text(_getController.bookingBusinessGetList.value.res![index].phoneNumber!,
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Text('Sizning navbatingiz: ${_getController.bookingBusinessGetList.value.res![index].date!} ${_getController.bookingBusinessGetList.value.res![index].time!}',
                                style: TextStyle(
                                  fontSize: w * 0.03,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Divider(color: Colors.grey),
                              SizedBox(height: w * 0.01)
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              ),
            )
                : const Center(
              child: CircularProgressIndicator(),
            ),
            ),
        ],
      ),
    );
  }
}
