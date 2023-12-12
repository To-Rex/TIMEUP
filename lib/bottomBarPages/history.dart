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
                'Loading...',
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

  showBottomSheetList(context,id) {
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
                Text('Bookingni tahrirlash',
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
                        child: Text('Kunni va vaqtni belgilang',
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
                                    _dateController.text =
                                    '${value!.day < 10 ? '0${value.day}' : value.day}/${value.month < 10 ? '0${value.month}' : value.month}/${value.year}',
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
                                        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                    initialEntryMode:
                                    TimePickerEntryMode.input,
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
                            ApiController().updateBooking(id,_dateController.text,_timeController.text,context).then((value) => {
                              if (value){
                                if (_getController.meUsers.value.res?.business == null) {
                                  ApiController().bookingClientGetList(''),
                                  Navigator.pop(context)
                                } else {
                                  if (_getController.nextPagesUserDetails.value == 1) {
                                    ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, ''),
                                    Navigator.pop(context)
                                  } else {
                                    ApiController().bookingClientGetList(''),
                                    Navigator.pop(context)
                                  }
                                }
                              }else{
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
                                        Text('Xatolik yuz berdi',
                                          style: TextStyle(
                                            fontSize: w * 0.05,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red,
                                          ),
                                        ),
                                        SizedBox(height: h * 0.02),
                                        Text('Iltimos qayta urinib ko`ring',
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
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            backgroundColor: Colors.blue,
                                          ),
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
                          child: Text('O`zgarishlarni saqlash',
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
                      style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent),),
                      onPressed: () {
                        pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease,);
                      },
                      child: Text('Eslatma',
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
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                ),
                                onPressed: () {
                                  pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                },
                                child: Text('Eslatma',
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
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                ),
                                onPressed: () {
                                  pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease,);
                                },
                                child: Text('Eslatma',
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
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                ),
                                onPressed: () {
                                  pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                },
                                child: Text('Sizning Mijozlaringiz',
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
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                ),
                                onPressed: () {
                                  pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                },
                                child: Text('Sizning Mijozlaringiz',
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
                    showDatePicker(context: context,
                      initialDate: _dateController.text == ''
                          ? DateTime.now()
                          : DateTime.parse('${_dateController.text.substring(6, 10)}-${_dateController.text.substring(3, 5)}-${_dateController.text.substring(0, 2)}'),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2025),
                    ).then((value) => {
                          _dateController.text = '${value!.day < 10 ? '0${value.day}' : value.day}/${value.month < 10 ? '0${value.month}' : value.month}/${value.year}',
                          if (_getController.meUsers.value.res?.business == null){
                              ApiController().bookingClientGetList(_dateController.text)
                          } else {
                              if (_getController.nextPagesUserDetails.value == 1){
                                  ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, _dateController.text)
                              } else {
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
                      height: h * 0.64,
                      child: PageView(
                        onPageChanged: (index) {
                          showLoadingDialog(context, w);
                          _getController.nextPagesUserDetails.value = index;
                          _dateController.text = '';
                          if (_getController.meUsers.value.res?.business == null) {
                            ApiController().bookingClientGetList('').then((value) => Navigator.pop(context));
                          } else {
                            if (_getController.nextPagesUserDetails.value == 1) {
                              ApiController().bookingBusinessGetList(_getController.meUsers.value.res?.business?.id, '').then((value) => Navigator.pop(context));
                            } else {
                              ApiController().bookingClientGetList('').then((value) => Navigator.pop(context));
                            }
                          }
                        },
                        controller: pageController,
                        children: [
                          SizedBox(
                            child: Obx(() => _getController.bookingBusinessGetList.value.res!.isEmpty
                                ? const Center(child: Text('Ma`lumot mavjud emas'))
                                : SizedBox(
                                    height: h * 0.68,
                                    child: ListView.builder(
                                      itemCount: _getController.bookingBusinessGetList.value.res!.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(width: w * 0.03),
                                            _getController.bookingBusinessGetList.value.res![index].photoUrl == null
                                                ? CircleAvatar(
                                                    radius: w * 0.08,
                                                    backgroundImage: const AssetImage('assets/images/doctor.png',),
                                                  )
                                                : CircleAvatar(
                                                    radius: w * 0.08,
                                                    backgroundImage: NetworkImage(_getController.bookingBusinessGetList.value.res![index].photoUrl!,),
                                                  ),
                                            SizedBox(width: w * 0.03),
                                            SizedBox(
                                              width: w * 0.6,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _getController.bookingBusinessGetList.value.res![index].userName!,
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
                                            const Expanded(child: SizedBox()),
                                            PopupMenuButton(
                                              icon: const Icon(Icons.more_vert),
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
                                                      Text('Edit', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: w * 0.04)),
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
                                                      Text('Delete', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: w * 0.04)),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    showLoadingDialog(context, w);
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
                                          ],
                                        );
                                      },
                                    ),
                                  )),
                          ),
                          SizedBox(
                            child: Obx(() => _getController.bookingBusinessGetList.value.res!.isEmpty
                                ? const Center(child: Text('Ma`lumot mavjud emas'),
                            ) : SizedBox(
                              height: h * 0.68,
                              child: ListView.builder(
                                itemCount: _getController.bookingBusinessGetList.value.res!.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(width: w * 0.03),
                                      _getController.bookingBusinessGetList.value.res![index].photoUrl == null
                                          ? CircleAvatar(
                                        radius: w * 0.08,
                                        backgroundImage: const AssetImage('assets/images/doctor.png',),
                                      ) : CircleAvatar(
                                        radius: w * 0.08,
                                        backgroundImage: NetworkImage(_getController.bookingBusinessGetList.value.res![index].photoUrl!,),
                                      ),
                                      SizedBox(width: w * 0.03),
                                      SizedBox(
                                        width: w * 0.7,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _getController.bookingBusinessGetList.value.res![index].userName!,
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            //User profession
                                            Text('${_getController.bookingBusinessGetList.value.res![index].fistName!} ''${_getController.bookingBusinessGetList.value.res![index].lastName!}',
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
                                                SizedBox(width: w * 0.01,),
                                                Text(_getController.bookingBusinessGetList.value.res![index].phoneNumber!,
                                                  style: TextStyle(
                                                    fontSize: w * 0.04,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text('Mijozingiz navbati: ${_getController.bookingBusinessGetList.value.res![index].date!} ${_getController.bookingBusinessGetList.value.res![index].time!}',
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
                                      //const Expanded(child: SizedBox()),
                                      /*PopupMenuButton(
                                        icon: const Icon(Icons.more_vert),
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
                                                Text('Edit', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: w * 0.04)),
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
                                                Text('Delete', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: w * 0.04)),
                                              ],
                                            ),
                                            onTap: () {
                                              showLoadingDialog(context, w);
                                              ApiController().deleteClientBooking(_getController.bookingBusinessGetList.value.res![index].id!,context).then((value) => {
                                                if (value){
                                                  ApiController().bookingClientGetList(''),
                                                },
                                                Navigator.pop(context)
                                              });
                                              },
                                          ),
                                        ],
                                      ),*/
                                    ],
                                  );
                                  },
                              ),
                            )),
                          ),
                        ],
                      )
            ) : const Center(
              child: CircularProgressIndicator(),
            ),),
          if (_getController.meUsers.value.res?.business == null)
            Obx(() => _getController.bookingBusinessGetList.value.res != null
                  ? SizedBox(
                      child: Obx(
                        () => _getController.bookingBusinessGetList.value.res!.isEmpty
                            ? const Center(child: Text('Ma`lumot mavjud emas'),)
                            : SizedBox(
                                height: h * 0.68,
                                child: ListView.builder(
                                  itemCount: _getController.bookingBusinessGetList.value.res!.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(width: w * 0.03),
                                        _getController.bookingBusinessGetList.value.res![index].photoUrl == null
                                            ? CircleAvatar(
                                                radius: w * 0.08,
                                                backgroundImage: const AssetImage('assets/images/doctor.png',),
                                              )
                                            : CircleAvatar(
                                                radius: w * 0.08,
                                                backgroundImage: NetworkImage(
                                                  _getController.bookingBusinessGetList.value.res![index].photoUrl!,
                                                ),
                                              ),
                                        SizedBox(width: w * 0.03),
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
                                              Text('${_getController.bookingBusinessGetList.value.res![index].fistName!} ${_getController.bookingBusinessGetList.value.res![index].lastName!}',
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
                                        const Expanded(child: SizedBox()),
                                        PopupMenuButton(
                                          icon: const Icon(Icons.more_vert),
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
                                                  Text('Edit', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: w * 0.04)),
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
                                                  Text('Delete', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: w * 0.04)),
                                                ],
                                              ),
                                              onTap: () {
                                                ApiController().deleteClientBooking(_getController.bookingBusinessGetList.value.res![index].id!,context);
                                              },
                                            ),
                                          ],
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
                    )),
        ],
      ),
    );
  }
}
