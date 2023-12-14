import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:time_up/pages/post_details.dart';
import '../api/api_controller.dart';
import '../elements/user_detials.dart';
import '../models/booking_business_category_get.dart';
import '../res/getController.dart';
import 'package:readmore/readmore.dart';

class ProfessionsListDetails extends StatelessWidget {
  ProfessionsListDetails({Key? key}) : super(key: key);

  final GetController _getController = Get.put(GetController());
  final PageController pageController = PageController();
  final PageController pageSheetController = PageController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  showLoadingDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
              child: Text("Kuting...", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.w500),)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDialogValidation(BuildContext context,title,description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Center(
            child: Text(description),
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
                      child: Text('Bekor qilish',
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
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Text('Ok',
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                          const HeroIcon(HeroIcons.check, color: Colors.white)
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
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: w * 0.4,
                      height: h * 0.05,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            _getController.changeSheetPages(0);
                            pageSheetController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                          },
                          child: Obx(() => _getController.sheetPages.value == 0
                              ? Text('Ish jadvali',
                                  style: TextStyle(color: Colors.blue, fontSize: w * 0.04))
                              : Text('Ish jadvali',
                                  style: TextStyle(color: Colors.grey, fontSize: w * 0.04)))),
                    ),
                    Container(
                      width: w * 0.005,
                      height: h * 0.03,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(
                      width: w * 0.4,
                      height: h * 0.05,
                      child: TextButton(
                          onPressed: () {
                            _getController.changeSheetPages(1);
                            pageSheetController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.transparent,
                          ),
                          child: Obx(() => _getController.sheetPages.value == 1
                              ? Text('Booking', style: TextStyle(color: Colors.blue, fontSize: w * 0.04))
                              : Text('Booking', style: TextStyle(color: Colors.grey, fontSize: w * 0.04)))),
                    )
                  ],
                ),
                const Divider(),
                SizedBox(
                  height: h * 0.65,
                  child: PageView(
                    controller: pageSheetController,
                    onPageChanged: (index) {
                      _getController.changeSheetPages(index);
                      _dateController.clear();
                      if (index == 0) {
                        //ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value, '').then((value) => _getController.changeBookingBusinessGetList(value));
                        ApiController().bookingListBookingAndBookingCategory(_getController.bookingBusinessGetListByID.value, '');
                      }
                    },
                    children: [
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2025),
                                        ).then((value) => {
                                              //_getController.bookingBusinessGetList.value.res!.clear(),
                                              _getController.getBookingBusinessGetListCategory.value.res?.bookings!.clear(),
                                              _dateController.text = '${value!.day < 10 ? '0${value.day}' : value.day}/${value.month < 10 ? '0${value.month}' : value.month}/${value.year}',
                                              //ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value, '${value.day}/${value.month}/${value.year}').then((value) => _getController.changeBookingBusinessGetList(value)),
                                              ApiController().bookingListBookingAndBookingCategory(_getController.bookingBusinessGetListByID.value, '${value.day}/${value.month}/${value.year}'),
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
                            Expanded(child: Padding(padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                              child: Obx(() => _getController.getBookingBusinessGetListCategory.value.res == null || _getController.getBookingBusinessGetListCategory.value.res!.bookings!.isEmpty
                                  ? Center(
                                child: Text(
                                  'Ma\'lumotlar mavjud emas',
                                  style: TextStyle(
                                    fontSize: w * 0.03,
                                  ),
                                ),
                              ) : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _getController.getBookingBusinessGetListCategory.value.res?.bookings!.length,
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
                                                    /*'Ushbu mijoz'
                                                    ' ${_getController.bookingBusinessGetList.value.res![index].date!.replaceAll('/', '-')} '
                                                    '${_getController.bookingBusinessGetList.value.res![index].time!} keladi',*/
                                                    'Ushbu mijoz '
                                                        '${_getController.getBookingBusinessGetListCategory.value.res?.bookings![index].date!.replaceAll('/', '-')} '
                                                        '${_getController.getBookingBusinessGetListCategory.value.res?.bookings![index].time!} keladi',
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
                      ),
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
                            SizedBox(height: h * 0.02),
                            if (_getController.getBookingBusinessGetListCategory.value.res?.bookingCategories!.isEmpty ?? true)const SizedBox()
                            else
                            Row(
                              children: [
                                SizedBox(width: w * 0.05),
                                Text('xizmat turini tanlang',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            if (_getController.getBookingBusinessGetListCategory.value.res?.bookingCategories!.isEmpty ?? true)const SizedBox()
                            else
                            Container(
                              height: h * 0.06,
                              width: w * 0.9,
                              padding: EdgeInsets.only(left: w * 0.02),
                              decoration: BoxDecoration(
                                //color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Obx(() => _getController.getBookingBusinessGetListCategory.value.res!.bookingCategories!.isEmpty
                                  ? const SizedBox()
                                  : DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        value: _getController.getBookingBusinessGetListCategory.value.res!.bookingCategories![_getController.bookingBusinessIndex.value],
                                        onChanged: (newValue) {
                                          _getController.bookingBusinessIndex.value = _getController.getBookingBusinessGetListCategory.value.res!.bookingCategories!.indexOf(newValue as BookingCategories);
                                        },
                                        items: _getController.getBookingBusinessGetListCategory.value.res!.bookingCategories!.map((value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                              value.name!,
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )),

                            ),
                            SizedBox(height: h * 0.02),
                            if (_getController.getBookingBusinessGetListCategory.value.res?.bookingCategories!.isEmpty ?? true)const SizedBox()
                            else
                              Row(
                                children: [
                                  SizedBox(width: w * 0.05),
                                  const Text('xizmat turi haqida'),
                                ],
                              ),
                              //getBookingBusinessGetListCategory selected index get data
                            Obx(() => _getController.getBookingBusinessGetListCategory.value.res!.bookingCategories!.isEmpty
                                ? const SizedBox()
                                : Container(
                              width: w * 0.9,
                              //height: h * 0.06,
                              margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05, bottom: h * 0.02),
                              padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02, top: h * 0.01, bottom: h * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: w * 0.58,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //name of selected index
                                        Text(_getController.getBookingBusinessGetListCategory.value.res!.bookingCategories![_getController.bookingBusinessIndex.value].name!,
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                        ),
                                        //price of selected index
                                        Text('${_getController.getBookingBusinessGetListCategory.value.res!.bookingCategories![_getController.bookingBusinessIndex.value].price} so\'m',
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                        ),
                                        //duration of selected index
                                        Text('${_getController.getBookingBusinessGetListCategory.value.res!.bookingCategories![_getController.bookingBusinessIndex.value].duration} minut',
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  //price of selected index
                                  SizedBox(
                                    width: w * 0.25,
                                    child: Text('${_getController.getBookingBusinessGetListCategory.value.res!.bookingCategories![_getController.bookingBusinessIndex.value].price} so\'m',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.right,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            ),
                            Row(
                              children: [
                                SizedBox(width: w * 0.05),
                                Text('kunni tanlang',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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
                                        ).then((value) => {_dateController.text = '${value!.day < 10 ? '0${value.day}' : value.day}/${value.month < 10 ? '0${value.month}' : value.month}/${value.year}',});
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
                                          initialEntryMode: TimePickerEntryMode.input,
                                          hourLabelText: 'Soat',
                                          minuteLabelText: 'Daqiqa',
                                          helpText: 'Vaqtni tanlang',
                                        ).then((value) => _timeController.text = '${value!.hour < 10 ? '0${value.hour}' : value.hour}:${value.minute < 10 ? '0${value.minute}' : value.minute}');
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
                            SizedBox(height: h * 0.03),
                            SizedBox(
                              width: w * 0.9,
                              height: h * 0.07,
                              child: ElevatedButton(
                                onPressed: () {
                                  showLoadingDialog(context);
                                  int id = 0;
                                  if (_getController.getBookingBusinessGetListCategory.value.res!.bookingCategories!.isEmpty) {
                                    id = 0;
                                  }else{
                                    id = int.parse(_getController.getBookingBusinessGetListCategory.value.res!.bookingCategories![_getController.bookingBusinessIndex.value].id.toString());
                                  }
                                  ApiController().createBookingClientCreate(_getController.getProfileById.value.res!.id ?? 0, _dateController.text, _timeController.text, id).then((value) => {
                                            if (value == true){
                                                //ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value, '').then((value) => _getController.changeBookingBusinessGetList(value)),
                                                ApiController().bookingListBookingAndBookingCategory(_getController.bookingBusinessGetListByID.value, ''),
                                                Navigator.pop(context),
                                                showDialogValidation(context, 'Booking yaratildi', 'Booking yaratildi'),
                                                pageSheetController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease)
                                              } else {
                                                Navigator.pop(context),
                                                showDialogValidation(context, 'Booking yaratilmadi', 'iltimos boshqa kun yoki vaqtni tanlang!')
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
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  void _onRefresh() async {
    ApiController().getMePostList(_getController.getProfileById.value.res?.id).then((value) => _refreshController.refreshCompleted());
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll) {
      print('max');
    }
    double startScroll = _scrollController.position.minScrollExtent;
    if (currentScroll <= startScroll) {
      print('start');
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    _getController.show.value = false;
    ApiController().getMePostList(_getController.getProfileById.value.res?.id);
    //ApiController().bookingBusinessGetList(_getController.bookingBusinessGetListByID.value, '');
    ApiController().bookingListBookingAndBookingCategory(_getController.bookingBusinessGetListByID.value, '');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Image(
            image: const AssetImage('assets/images/text.png'),
            width: w * 0.2,
            height: h * 0.05,
          ),
        ),
        body: Obx(() => _getController.getProfileById.value.res == null
              ? const Expanded(child: Center(child: CircularProgressIndicator()))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      surfaceTintColor: Colors.white,
                      elevation: 0,
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios, size: w * 0.05),
                      ),
                      title: Obx(() => _getController.getProfileById.value.res == null
                              ? Text('No data',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(_getController.getProfileById.value.res!.userName ?? '',
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
                              child: _getController.getProfileById.value.res!.photoUrl == null
                                  ? SizedBox(
                                      width: w,
                                      child: InkWell(
                                        hoverColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.push(context,
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
                                                  imageProvider: const AssetImage('assets/images/doctor.png'),
                                                  minScale: PhotoViewComputedScale.contained * 0.8,
                                                  maxScale: PhotoViewComputedScale.covered * 2,
                                                  initialScale: PhotoViewComputedScale.contained,
                                                  enableRotation: true,
                                                  loadingBuilder: (context, event) => Center(
                                                    child: SizedBox(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      child: CircularProgressIndicator(
                                                        value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
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
                                          backgroundImage: const AssetImage('assets/images/doctor.png'),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: w,
                                      child: InkWell(
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
                                                    leading: const SizedBox(),
                                                  ),
                                                  backgroundColor: Colors.black,
                                                  body: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: h * 0.05,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: w * 0.01),
                                                            Container(alignment: Alignment.center,
                                                              width: w * 0.1,
                                                              height: h * 0.05,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(w * 0.1),
                                                              ),
                                                              child: IconButton(
                                                                  color: Colors.white,
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  icon: HeroIcon(
                                                                    HeroIcons.chevronLeft,
                                                                    color: Colors.black,
                                                                    size: w * 0.1,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: PhotoView(
                                                          imageProvider: NetworkImage("${_getController.getProfileById.value.res!.photoUrl}"),
                                                          minScale: PhotoViewComputedScale.contained * 0.8,
                                                          maxScale: PhotoViewComputedScale.covered * 2,
                                                          initialScale: PhotoViewComputedScale.contained,
                                                          enableRotation: true,
                                                          loadingBuilder: (context, event) => Center(
                                                            child: SizedBox(
                                                              width: 20.0,
                                                              height: 20.0,
                                                              child: CircularProgressIndicator(
                                                                value: event == null
                                                                    ? 0
                                                                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          );
                                        },
                                        //circular avatar with image from network and image cover with photo view
                                        child: CircleAvatar(
                                          radius: w * 0.15,
                                          foregroundColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          child: ClipOval(
                                            child: Image.network(
                                              "${_getController.getProfileById.value.res!.photoUrl}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                    ),
                    SizedBox(height: h * 0.02),
                    Center(child: Obx(() => _getController.getProfileById.value.res == null
                              ? const SizedBox()
                              : Text("${_getController.getProfileById.value.res!.fistName} ${_getController.getProfileById.value.res!.lastName}",
                                  style: TextStyle(
                                    fontSize: w * 0.05,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                    ),
                    SizedBox(height: h * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(() => _getController.getProfileById.value.res == null
                                ? const SizedBox()
                                : UserDetIalWidget(
                                    labelText: 'Post',
                                    labelTextCount: '${_getController.getProfileById.value.res!.postsCount}',
                                  )),
                        Obx(() => _getController.getProfileById.value.res == null
                                ? const SizedBox()
                                : UserDetIalWidget(
                                    labelText: 'Followers',
                                    labelTextCount: '${_getController.getProfileById.value.res!.followersCount}',
                                  )),
                        Obx(() => _getController.getProfileById.value.res == null
                                ? const SizedBox()
                                : UserDetIalWidget(
                                    labelText: 'Following',
                                    labelTextCount: '${_getController.getProfileById.value.res!.followingCount}',
                                  )),
                      ],
                    ),
                    SizedBox(height: h * 0.02),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: w,
                            padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, bottom: h * 0.01),
                            child: Obx(() => _getController.show.value == false
                                ? Row(
                                    children: [
                                      HeroIcon(
                                        HeroIcons.phone,
                                        color: Colors.blue,
                                        size: w * 0.05,
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      Obx(() => _getController.getProfileById.value.res == null
                                          ? const SizedBox()
                                          : Text(_getController.getProfileById.value.res!.phoneNumber ?? '',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )),
                                      //show
                                      SizedBox(width: w * 0.02),
                                      InkWell(
                                        onTap: () {
                                          _getController.show.value = true;
                                        },
                                        child: Text(
                                          'More',
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
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
                                      SizedBox(height: h * 0.01),
                                      SizedBox(height: h * 0.01),
                                      Row(
                                        children: [
                                          HeroIcon(
                                            HeroIcons.phone,
                                            color: Colors.blue,
                                            size: w * 0.05,
                                          ),
                                          SizedBox(
                                            width: w * 0.02,
                                          ),
                                          Obx(() => _getController.getProfileById.value.res == null
                                              ? const SizedBox()
                                              : Text(
                                                  _getController.getProfileById.value.res!.phoneNumber ?? '',
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
                                            HeroIcons.mapPin,
                                            color: Colors.blue,
                                            size: w * 0.05,
                                          ),
                                          SizedBox(
                                            width: w * 0.02,
                                          ),
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
                                              : Text(
                                                  _getController.getProfileById.value.res!.officeName ?? '',
                                                  style: TextStyle(
                                                    fontSize: w * 0.04,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )),
                                          SizedBox(width: w * 0.02),
                                          InkWell(
                                            onTap: () {
                                              _getController.show.value = false;
                                            },
                                            child: Text(
                                              'Less',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                          ),
                          Container(
                            width: w,
                            height: h * 0.05,
                            color: Colors.grey[300],
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      _getController.nextPagesUserDetails.value = 0;
                                      pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                    },
                                    overlayColor: MaterialStateProperty.all(Colors.red),
                                    child: Container(
                                      color: _getController.nextPagesUserDetails.value == 0
                                          ? Colors.blue
                                          : Colors.grey[300],
                                      alignment: Alignment.center,
                                      child: Obx(() => _getController.nextPagesUserDetails.value == 0
                                          ? Text('Post',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text('Post',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      _getController.changeSheetPages(0);
                                      showBottomSheetList(context);
                                    },
                                    overlayColor: MaterialStateProperty.all(Colors.red),
                                    child: Container(
                                      color: _getController.nextPagesUserDetails.value == 3
                                          ? Colors.blue
                                          : Colors.grey[300],
                                      alignment: Alignment.center,
                                      child: Obx(() => _getController.nextPagesUserDetails.value == 3
                                          ? Text('Booking',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text('Booking',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      _getController.nextPagesUserDetails.value = 21;
                                      pageController.animateToPage(2, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                    },
                                    overlayColor: MaterialStateProperty.all(Colors.red),
                                    child: Container(
                                      color: _getController.nextPagesUserDetails.value == 1
                                          ? Colors.blue
                                          : Colors.grey[300],
                                      alignment: Alignment.center,
                                      child: Obx(() => _getController.nextPagesUserDetails.value == 1
                                          ? Text('Bio',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text('Bio',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: w,
                            height: _getController.show.value ? h * 0.3 : h * 0.44,
                            padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.01),
                            child: PageView(
                              onPageChanged: (index) {
                                _getController.nextPagesUserDetails.value = index;
                              },
                              controller: pageController,
                              children: [
                                SizedBox(
                                  width: w,
                                  height: h * 0.2,
                                  child: Obx(() => _getController.getPostList.value.res == null
                                            ? Center(
                                                child: Text(
                                                'No data',
                                                style: TextStyle(
                                                  fontSize: w * 0.04,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )): SmartRefresher(
                                    enablePullDown: true,
                                    enablePullUp: true,
                                    header: CustomHeader(
                                      builder:
                                          (BuildContext context, RefreshStatus? mode) {
                                        Widget body;
                                        if (mode == RefreshStatus.idle) {
                                          body = const Text(
                                              "Ma`lumotlarni yangilash uchun tashlang");
                                        } else if (mode == RefreshStatus.refreshing) {
                                          body = const CircularProgressIndicator(
                                            color: Colors.blue,
                                            backgroundColor: Colors.white,
                                            strokeWidth: 2,
                                          );
                                        } else if (mode == RefreshStatus.failed) {
                                          body = const Text("Load Failed!Click retry!");
                                        } else if (mode == RefreshStatus.canRefresh) {
                                          body = const Text(
                                              "Ma`lumotlarni yangilash uchun tashlang");
                                        } else {
                                          body = const Text("Ma`lumotlar yangilandi");
                                        }
                                        return SizedBox(
                                          height: h * 0.1,
                                          child: Center(child: body),
                                        );
                                      },
                                    ),
                                    footer: CustomFooter(
                                      builder: (BuildContext context, LoadStatus? mode) {
                                        Widget body;
                                        if (mode == LoadStatus.idle) {
                                          body = const SizedBox();
                                        } else if (mode == LoadStatus.loading) {
                                          body = const CircularProgressIndicator(
                                            color: Colors.blue,
                                            backgroundColor: Colors.white,
                                            strokeWidth: 2,
                                          );
                                        } else if (mode == LoadStatus.failed) {
                                          body = const Text("Load Failed!Click retry!");
                                        } else if (mode == LoadStatus.canLoading) {
                                          body = const SizedBox();
                                        } else {
                                          body = const Text("Ma`lumotlar yangilandi");
                                        }
                                        return SizedBox(
                                          height: h * 0.1,
                                          child: Center(child: body),
                                        );
                                      },
                                    ),
                                    controller: _refreshController,
                                    onRefresh: _onRefresh,
                                    onLoading: _onLoading,
                                    child: ListView.builder(
                                        itemCount: _getController.getPostList.value.res!.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
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
                                                              splashColor: Colors.transparent,
                                                              hoverColor: Colors.transparent,
                                                              focusColor: Colors.transparent,
                                                              highlightColor: Colors.transparent,
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
                                                          )),
                                                    ],
                                                  )
                                                      : Container(
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
                                                  Expanded(child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        height: h * 0.03,
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
                                  //text bio
                                  child: Obx(() => _getController.getProfileById.value.res == null
                                          ? const SizedBox()
                                          : ReadMoreText(
                                              _getController.getProfileById.value.res!.bio ?? '',
                                              trimLines: 10,
                                              colorClickableText: Colors.blue,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: ' more',
                                              trimExpandedText: ' less',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ));
  }
}
