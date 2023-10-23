import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                        ).then((value) => _dateController.text = '${value!.day}/${value.month}/${value.year}');
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
                        ).then((value) => _timeController.text = '${value!.hour}:${value.minute}');
                      },
                      child: const Icon(
                        Icons.access_time,
                        color: Colors.grey,
                      ),
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
              //Jonatish
              SizedBox(
                width: w * 0.9,
                height: h * 0.07,
                child: ElevatedButton(
                  onPressed: () {
                    ApiController().createBookingClientCreate(
                      _getController.getProfileById.value.res!.id ?? 0,
                      _dateController.text,
                      _timeController.text,
                    );
                    ApiController().bookingBusinessGetList(
                        _getController.bookingBusinessGetListByID.value
                    ).then((value) => _getController.changeBookingBusinessGetList(value));
                    //close bottom sheet
                    Navigator.pop(context);
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
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        ).then((value) => _dateController.text = '${value!.day}/${value.month}/${value.year}');
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
              //list bookingBusinessGetList
              Expanded(child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _getController
                        .bookingBusinessGetList
                        .value
                        .res!
                        .length,
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
                                    fontSize:
                                    w * 0.04,
                                    fontWeight:
                                    FontWeight
                                        .w500,
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
                    }),
              ))

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
    ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value).then((value) => _getController.changeBookingBusinessGetList(value));
    //ApiController().bookingBusinessGetList(26).then((value) => _getController.changeBookingBusinessGetList(value));
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
                          ? const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/doctor.png'),
                            )
                          : Row(
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
          SizedBox(
            height: h * 0.02,
          ),
          Container(
              margin: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => _getController.getProfileById.value.res == null
                      ? const SizedBox()
                      : Text(
                          "${_getController.getProfileById.value.res!.fistName} ${_getController.getProfileById.value.res!.lastName}",
                          style: TextStyle(
                            fontSize: w * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Row(
                    children: [
                      Obx(() => _getController.getProfileById.value.res == null
                          ? const SizedBox()
                          : Text(
                              _getController
                                      .getProfileById.value.res!.categoryName ??
                                  '',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                                //bold
                                color: Colors.grey[500],
                              ),
                            )),
                      SizedBox(
                        width: w * 0.02,
                      ),
                      Obx(() => _getController.getProfileById.value.res == null
                          ? const SizedBox()
                          : Text(
                              "${_getController.getProfileById.value.res!.experience} yillik ish tajribasi",
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_android,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: w * 0.02,
                      ),
                      Obx(() => _getController.getProfileById.value.res == null
                          ? const SizedBox()
                          : Text(
                              _getController
                                      .getProfileById.value.res!.phoneNumber ??
                                  '',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: w * 0.02,
                      ),
                      Obx(() => _getController.getProfileById.value.res == null
                          ? const SizedBox()
                          : Text(
                              _getController
                                      .getProfileById.value.res!.address ??
                                  '',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.work,
                        color: Colors.blue,
                      ),
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
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Text(
                                    'Bio',
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    _getController.nextPagesUserDetails.value =
                                        0;
                                    pageController.animateToPage(0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    backgroundColor: Colors.grey,
                                  ),
                                  child: Text(
                                    'Bio',
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
                                      _getController
                                          .nextPagesUserDetails.value = 1;
                                      pageController.animateToPage(1,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: Text(
                                      'Ish jadvali',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      _getController
                                          .nextPagesUserDetails.value = 1;
                                      pageController.animateToPage(1,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      backgroundColor: Colors.grey,
                                    ),
                                    child: Text(
                                      'Ish jadvali',
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
                                      _getController
                                          .nextPagesUserDetails.value = 2;
                                      pageController.animateToPage(2,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: Text(
                                      'Booking',
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
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      backgroundColor: Colors.grey,
                                    ),
                                    child: Text(
                                      'Booking',
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
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            ApiController()
                                .follow(_getController.getProfileById.value.res!.id ?? 0)
                                .then((value) => {
                                      if (value.status == true)
                                        {
                                          Toast.showToast(context, 'Followed',
                                              Colors.green, Colors.white),
                                        }
                                      else
                                        {
                                          Toast.showToast(context, 'Error',
                                              Colors.red, Colors.white),
                                        }
                                    });
                          },
                          icon: Icon(
                            size: w * 0.1,
                            Icons.add_circle,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
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
                                    : Text(
                                        _getController.getProfileById.value.res!
                                                .bio ??
                                            '',
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
                            () => _getController
                                        .bookingBusinessGetList.value.res ==
                                    null
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
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: h * 0.24,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: _getController
                                                  .bookingBusinessGetList
                                                  .value
                                                  .res!
                                                  .length,
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
                                                              fontSize:
                                                                  w * 0.04,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                              }),
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(child: SizedBox()),
                                            SizedBox(
                                              height: h * 0.045,
                                              child: TextButton(
                                                onPressed: () {
                                                  showBottomSheetList(context);
                                                },
                                                child: Text(
                                                  'Barchasini ko\'rish',
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
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  showBottomSheet(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                                child: Text(
                                  'Vaqtni tanlang',
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
