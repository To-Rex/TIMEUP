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
  final PageController pageSheetController = PageController();
  final TextEditingController _timeController = TextEditingController();

  //tabController = TabController(length: 2, vsync: this);
  late TabController _tabController;

  showLoadingDialog(BuildContext context, w) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        surfaceTintColor: Colors.white,
        content: SizedBox(
          width: w * 0.1,
          height: w * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              SizedBox(
                width: w * 0.1,
                height: w * 0.1,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: Colors.white,
                  strokeWidth: 2,
                ),
              ),
              SizedBox(
                width: w * 0.07,
              ),
              Text(
                'Iltimos kuting...',
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  showBottomSheetList(context, id) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      isDismissible: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(w * 0.05),
          topRight: Radius.circular(w * 0.05),
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
                            showLoadingDialog(context, w);
                            ApiController().updateBooking(id, _dateController.text, _timeController.text, context).then((value) => {
                                      if (value){
                                        if (_getController.meUsers.value.res?.business == null){
                                              ApiController().bookingClientGetList(''),
                                              Navigator.pop(context)
                                            } else {
                                              if (_getController.nextPagesUserDetails.value == 1){
                                                  ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, ''),
                                                  Navigator.pop(context)
                                                } else {
                                                  ApiController().bookingClientGetList(''),
                                                  Navigator.pop(context)
                                                }
                                            }
                                        } else {
                                          Navigator.pop(context),
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

  _onTap(int index) {
    _getController.nextPagesUserDetails.value = index;
    if (_getController.meUsers.value.res?.business == null) {
      ApiController().bookingClientGetList('');
    } else {
      ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, '');
    }
  }

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
      //ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, '');
    }
    _tabController = TabController(length: 2, vsync: Navigator.of(context));
    _tabController.addListener(() {
      print(_tabController.index);
    });
    return Stack(
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
                        Expanded(child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.005),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Text(
                                'Bugungi mijozlar',
                                style: TextStyle(
                                  fontSize: w * 0.035,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: w * 0.03),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.005),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Text(
                                'Keyingi mijozlar',
                                style: TextStyle(
                                  fontSize: w * 0.035,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        )),
                        InkWell(
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
                      controller: _tabController,
                      children: [
                        Container(
                          color: Colors.red,
                          width: w,
                        ),
                        Container(
                          color: Colors.blue,
                          width: w,
                        ),
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
                onTap: _onTap,
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
                    child: Container(
                      width: w * 0.6,
                      child: Center(
                        child: Text(
                          'Obunachilar',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: w * 0.6,
                      child: Center(
                        child: Text(
                          'Dostlar',
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
    );
  }
}
