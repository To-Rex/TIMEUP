import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../elements/functions.dart';
import '../res/getController.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late TabController _tabController;

  showBottomSheetList(context, id) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      isDismissible: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              children: [
                Text(
                  'Bookingni tahrirlash',
                  style: TextStyle(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Divider(),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: h * 0.02),
                      Center(
                        child: Text(
                          'Kunni va vaqtni belgilang',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.05),
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
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2025),
                                  ).then((value) => {
                                        _dateController.text = '${value!.day < 10 ? '0${value.day}' : value.day}/${value.month < 10 ? '0${value.month}' : value.month}/${value.year}',
                                      });
                                },
                                child: HeroIcon(
                                  HeroIcons.calendar,
                                  color: Colors.black,
                                  size: w * 0.06,
                                )),
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
                      Row(
                        children: [
                          SizedBox(width: w * 0.05),
                          const Text('vaqtni tanlang'),
                        ],
                      ),
                      SizedBox(
                        width: w * 0.9,
                        height: h * 0.07,
                        child: TextField(
                          controller: _timeController,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                    initialEntryMode: TimePickerEntryMode.input,
                                    hourLabelText: 'Soat',
                                    minuteLabelText: 'Daqiqa',
                                    helpText: 'Vaqtni tanlang',
                                  ).then((value) => _timeController.text =
                                      '${value!.hour < 10 ? '0${value.hour}' : value.hour}:${value.minute < 10 ? '0${value.minute}' : value.minute}');
                                },
                                child: HeroIcon(
                                  HeroIcons.clock,
                                  color: Colors.black,
                                  size: w * 0.06,
                                )),
                            hintText: 'HH : MM',
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
                      SizedBox(height: h * 0.05),
                      SizedBox(
                        width: w * 0.9,
                        height: h * 0.07,
                        child: ElevatedButton(
                          onPressed: () {
                            Loading.showLoading(context);
                            ApiController().updateBooking(id, _dateController.text, _timeController.text, context).then((value) => {
                                      if (value){
                                        if (_getController.meUsers.value.res?.business == null){
                                              ApiController().bookingClientGetList(''),
                                              Loading.hideLoading(context)
                                            } else {
                                              if (_getController.nextPagesUserDetails.value == 1){
                                                  ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, ''),
                                                  Loading.hideLoading(context)
                                                } else {
                                                  ApiController().bookingClientGetList(''),
                                                  Loading.hideLoading(context)
                                                }
                                            }
                                        } else {
                                          Loading.hideLoading(context),
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              surfaceTintColor: Colors.white,
                                              content: SizedBox(
                                                width: w * 0.9,
                                                height: h * 0.2,
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: h * 0.02),
                                                    Text(
                                                      'Xatolik yuz berdi',
                                                      style: TextStyle(
                                                        fontSize: w * 0.05,
                                                        fontWeight: FontWeight.w500, color: Colors.red,
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.02),
                                                    Text(
                                                      'Iltimos qayta urinib ko`ring',
                                                      style: TextStyle(
                                                        fontSize: w * 0.04,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.02),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),), backgroundColor: Colors.blue,),
                                                      child: Text('Ok',
                                                        style: TextStyle(
                                                          fontSize: w * 0.04,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        },
                                      //Navigator.pop(context)
                                    });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            'O`zgarishlarni saqlash',
                            style: TextStyle(
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  _onTap(int index,context) {
    Loading.showLoading(context);
    _getController.nextPagesUserDetails.value = index;
    if (index == 0) {
      _getController.clearBookingBusinessGetList();
      ApiController().bookingClientGetList('').then((value) => {
        Loading.hideLoading(context)
      });
    } else {
      _getController.clearBookingBusinessGetList();
      ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, '').then((value) => {
        Loading.hideLoading(context)
      });
    }
  }

  Future<void> _launchPhone(context, phone) async {
    var url = 'tel:$phone';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }else{
      Toast.showToast(context, 'Telefon ochildi', Colors.green, Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    //_tabController = TabController(length: 2, vsync: Navigator.of(context));
    _tabController = TabController(length: _getController.meUsers.value.res?.business == null ? 1 : 2, vsync: Navigator.of(context));
    _getController.clearBookingBusinessGetList();
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    _getController.nextPagesUserDetails.value = 0;
    ApiController().bookingClientGetList('');

    return Obx(() => _getController.meUsers.value.res?.business != null
        ? Stack(
      children: [
        Positioned(
            top: h * 0.06,
            bottom: 0,
            child: Container(
              height: h * 0.5,
              width: w,
              color: Colors.grey[50],
              child: Column(
                children: [
                  SizedBox(height: h * 0.05),
                  Container(
                    height: h * 0.06,
                    width: w,
                    margin: EdgeInsets.symmetric(horizontal: w * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _scrollController.animateTo(_scrollController.offset - w * 0.3, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,);
                          },
                          child: SizedBox(
                            width: w * 0.1,
                            child: Center(
                              child: HeroIcon(
                                HeroIcons.chevronLeft,
                                color: Colors.black,
                                size: w * 0.06,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _getController.changeSelectedDay(index);
                                  if (index == 3) {
                                    showDialog(context: context, builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      content: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        child: CupertinoDatePicker(
                                          initialDateTime: DateTime.now(),
                                          dateOrder: DatePickerDateOrder.ymd,
                                          onDateTimeChanged: (DateTime newdate) {
                                            _dateController.text = '${newdate.day < 10 ? '0${newdate.day}' : newdate.day}/${newdate.month < 10 ? '0${newdate.month}' : newdate.month}/${newdate.year}';
                                          },
                                          minimumYear: 1900,
                                          maximumYear: 2200,
                                          use24hFormat: true,
                                          mode: CupertinoDatePickerMode.date,
                                        ),
                                      ),

                                      title: Text('Kunni tanlang',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Bekor qilish',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            )
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              if (_tabController.index == 0) {
                                                _getController.clearBookingBusinessGetList();
                                                ApiController().bookingClientGetList(_dateController.text);
                                              } else {
                                                _getController.clearBookingBusinessGetList();
                                                ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, _dateController.text);
                                              }
                                            },
                                            child: Text('Ok',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue,
                                              ),
                                            )
                                        ),
                                      ],
                                    ));
                                  }
                                  _dateController.text = index == 0
                                      ? ''
                                      : index == 1
                                      ? '${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}/${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}/${DateTime.now().year}'
                                      : index == 2
                                      ? '${DateTime.now().day + 1 < 10 ? '0${DateTime.now().day + 1}' : DateTime.now().day + 1}/${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}/${DateTime.now().year}'
                                      : '';

                                  Loading.showLoading(context);
                                  if (_tabController.index == 0) {
                                    _getController.clearBookingBusinessGetList();
                                    ApiController().bookingClientGetList(_dateController.text).then((value) => {
                                      Loading.hideLoading(context)
                                    });
                                  } else {
                                    _getController.clearBookingBusinessGetList();
                                    ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, _dateController.text).then((value) => {
                                      Loading.hideLoading(context)
                                    });
                                  }
                                },
                                child: Obx( () => Container(
                                  margin: EdgeInsets.symmetric(horizontal: w * 0.015, vertical: h * 0.01),
                                  padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.005),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: _getController.selectedDay.value == index ? Colors.blue : Colors.grey,
                                    ),
                                    color: _getController.selectedDay.value == index ? Colors.blue : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      index == 0
                                          ? 'Hamma mijozlar'
                                          : index == 1
                                          ? 'Bugungi mijozlar'
                                          : index == 2
                                          ? 'Keyingi mijozlar'
                                          : 'Tanlangan mijozlar',
                                      style: TextStyle(
                                        fontSize: w * 0.035,
                                        color: _getController.selectedDay.value == index ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ))
                              );
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _scrollController.animateTo(_scrollController.offset + w * 0.3, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut,
                            );
                          },
                          child: SizedBox(
                            width: w * 0.1,
                            child: Center(
                              child: HeroIcon(
                                HeroIcons.chevronRight,
                                color: Colors.black,
                                size: w * 0.06,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.03),
                  Expanded(
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          Obx(() => _getController.bookingBusinessGetList.value.res == null || _getController.bookingBusinessGetList.value.res!.isEmpty
                              ? Center(child: Text('Ma`lumot mavjud emas', style: TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w500, color: Colors.black),))
                              : SizedBox(
                            height: h * 0.68,
                            child: ListView.builder(
                              itemCount: _getController.bookingBusinessGetList.value.res!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
                                    child: Card(
                                      color: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadowColor: Colors.grey.withOpacity(0.5),
                                      elevation: 4,
                                      child: InkWell(
                                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                                          onTap: () {},
                                          child:Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
                                                    width: w * 0.15,
                                                    height: w * 0.15,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(100),
                                                      image: DecorationImage(
                                                        image: NetworkImage(_getController.bookingBusinessGetList.value.res![index].photoUrl!),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.43,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: h * 0.02),
                                                        Text(
                                                          '${_getController.bookingBusinessGetList.value.res![index].fistName!} ${_getController.bookingBusinessGetList.value.res![index].lastName!}',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: w * 0.04,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        SizedBox(height: h * 0.02),
                                                        Text(
                                                          _getController.bookingBusinessGetList.value.res![index].userName!,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: w * 0.04,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(height: h * 0.01),
                                                        Row(
                                                          children: [
                                                            HeroIcon(
                                                              HeroIcons.phone,
                                                              size: w * 0.035,
                                                              color: Colors.grey,
                                                            ),
                                                            SizedBox(width: w * 0.01),
                                                            Text(
                                                              _getController.bookingBusinessGetList.value.res![index].phoneNumber!,
                                                              style: TextStyle(
                                                                fontSize: w * 0.035,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Expanded(child: SizedBox()),
                                                  Container(
                                                    margin: EdgeInsets.only(right: w * 0.03, top: h * 0.01, bottom: h * 0.01),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        PopupMenuButton(
                                                          icon: const Icon(Icons.more_vert),
                                                          surfaceTintColor: Colors.white,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          itemBuilder: (context) => [
                                                            PopupMenuItem(
                                                              child: Row(
                                                                children: [
                                                                  HeroIcon(
                                                                    HeroIcons.pencil,
                                                                    size: w * 0.05,
                                                                    color: Colors.blue,
                                                                  ),
                                                                  SizedBox(width: w * 0.02),
                                                                  Text('Tahrirlash',
                                                                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: w * 0.04)),
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                _dateController.text = _getController.bookingBusinessGetList.value.res![index].date!;
                                                                _timeController.text = _getController.bookingBusinessGetList.value.res![index].time!;
                                                                showBottomSheetList(context,_getController.bookingBusinessGetList.value.res![index].id);
                                                              },
                                                            ),
                                                            PopupMenuItem(
                                                              child: Row(
                                                                children: [
                                                                  HeroIcon(
                                                                    HeroIcons.trash,
                                                                    size: w * 0.05,
                                                                    color: Colors.red,
                                                                  ),
                                                                  SizedBox(width: w * 0.02),
                                                                  Text('O`chirish',
                                                                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: w * 0.04)),
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                Loading.showLoading(context);
                                                                ApiController().deleteClientBooking(_getController.bookingBusinessGetList.value.res![index].id!,context).then((value) => {
                                                                  if (value){
                                                                    ApiController().bookingClientGetList(''),
                                                                  },
                                                                  Navigator.pop(context)
                                                                });

                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: h * 0.01),
                                                        Text(
                                                          _getController.bookingBusinessGetList.value.res![index].date!,
                                                          style: TextStyle(
                                                            fontSize: w * 0.035,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.orange,
                                                          ),
                                                        ),
                                                        SizedBox(height: h * 0.01),
                                                        Text(
                                                          _getController.bookingBusinessGetList.value.res![index].time!,
                                                          style: TextStyle(
                                                            fontSize: w * 0.035,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.orange,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                                      onTap: () {
                                                        _launchPhone(context, _getController.bookingBusinessGetList.value.res![index].phoneNumber!);
                                                      },
                                                      child:Container(
                                                        padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.005),
                                                        margin: EdgeInsets.only(left: w * 0.03, bottom: h * 0.01),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.green,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            HeroIcon(
                                                              HeroIcons.phone,
                                                              size: w * 0.035,
                                                              color: Colors.white,
                                                            ),
                                                            SizedBox(width: w * 0.01),
                                                            Text(
                                                              'Qo`ng`iroq qilish',
                                                              style: TextStyle(
                                                                fontSize: w * 0.035,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                    ));
                              },
                            ),
                          )),
                          Obx(() => _getController.bookingBusinessGetList.value.res == null || _getController.bookingBusinessGetList.value.res!.isEmpty
                              ? Center(child: Text('Ma`lumot mavjud emas', style: TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w500, color: Colors.black),))
                              : SizedBox(
                            height: h * 0.68,
                            child: ListView.builder(
                              itemCount: _getController.bookingBusinessGetList.value.res!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
                                    child: Card(
                                      color: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadowColor: Colors.grey.withOpacity(0.5),
                                      elevation: 4,
                                      child: InkWell(
                                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                                          onTap: () {},
                                          child:Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
                                                    width: w * 0.15,
                                                    height: w * 0.15,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(100),
                                                      image: DecorationImage(
                                                        image: NetworkImage(_getController.bookingBusinessGetList.value.res![index].photoUrl!),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.43,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: h * 0.02),
                                                        Text(
                                                          '${_getController.bookingBusinessGetList.value.res![index].fistName!} ${_getController.bookingBusinessGetList.value.res![index].lastName!}',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: w * 0.04,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        SizedBox(height: h * 0.02),
                                                        Text(
                                                          _getController.bookingBusinessGetList.value.res![index].userName!,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: w * 0.04,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(height: h * 0.01),
                                                        Row(
                                                          children: [
                                                            HeroIcon(
                                                              HeroIcons.phone,
                                                              size: w * 0.035,
                                                              color: Colors.grey,
                                                            ),
                                                            SizedBox(width: w * 0.01),
                                                            Text(
                                                              _getController.bookingBusinessGetList.value.res![index].phoneNumber!,
                                                              style: TextStyle(
                                                                fontSize: w * 0.035,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Expanded(child: SizedBox()),
                                                  Container(
                                                    margin: EdgeInsets.only(right: w * 0.03, top: h * 0.01, bottom: h * 0.01),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            Toast.showToast(context, '${_getController.bookingBusinessGetList.value.res![index].fistName ?? ''} ${_getController.bookingBusinessGetList.value.res![index].lastName ?? ''} qabulingizga soat: ${_getController.bookingBusinessGetList.value.res![index].time ?? ''} da keladi.', Colors.blue, Colors.white);
                                                          },
                                                          icon: HeroIcon(
                                                            HeroIcons.informationCircle,
                                                            size: w * 0.06,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(height: h * 0.01),
                                                        Text(
                                                          _getController.bookingBusinessGetList.value.res![index].date!,
                                                          style: TextStyle(
                                                            fontSize: w * 0.035,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.orange,
                                                          ),
                                                        ),
                                                        SizedBox(height: h * 0.01),
                                                        Text(
                                                          _getController.bookingBusinessGetList.value.res![index].time!,
                                                          style: TextStyle(
                                                            fontSize: w * 0.035,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.orange,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                                      onTap: () {
                                                        _launchPhone(context, _getController.bookingBusinessGetList.value.res![index].phoneNumber!);
                                                      },
                                                      child:Container(
                                                        padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.005),
                                                        margin: EdgeInsets.only(left: w * 0.03, bottom: h * 0.01),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.green,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            HeroIcon(
                                                              HeroIcons.phone,
                                                              size: w * 0.035,
                                                              color: Colors.white,
                                                            ),
                                                            SizedBox(width: w * 0.01),
                                                            Text(
                                                              'Qo`ng`iroq qilish',
                                                              style: TextStyle(
                                                                fontSize: w * 0.035,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                    ));
                              },
                            ),
                          )),
                        ]
                    ),
                  ),
                ],
              ),
            )
        ),
        Positioned(
          top: h * 0.03,
          child: SizedBox(
            width: w,
            height: h * 0.06,
            child: Container(
              constraints: BoxConstraints.expand(height: h * 0.06),
              margin: EdgeInsets.symmetric(horizontal: w * 0.05),
              padding: EdgeInsets.all(w * 0.015),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: TabBar(
                onTap: (index) {
                  _onTap(index,context);
                },
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                controller: _tabController,
                labelStyle: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.white, // Selected text color
                ),
                unselectedLabelColor: Colors.blue, // Unselected text color
                indicator: BoxDecoration(
                  color: Colors.blue, // Background color for the selected tab
                  borderRadius: BorderRadius.circular(10),
                ),
                tabs: [
                  Tab(
                    child: SizedBox(
                      width: w * 0.6,
                      child: Center(
                        child: Text(
                          'Eslatmalar',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      width: w * 0.6,
                      child: Center(
                        child: Text(
                          'Mijozlaringiz',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    )
        : Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: h * 0.12,
            width: w,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    width: w,
                    height: h * 0.07,
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  top: h * 0.1,
                  child: Container(
                    width: w,
                    height: h * 0.05,
                    color: Colors.grey[50],
                  ),
                ),
                Positioned(
                  top: h * 0.04,
                  width: w,
                  child: Container(
                      width: w,
                      height: h * 0.06,
                      margin: EdgeInsets.symmetric(horizontal: w * 0.05),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Eslatmalar',
                          style: TextStyle(
                            fontSize: w * 0.05,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: h * 0.06,
            width: w,
            margin: EdgeInsets.only(bottom: h * 0.02, left: w * 0.05, right: w * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    _scrollController.animateTo(_scrollController.offset - w * 0.3, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,);
                  },
                  child: SizedBox(
                    width: w * 0.1,
                    child: Center(
                      child: HeroIcon(
                        HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: w * 0.06,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _getController.changeSelectedDay(index);
                          if (index == 3) {
                            showDialog(context: context, builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              content: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.3,
                                child: CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  dateOrder: DatePickerDateOrder.ymd,
                                  onDateTimeChanged: (DateTime newdate) {
                                    _dateController.text = '${newdate.day < 10 ? '0${newdate.day}' : newdate.day}/${newdate.month < 10 ? '0${newdate.month}' : newdate.month}/${newdate.year}';
                                  },
                                  minimumYear: 1900,
                                  maximumYear: 2200,
                                  use24hFormat: true,
                                  mode: CupertinoDatePickerMode.date,
                                ),
                              ),

                              title: Text('Kunni tanlang',
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Bekor qilish',
                                      style: TextStyle(
                                        fontSize: w * 0.035,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (_tabController.index == 0) {
                                        _getController.clearBookingBusinessGetList();
                                        ApiController().bookingClientGetList(_dateController.text);
                                      } else {
                                        _getController.clearBookingBusinessGetList();
                                        ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, _dateController.text);
                                      }
                                    },
                                    child: Text('Ok',
                                      style: TextStyle(
                                        fontSize: w * 0.035,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue,
                                      ),
                                    )
                                ),
                              ],
                            ));
                          }
                          _dateController.text = index == 0
                              ? ''
                              : index == 1
                              ? '${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}/${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}/${DateTime.now().year}'
                              : index == 2
                              ? '${DateTime.now().day + 1 < 10 ? '0${DateTime.now().day + 1}' : DateTime.now().day + 1}/${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}/${DateTime.now().year}'
                              : '';

                          Loading.showLoading(context);
                          if (_tabController.index == 0) {
                            _getController.clearBookingBusinessGetList();
                            ApiController().bookingClientGetList(_dateController.text).then((value) => {
                              Loading.hideLoading(context)
                            });
                          } else {
                            _getController.clearBookingBusinessGetList();
                            ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, _dateController.text).then((value) => {
                              Loading.hideLoading(context)
                            });
                          }
                        },
                        child:Obx(()=>  Container(
                          margin: EdgeInsets.symmetric(horizontal: w * 0.015, vertical: h * 0.01),
                          padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.005),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: _getController.selectedDay.value == index ? Colors.blue : Colors.grey,
                            ),
                            color: _getController.selectedDay.value == index ? Colors.blue : Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              index == 0
                                  ? 'Hamma mijozlar'
                                  : index == 1
                                  ? 'Bugungi mijozlar'
                                  : index == 2
                                  ? 'Keyingi mijozlar'
                                  : 'Tanlangan mijozlar',
                              style: TextStyle(
                                fontSize: w * 0.035,
                                color: _getController.selectedDay.value == index ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    _scrollController.animateTo(_scrollController.offset + w * 0.3, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut,);
                  },
                  child: SizedBox(
                    width: w * 0.1,
                    child: Center(
                      child: HeroIcon(
                        HeroIcons.chevronRight,
                        color: Colors.black,
                        size: w * 0.06,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(() => _getController.bookingBusinessGetList.value.res == null || _getController.bookingBusinessGetList.value.res!.isEmpty
              ? SizedBox(height: h * 0.63, width: w, child: Center(child: Text('Ma`lumotlar mavjud emas', style: TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w500, color: Colors.black),)),
          ) : SizedBox(
            height: h * 0.63,
            child: ListView.builder(
              itemCount: _getController.bookingBusinessGetList.value.res!.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.grey.withOpacity(0.5),
                      elevation: 4,
                      child: InkWell(
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                          onTap: () {},
                          child:Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
                                    width: w * 0.15,
                                    height: w * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                        image: NetworkImage(_getController.bookingBusinessGetList.value.res![index].photoUrl!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: w * 0.43,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: h * 0.02),
                                        Text(
                                          '${_getController.bookingBusinessGetList.value.res![index].fistName!} ${_getController.bookingBusinessGetList.value.res![index].lastName!}',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: h * 0.02),
                                        Text(
                                          _getController.bookingBusinessGetList.value.res![index].userName!,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: h * 0.01),
                                        Row(
                                          children: [
                                            HeroIcon(
                                              HeroIcons.phone,
                                              size: w * 0.035,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(width: w * 0.01),
                                            Text(
                                              _getController.bookingBusinessGetList.value.res![index].phoneNumber!,
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Container(
                                    margin: EdgeInsets.only(right: w * 0.03, top: h * 0.01, bottom: h * 0.01),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        PopupMenuButton(
                                          icon: const Icon(Icons.more_vert),
                                          surfaceTintColor: Colors.white,
                                          color: Colors.white,
                                          elevation: 4,
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: Row(
                                                children: [
                                                  HeroIcon(HeroIcons.pencil, size: w * 0.05, color: Colors.blue),
                                                  SizedBox(width: w * 0.02),
                                                  Text('Tahrirlash', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: w * 0.04)),
                                                ],
                                              ),
                                              onTap: () {
                                                _dateController.text = _getController.bookingBusinessGetList.value.res![index].date!;
                                                _timeController.text = _getController.bookingBusinessGetList.value.res![index].time!;
                                                showBottomSheetList(context,_getController.bookingBusinessGetList.value.res![index].id);
                                              },
                                            ),
                                            PopupMenuItem(
                                              child: Row(
                                                children: [
                                                  HeroIcon(HeroIcons.trash, size: w * 0.05, color: Colors.red),
                                                  SizedBox(width: w * 0.02),
                                                  Text('O`chirish', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: w * 0.04)),
                                                ],
                                              ),
                                              onTap: () {
                                                Loading.showLoading(context);
                                                ApiController().deleteClientBooking(_getController.bookingBusinessGetList.value.res![index].id!,context).then((value) => {
                                                  if (value){
                                                    ApiController().bookingClientGetList(''),
                                                  },
                                                  Navigator.pop(context)
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: h * 0.01),
                                        Text(
                                          _getController.bookingBusinessGetList.value.res![index].date!,
                                          style: TextStyle(fontSize: w * 0.035, fontWeight: FontWeight.w500, color: Colors.orange),
                                        ),
                                        SizedBox(height: h * 0.01),
                                        Text(_getController.bookingBusinessGetList.value.res![index].time!, style: TextStyle(fontSize: w * 0.035, fontWeight: FontWeight.w500, color: Colors.orange),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                      onTap: () {
                                        _launchPhone(context, _getController.bookingBusinessGetList.value.res![index].phoneNumber!);
                                      },
                                      child:Container(
                                        padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.005),
                                        margin: EdgeInsets.only(left: w * 0.03, bottom: h * 0.01),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.green),
                                        child: Row(
                                          children: [
                                            HeroIcon(HeroIcons.phone, size: w * 0.035, color: Colors.white),
                                            SizedBox(width: w * 0.01),
                                            Text('Qo`ng`iroq qilish', style: TextStyle(fontSize: w * 0.035, fontWeight: FontWeight.w500, color: Colors.white),),
                                          ],
                                        ),
                                      )
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    ));
              },
            ),
          )),
        ],
      ),
    ));
  }
}