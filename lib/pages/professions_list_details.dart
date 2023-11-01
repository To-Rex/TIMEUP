import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import '../api/api_controller.dart';
import '../elements/functions.dart';
import '../res/getController.dart';

class ProfessionsListDetails extends StatelessWidget {
  ProfessionsListDetails({Key? key}) : super(key: key);

  final GetController _getController = Get.put(GetController());
  final PageController pageController = PageController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  showBottomSheet(context){
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: h * 0.02),
              const Center(
                child: Text('Kunni va vaqtni belgilang',
                    style: TextStyle(
                      fontSize: 20,
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
                        ).then((value) =>
                        {
                          _dateController.text = '${value!.day < 10 ? '0${value.day}' : value.day}/${value.month < 10 ? '0${value.month}' : value.month}/${value.year}',
                        });
                      },
                      child: HeroIcon(
                        HeroIcons.calendar,
                        color: Colors.black,
                        size: w * 0.06,
                      )
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
                        ).then((value) =>
                            _timeController.text = '${value!.hour < 10 ? '0${value.hour}' : value.hour}:${value.minute < 10 ? '0${value.minute}' : value.minute}');
                      },
                      child: HeroIcon(
                        HeroIcons.clock,
                        color: Colors.black,
                        size: w * 0.06,
                      )
                    ),
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
                    ApiController().createBookingClientCreate(
                      _getController.getProfileById.value.res!.id ?? 0,
                      _dateController.text,
                      _timeController.text,
                    ).then((value) => {
                      if(value == true){
                        ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value,'').then((value) => _getController.changeBookingBusinessGetList(value)),
                        Navigator.pop(context),
                        Toast.showToast(context, 'Booking yaratildi', Colors.green, Colors.white),
                      }else{
                        Toast.showToast(context, 'Error', Colors.red, Colors.white),
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Jonatish',
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
        );
      },
    );
  }

  showBottomSheetList(context){
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
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
              )
          ),
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
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2025),
                        ).then((value) => {
                          _getController.bookingBusinessGetList.value.res!.clear(),
                          _dateController.text = '${value!.day < 10 ? '0${value.day}' : value.day}/${value.month < 10 ? '0${value.month}' : value.month}/${value.year}',
                          ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value,'${value.day}/${value.month}/${value.year}').then((value) => _getController.changeBookingBusinessGetList(value)),
                        });
                      },
                      /*child: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),*/
                      child: HeroIcon(
                        HeroIcons.calendar,
                        color: Colors.black,
                        size: w * 0.06,
                      )
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
              //list bookingBusinessGetList
              Expanded(child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                child: Obx(() => _getController.bookingBusinessGetList.value.res == null
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _getController.bookingBusinessGetList.value.res!.length,
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
                                    fontSize: w * 0.04, fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: w * 0.7,
                                child: Text(
                                  'Ushbu mijoz'' ${_getController.bookingBusinessGetList.value.res![index].date!.replaceAll('/', '-')} ''${_getController.bookingBusinessGetList.value.res![index].time!} keladi',
                                  style: TextStyle(
                                    fontSize:
                                    w * 0.04,
                                    fontWeight:
                                    FontWeight
                                        .w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      );
                    })),
              )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value,'').then((value) => _getController.changeBookingBusinessGetList(value));
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(h * 0.1),
          child: Container(
            margin: EdgeInsets.only(top: h * 0.03, bottom: h * 0.01),
            child: Row(
              children: [
                SizedBox(
                  width: w * 0.04,
                ),
                Image(
                  image: const AssetImage('assets/images/text.png'),
                  width: w * 0.2,
                  height: h * 0.05,
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, size: w * 0.05),
            ),
            title: Obx(() => _getController.getProfileById.value.res == null
                ? Text(
                    'No data',
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Text(
                    _getController.getProfileById.value.res!.userName ?? '',
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            centerTitle: true,
          ),
          Obx(() => _getController.getProfileById.value.res == null
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  child:
                      _getController.getProfileById.value.res!.photoUrl == null
                        ? Row(
                          children: [
                             SizedBox(width: w * 0.04),
                             const CircleAvatar(
                              backgroundImage:
                               AssetImage('assets/images/doctor.png'),
                            ),
                          ],
                         ) : Row(
                              children: [
                                SizedBox(width: w * 0.04),
                                CircleAvatar(
                                  radius: w * 0.18,
                                  backgroundImage: NetworkImage(
                                    "http://${_getController.getProfileById.value.res!.photoUrl}",
                                  ),
                                ),
                              ],
                            ))),
          SizedBox(height: h * 0.02),
          Container(
              margin: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => _getController.getProfileById.value.res == null
                      ? const SizedBox()
                      : Text("${_getController.getProfileById.value.res!.fistName} ${_getController.getProfileById.value.res!.lastName}", style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.w500,),)),
                  SizedBox(height: h * 0.01,),
                  Row(
                    children: [
                      Obx(() => _getController.getProfileById.value.res == null
                          ? const SizedBox()
                          : Text(_getController.getProfileById.value.res!.categoryName ?? '',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[500],
                              ),
                            )),
                      SizedBox(width: w * 0.02),
                      Obx(() => _getController.getProfileById.value.res == null
                          ? const SizedBox()
                          : Text("${_getController.getProfileById.value.res!.experience} yillik ish tajribasi",
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                    ],
                  ),
                  SizedBox(height: h * 0.01,),
                  Row(
                    children: [
                      HeroIcon(
                        HeroIcons.phone,
                        color: Colors.blue,
                        size: w * 0.05,),
                      SizedBox(width: w * 0.02,),
                      Obx(() => _getController.getProfileById.value.res == null
                          ? const SizedBox()
                          : Text(_getController.getProfileById.value.res!.phoneNumber ?? '',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                    ],
                  ),
                  SizedBox(height: h * 0.01,),
                  Row(
                    children: [
                      HeroIcon(
                        HeroIcons.mapPin,
                        color: Colors.blue,
                        size: w * 0.05,),
                      SizedBox(width: w * 0.02,),
                      Obx(() => _getController.getProfileById.value.res == null
                          ? const SizedBox()
                          : Text(_getController.getProfileById.value.res!.address ?? '',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                    ],
                  ),
                  SizedBox(height: h * 0.01),
                  Row(
                    children: [
                      HeroIcon(
                        HeroIcons.briefcase,
                        color: Colors.blue,
                        size: w * 0.05,),
                      SizedBox(
                        width: w * 0.02,
                      ),
                      Obx(() => _getController.getProfileById.value.res == null
                          ? const SizedBox()
                          : Text(
                              _getController
                                      .getProfileById.value.res!.officeName ??
                                  '',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: w * 0.2,
                        height: h * 0.05,
                        child: Obx(
                          () => _getController.nextPagesUserDetails.value == 0
                              ? ElevatedButton(
                                  onPressed: () {
                                    _getController.nextPagesUserDetails.value = 0;
                                    pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),),
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Text('Bio',
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    _getController.nextPagesUserDetails.value = 0;
                                    pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),),
                                    backgroundColor: Colors.grey,
                                  ),
                                  child: Text('Bio',
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                          height: h * 0.05,
                          child: Obx(
                            () => _getController.nextPagesUserDetails.value == 1
                                ? ElevatedButton(
                                    onPressed: () {
                                      _getController.nextPagesUserDetails.value = 1;
                                      pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),),
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: Text('Ish jadvali',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      _getController.nextPagesUserDetails.value = 1;
                                      pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),),
                                      backgroundColor: Colors.grey,
                                    ),
                                    child: Text('Ish jadvali',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          )),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                          height: h * 0.05,
                          child: Obx(() => _getController.nextPagesUserDetails.value == 2
                              ? SizedBox(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _getController.nextPagesUserDetails.value = 2;
                                      pageController.animateToPage(2, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),),
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: Text('Booking',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _getController.nextPagesUserDetails.value = 2;
                                      pageController.animateToPage(2, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),),
                                      backgroundColor: Colors.grey,
                                    ),
                                    child: Text('Booking',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ))),
                      const Expanded(child: SizedBox()),
                      Container(
                        alignment: Alignment.center,
                        width: w * 0.1,
                        height: h * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            ApiController().follow(_getController.getProfileById.value.res!.id ?? 0).then((value) => {
                                      if (value.status == true){
                                          Toast.showToast(context, 'Followed', Colors.green, Colors.white),
                                        } else {
                                          Toast.showToast(context, 'Error', Colors.red, Colors.white),
                                        }
                                    });
                          },
                          icon: HeroIcon(
                            HeroIcons.userPlus,
                            color: Colors.white,
                            size: w * 0.1,
                          )
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  SizedBox(height: h * 0.02,),
                  SizedBox(
                    width: w,
                    height: h * 0.3,
                    child: PageView(
                      //physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        _getController.nextPagesUserDetails.value = index;
                      },
                      controller: pageController,
                      children: [
                        Container(
                          width: w,
                          padding: EdgeInsets.only(
                              left: w * 0.02,
                              right: w * 0.02,
                              bottom: h * 0.01),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Obx(
                            () =>
                                _getController.getProfileById.value.res == null
                                    ? const SizedBox()
                                    : Text(_getController.getProfileById.value.res!.bio ?? '',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                          ),
                        ),
                        SizedBox(
                          width: w,
                          height: h * 0.22,
                          child: Obx(
                            () => _getController.bookingBusinessGetList.value.res == null
                                ? const SizedBox()
                                : Container(
                                    width: w,
                                    padding: EdgeInsets.only(
                                        left: w * 0.02,
                                        right: w * 0.02,
                                        top: h * 0.01),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: Colors.grey,),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: h * 0.23,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: _getController.bookingBusinessGetList.value.res!.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: w * 0.08,
                                                          child: Text('${index + 1}',
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
                                                            ' ${_getController.bookingBusinessGetList.value.res![index].date!.replaceAll('/', '-')} '
                                                            '${_getController.bookingBusinessGetList.value.res![index].time!} keladi',
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
                                            const Expanded(child: SizedBox()),
                                            SizedBox(
                                              height: h * 0.05,
                                              child: TextButton(
                                                onPressed: () {
                                                  showBottomSheetList(context);
                                                },
                                                child: Text('Barchasini ko\'rish',
                                                  style: TextStyle(
                                                    fontSize: w * 0.04,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.blue,
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
                        Container(
                            width: w,
                            padding: EdgeInsets.only(
                                left: w * 0.02,
                                right: w * 0.02,
                                bottom: h * 0.01),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  showBottomSheet(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),),
                                  backgroundColor: Colors.blue,
                                ),
                                child: Text('Vaqtni tanlang',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      )),
    );
  }
}
