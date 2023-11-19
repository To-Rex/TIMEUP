import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:time_up/pages/post_details.dart';
import '../api/api_controller.dart';
import '../elements/functions.dart';
import '../res/getController.dart';

class ProfessionsListDetails extends StatelessWidget {
  ProfessionsListDetails({Key? key}) : super(key: key);

  final GetController _getController = Get.put(GetController());
  final PageController pageController = PageController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  showBottomSheet(context) {
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
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: h * 0.02),
                width: w * 0.2,
                height: h * 0.005,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: h * 0.02),
              const Center(
                child: Text(
                  'Kunni va vaqtni belgilang',
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
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
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
                    ApiController()
                        .createBookingClientCreate(
                          _getController.getProfileById.value.res!.id ?? 0,
                          _dateController.text,
                          _timeController.text,
                        )
                        .then((value) => {
                              if (value == true)
                                {
                                  ApiController()
                                      .bookingBusinessGetList(
                                          _getController
                                              .bookingBusinessGetListByID.value,
                                          '')
                                      .then((value) => _getController
                                          .changeBookingBusinessGetList(value)),
                                  Navigator.pop(context),
                                  Toast.showToast(context, 'Booking yaratildi',
                                      Colors.green, Colors.white),
                                }
                              else
                                {
                                  Toast.showToast(context, 'Error', Colors.red,
                                      Colors.white),
                                }
                            });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Jonatish',
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
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: h * 0.02),
                width: w * 0.2,
                height: h * 0.005,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
                                _getController.bookingBusinessGetList.value.res!
                                    .clear(),
                                _dateController.text =
                                    '${value!.day < 10 ? '0${value.day}' : value.day}/${value.month < 10 ? '0${value.month}' : value.month}/${value.year}',
                                ApiController()
                                    .bookingBusinessGetList(
                                        _getController
                                            .bookingBusinessGetListByID.value,
                                        '${value.day}/${value.month}/${value.year}')
                                    .then((value) => _getController
                                        .changeBookingBusinessGetList(value)),
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
              //list bookingBusinessGetList
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                child: Obx(() =>
                    _getController.bookingBusinessGetList.value.res == null
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: _getController
                                .bookingBusinessGetList.value.res!.length,
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
    ApiController().profileById(_getController.profileByID.value);
    _getController.clearGetPostList();
    ApiController().getMePostList(_getController.getProfileById.value.res?.id ?? 0);
    ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value, '').then((value) => _getController.changeBookingBusinessGetList(value));
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(h * 0.1),
          child: Container(
            margin: EdgeInsets.only(top: h * 0.03, bottom: h * 0.01),
            child: Row(
              children: [
                SizedBox(width: w * 0.04),
                Image(
                  image: const AssetImage('assets/images/text.png'),
                  width: w * 0.2,
                  height: h * 0.05,
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Obx(() => _getController.getProfileById.value.res == null
              ? const Expanded(child: Center(child: CircularProgressIndicator()))
              : Column(
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
                      title: Obx(
                          () => _getController.getProfileById.value.res == null
                              ? Text(
                                  'No data',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  _getController
                                          .getProfileById.value.res!.userName ??
                                      '',
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
                            child: _getController
                                        .getProfileById.value.res!.photoUrl ==
                                    null
                                ? Row(
                                    children: [
                                      SizedBox(width: w * 0.04),
                                      const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/doctor.png'),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      SizedBox(width: w * 0.04),
                                      InkWell(
                                        hoverColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Scaffold(
                                                appBar: AppBar(
                                                  elevation: 0,
                                                  backgroundColor: Colors.black,
                                                  leading: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                backgroundColor: Colors.black,
                                                body: PhotoView(
                                                  imageProvider: NetworkImage(
                                                    "${_getController.getProfileById.value.res!.photoUrl}",
                                                  ),
                                                  minScale:
                                                      PhotoViewComputedScale
                                                              .contained *
                                                          0.8,
                                                  maxScale:
                                                      PhotoViewComputedScale
                                                              .covered *
                                                          2,
                                                  initialScale:
                                                      PhotoViewComputedScale
                                                          .contained,
                                                  enableRotation: true,
                                                  loadingBuilder:
                                                      (context, event) =>
                                                          Center(
                                                    child: SizedBox(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: event == null
                                                            ? 0
                                                            : event.cumulativeBytesLoaded /
                                                                event
                                                                    .expectedTotalBytes!,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: w * 0.15,
                                          backgroundImage: NetworkImage(
                                            "${_getController.getProfileById.value.res!.photoUrl}",
                                          ),
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
                                    : Text("${_getController.getProfileById.value.res!.fistName} ${_getController.getProfileById.value.res!.lastName}",
                                        style: TextStyle(
                                          fontSize: w * 0.05,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                            SizedBox(height: h * 0.01,),
                            Row(
                              children: [
                                Obx(() => _getController.getProfileById.value.res == null
                                        ? const SizedBox()
                                        : Text(
                                            _getController.getProfileById.value.res!.categoryName ?? '',
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
                                  size: w * 0.05,
                                ),
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
                                  size: w * 0.05,
                                ),
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
                                  size: w * 0.05,
                                ),
                                SizedBox(width: w * 0.02),
                                Obx(() => _getController.getProfileById.value.res == null
                                        ? const SizedBox()
                                        : Text(_getController.getProfileById.value.res!.officeName ?? '',
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
                                  HeroIcons.user,
                                  color: Colors.blue,
                                  size: w * 0.05,
                                ),
                                SizedBox(width: w * 0.02),
                                Obx(() => _getController.getProfileById.value.res == null
                                        ? const SizedBox()
                                        : Text(_getController.getProfileById.value.res!.bio!.length > 35
                                                ? '${_getController.getProfileById.value.res!.bio?.substring(0, 35)}...'
                                                : _getController.getProfileById.value.res!.bio ?? '',
                                            style: TextStyle(
                                              fontSize: w * 0.04,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                              ],
                            ),
                            SizedBox(height: h * 0.02),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: w * 0.21,
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
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              backgroundColor: Colors.blue,
                                            ),
                                            child: Text(
                                              'Post',
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
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(3),
                                              ),
                                              backgroundColor: Colors.grey,
                                            ),
                                            child: Text('Post',
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
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(3),
                                                ),
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
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(3),
                                                ),
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
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(3),
                                                ),
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
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(3),
                                                ),
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
                                Obx(() => _getController.getProfileById.value.res!.followed == false
                                    ? Container(
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
                                                            ApiController().profileById(_getController.profileByID.value).then((value) => {_getController.changeProfileById(value),}),
                                                            _getController.clearByCategory(),
                                                            ApiController().getByCategory(_getController.categoryByID.value).then((value) => _getController.changeByCategory(value)),
                                                          } else {
                                                            Toast.showToast(context, 'Error', Colors.red, Colors.white),
                                                          }
                                                      });
                                            },
                                            icon: HeroIcon(
                                              HeroIcons.userPlus,
                                              color: Colors.white,
                                              size: w * 0.1,
                                            )),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        width: w * 0.1,
                                        height: h * 0.05,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        child: IconButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              ApiController().unFollow(_getController.getProfileById.value.res!.id ?? 0).then((value) => {
                                                        if (value == true){
                                                            Toast.showToast(context, 'Followed', Colors.green, Colors.white),
                                                            ApiController().profileById(_getController.profileByID.value).then((value) => {_getController.changeProfileById(value),}),
                                                            _getController.clearByCategory(),
                                                            ApiController().getByCategory(_getController.categoryByID.value).then((value) => _getController.changeByCategory(value))
                                                          } else {
                                                            Toast.showToast(context, 'Error', Colors.red, Colors.white),
                                                          }
                                                      });
                                            },
                                            icon: HeroIcon(
                                              HeroIcons.userPlus,
                                              color: Colors.white,
                                              size: w * 0.1,
                                            )),
                                      )),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                            SizedBox(height: h * 0.02,),
                            SizedBox(
                              width: w,
                              height: h * 0.3,
                              child: PageView(
                                onPageChanged: (index) {
                                  _getController.nextPagesUserDetails.value = index;
                                },
                                controller: pageController,
                                children: [
                                  SizedBox(
                                    width: w,
                                    height: h * 0.2,
                                    child: Obx(
                                      () => _getController.getPostList.value.res == null
                                          ? Center(
                                              child: Text(
                                              'No data',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ))
                                          : ListView.builder(
                                              itemCount: _getController.getPostList.value.res!.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    //_getController.clearGetByIdPost();
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsPage(postId: _getController.getPostList.value.res![index].id,)));
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(bottom: h * 0.01),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Obx(() => _getController.getPostList.value.res![index].mediaType == 'video'
                                                            ? Stack(
                                                                children: [
                                                                  Container(
                                                                    width: w * 0.28,
                                                                    height: h * 0.13,
                                                                    margin: EdgeInsets.only(right: w * 0.02),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(3),
                                                                      image: DecorationImage(
                                                                        image: NetworkImage('${_getController.getPostList.value.res![index].photo}'),
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                      width: w * 0.28,
                                                                      height: h * 0.13,
                                                                    child: Center(
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsPage(postId: _getController.getPostList.value.res![index].id,)));
                                                                        },
                                                                        child: Container(
                                                                          width: w * 0.1,
                                                                          height: h * 0.05,
                                                                          decoration: BoxDecoration(
                                                                            color: Colors.black.withOpacity(0.5),
                                                                            borderRadius: BorderRadius.circular(w * 0.1),
                                                                          ),
                                                                          child: Center(
                                                                            child: Icon(
                                                                              Icons.play_arrow,
                                                                              color: Colors.white,
                                                                              size: w * 0.05,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ),
                                                                ],) : Container(
                                                          width: w * 0.28,
                                                          height: h * 0.13,
                                                                margin: EdgeInsets.only(right: w * 0.02),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(3),
                                                                  image: DecorationImage(
                                                                    image: NetworkImage('${_getController.getPostList.value.res![index].photo}'),
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              )),
                                                        Expanded(
                                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                                                              height: h * 0.03,
                                                              child: Text('${_getController.getPostList.value.res![index].title}',
                                                                style: TextStyle(
                                                                  fontSize: w * 0.04,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: h * 0.04,
                                                              child: Text('${_getController.getPostList.value.res![index].description}',
                                                                style: TextStyle(
                                                                  fontSize: w * 0.04,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
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
                                              padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02, top: h * 0.01),
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
                                                                    child: Text('Ushbu mijoz'
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
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(3),
                                            ),
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
                ),
        ),
      ),
    );
  }
}
