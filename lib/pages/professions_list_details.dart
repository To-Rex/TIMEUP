import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:time_up/elements/functions.dart';
import 'package:time_up/pages/post_details.dart';
import '../api/api_controller.dart';
import '../elements/txt_business.dart';
import '../elements/user_detials.dart';
import '../models/booking_business_category_get.dart';
import '../models/followers_model.dart';
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
  late TabController _followTabController;
  late TabController _tabController;

  final ScrollController _scrollControllerPage = ScrollController();

  showDialogValidation(BuildContext context,title,description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
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
      //showDragHandle: true,
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
            width: w,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Stack(
              children: [
                Positioned(
                    top: 0 ,
                    child: Center(
                      child: Container(
                        width: w,
                        height: h * 0.16,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    )
                ),
                Positioned(
                  top: h * 0.01,
                  width: w,
                  child: Center(
                    child: Container(
                      width: w * 0.3,
                      height: h * 0.005,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                ),
                Positioned(
                  top: h * 0.05,
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
                          //_onTap(index,context);
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
                                  'Ish jadvali',
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
                                  'Booking',
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
                Positioned(
                  top: h * 0.12,
                  width: w,
                  height: h * 0.7,
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: h * 0.08,
                            width: w,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
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
                                      _scrollController.animateTo(_scrollController.offset - w * 0.3, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,
                                      );
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
                                        return Obx(() => GestureDetector(
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
                                                        _getController.clearGetBookingBusinessGetListCategory();
                                                        ApiController().bookingListBookingAndBookingCategory(_getController.bookingBusinessGetListByID.value, _dateController.text);
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
                                              _getController.clearGetBookingBusinessGetListCategory();
                                              ApiController().bookingListBookingAndBookingCategory(_getController.bookingBusinessGetListByID.value, _dateController.text).then((value) => {
                                                Loading.hideLoading(context)
                                              });
                                            } else {
                                              _getController.clearGetBookingBusinessGetListCategory();
                                              ApiController().bookingListBookingAndBookingCategory(_getController.bookingBusinessGetListByID.value, _dateController.text).then((value) => {
                                                Loading.hideLoading(context)
                                              });
                                            }
                                          },
                                          child: Container(
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
                                        ));
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
                          ),
                          //text current date 2023-04-08  mijozlar kelish vaqti
                          Container(
                            width: w,
                            margin: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
                            child: Center(
                              child: Text(
                                '${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day} mijozlar kelish vaqti',
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w,
                            height: h * 0.55,
                            child: Obx(() => _getController.getBookingBusinessGetListCategory.value.res == null || _getController.getBookingBusinessGetListCategory.value.res!.bookings!.isEmpty
                                ? Center(
                              child: Text(
                                'Ma\'lumotlar mavjud emas',
                                style: TextStyle(
                                  fontSize: w * 0.03,
                                ),
                              ),
                            ) : ListView.builder(
                                itemCount: _getController.getBookingBusinessGetListCategory.value.res?.bookings!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
                                        padding: EdgeInsets.only(left: w * 0.05, right: w * 0.04, top: h * 0.02, bottom: h * 0.02),
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
                                            SizedBox(
                                              width: w * 0.7,
                                              child: Text(
                                                'Ushbu mijoz '
                                                    '${_getController.getBookingBusinessGetListCategory.value.res?.bookings![index].date!.replaceAll('/', '-')} '
                                                    '${_getController.getBookingBusinessGetListCategory.value.res?.bookings![index].time!} keladi',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: w * 0.04,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            HeroIcon(
                                              HeroIcons.arrowDownCircle,
                                              style: HeroIconStyle.solid,
                                              color: Colors.green,
                                              size: w * 0.06,)
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                })),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: h * 0.1,
                            width: w,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
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
                                  //user circile icon
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: w * 0.03),
                                    width: w * 0.15,
                                    child: Center(
                                      child: Container(
                                        width: w * 0.1,
                                        height: w * 0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(w),
                                          image: DecorationImage(
                                            image: NetworkImage(_getController.getProfileById.value.res?.photoUrl ?? ''),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: w * 0.6,
                                        child: Text(
                                          _getController.getProfileById.value.res?.userName ?? '',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: w * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.6,
                                        child: Text(
                                          '${_getController.getProfileById.value.res?.fistName ?? ''} ${_getController.getProfileById.value.res?.lastName ?? ''}',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: w * 0.03,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          HeroIcon(
                                            HeroIcons.checkCircle,
                                            color: Colors.green,
                                            size: w * 0.04,),
                                          SizedBox(
                                            width: w * 0.02,
                                          ),
                                          Text(
                                            '${_getController.getProfileById.value.res?.experience ?? ''} Yillik ish tajribasi',
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: w * 0.03,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Kunni va vaqtni belgilang',
                                    style: TextStyle(
                                      fontSize: w * 0.035,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: h * 0.01),
                                if (_getController.getBookingBusinessGetListCategory.value.res?.bookingCategories!.isEmpty ?? true)const SizedBox()
                                else
                                  Row(
                                    children: [
                                      SizedBox(width: w * 0.05),
                                      Text('xizmat turini tanlang',
                                        style: TextStyle(
                                          fontSize: w * 0.03,
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
                                    padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
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
                                                fontSize: w * 0.035,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                  ),
                                SizedBox(height: h * 0.01),
                                if (_getController.getBookingBusinessGetListCategory.value.res?.bookingCategories!.isEmpty ?? true)const SizedBox()
                                else
                                  Row(
                                    children: [
                                      SizedBox(width: w * 0.05),
                                      Text('xizmat turi haqida',
                                        style: TextStyle(
                                          fontSize: w * 0.03,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                //getBookingBusinessGetListCategory selected index get data
                                Obx(() => _getController.getBookingBusinessGetListCategory.value.res!.bookingCategories!.isEmpty
                                    ? const SizedBox()
                                    : Container(
                                  width: w * 0.9,
                                  //height: h * 0.06,
                                  margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05, bottom: h * 0.01),
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
                                                fontSize: w * 0.035,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                            ),
                                            //price of selected index
                                            Text('${_getController.getBookingBusinessGetListCategory.value.res!.bookingCategories![_getController.bookingBusinessIndex.value].price} so\'m',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                            ),
                                            //duration of selected index
                                            Text('${_getController.getBookingBusinessGetListCategory.value.res!.bookingCategories![_getController.bookingBusinessIndex.value].duration} minut',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
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
                                            fontSize: w * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.right,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),)
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: w * 0.05),
                                    Text('kunni tanlang',
                                      style: TextStyle(
                                        fontSize: w * 0.03,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: w * 0.9,
                                  height: h * 0.06,
                                  child: TextField(
                                    controller: _dateController,
                                    decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                          onTap: () {
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
                                                      if (_dateController.text == '') {
                                                        _dateController.text = '${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}/${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}/${DateTime.now().year}';
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
                                          },
                                          child: HeroIcon(
                                            HeroIcons.calendar,
                                            color: Colors.black,
                                            size: w * 0.06,
                                          )),
                                      hintText: 'MM / DD / YYYY',
                                      hintStyle: TextStyle(
                                        fontSize: w * 0.035,
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
                                SizedBox(height: h * 0.01),
                                Row(
                                  children: [
                                    SizedBox(width: w * 0.05),
                                    Text('Vaqtni tanlang',
                                      style: TextStyle(
                                        fontSize: w * 0.03,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: w * 0.9,
                                  height: h * 0.06,
                                  child: TextField(
                                    controller: _timeController,
                                    decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                          onTap: () {
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
                                                    _timeController.text = '${newdate.hour < 10 ? '0${newdate.hour}' : newdate.hour}:${newdate.minute < 10 ? '0${newdate.minute}' : newdate.minute}';
                                                  },
                                                  minimumYear: 1900,
                                                  maximumYear: 2200,
                                                  use24hFormat: true,
                                                  mode: CupertinoDatePickerMode.time,
                                                  //maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 21, 00),
                                                  //minimumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 00),
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                              titleTextStyle: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                              title: Row(
                                                children: [
                                                  HeroIcon(
                                                    HeroIcons.clock,
                                                    color: Colors.blue,
                                                    size: w * 0.06,
                                                  ),
                                                  SizedBox(width: w * 0.02),
                                                  Text('Vaqtni tanlang',
                                                    style: TextStyle(
                                                      fontSize: w * 0.04,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                ],
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
                                                      if (_timeController.text == '') {
                                                        _timeController.text = '${DateTime.now().hour < 10 ? '0${DateTime.now().hour}' : DateTime.now().hour}:${DateTime.now().minute < 10 ? '0${DateTime.now().minute}' : DateTime.now().minute}';
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
                                          },
                                          child: HeroIcon(
                                            HeroIcons.clock,
                                            color: Colors.black,
                                            size: w * 0.06,
                                          )),
                                      hintText: 'HH : MM',
                                      hintStyle: TextStyle(
                                        fontSize: w * 0.035,
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
                                  height: h * 0.05,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Loading.showLoading(context);
                                      int id = 0;
                                      if (_getController.getBookingBusinessGetListCategory.value.res!.bookingCategories!.isEmpty) {
                                        id = 0;
                                      }else{
                                        id = int.parse(_getController.getBookingBusinessGetListCategory.value.res!.bookingCategories![_getController.bookingBusinessIndex.value].id.toString());
                                      }
                                      ApiController().createBookingClientCreate(_getController.getProfileById.value.res!.id ?? 0, _dateController.text, _timeController.text, id).then((value) => {
                                        if (value == true){
                                          ApiController().bookingListBookingAndBookingCategory(_getController.bookingBusinessGetListByID.value, ''),
                                          Navigator.pop(context),
                                          showDialogValidation(context, 'Booking yaratildi', 'Booking yaratildi'),
                                          _tabController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.ease)
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
                      )
                    ]
                ),),
              ],
            )
        );
      },
    );
  }

  showBottomSheetFollowers(context, businessId, tabIndex) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    _getController.changeFollowers(Followers(res: [], status: false));
    ApiController().getMyFollowers(context,businessId);
    _followTabController = TabController(length: 2, vsync: Navigator.of(context));
    _followTabController.addListener(() {
      if (_followTabController.index == 0) {
        print('Obunachilar');
        ApiController().getMyFollowers(context,businessId);
      } else {
        print('Dostlar');
        ApiController().getMyFollowing(context,_getController.meUsers.value.res!.id!);
      }
    });
    _followTabController.animateTo(tabIndex, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: w,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Stack(
            children: [
              Positioned(child: Container(
                width: w,
                height: h * 0.16,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              )),
              Positioned(
                  width: w,
                  top: h * 0.01,
                  child: Center(
                    child: Container(
                      width: w * 0.3,
                      height: h * 0.005,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )),
              Positioned(
                top: h * 0.06,
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
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      controller: _followTabController,
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
                          child: SizedBox(
                            width: w * 0.6,
                            child: Center(
                              child: Text(
                                //Do`stlar
                                'Do\'stlar',
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
              Positioned(
                width: w,
                height: h * 0.7,
                top: h * 0.12,
                  child: TabBarView(
                    controller: _followTabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Obx(() => _getController.getFollowers.value.res!.isNotEmpty
                          ? Container(
                        margin: EdgeInsets.only(top: h * 0.02),
                        padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _getController.getFollowers.value.res!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: h * 0.08,
                              padding: EdgeInsets.only(left: w * 0.01, right: w * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200]!,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(bottom: h * 0.015),
                              child: Row(
                                children: [
                                  Container(
                                    width: w * 0.12,
                                    height: w * 0.12,
                                    margin: EdgeInsets.only(right: w * 0.04, left: w * 0.02),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(w),
                                      image: DecorationImage(
                                        image: NetworkImage('${_getController.getFollowers.value.res![index].photoUrl}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: w * 0.45,
                                    child: Text(
                                      '${_getController.getFollowers.value.res![index].userName}',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  if (_getController.getFollowers.value.res![index].businessId != 0)
                                    if (_getController.getFollowers.value.res![index].followed == false)
                                      InkWell(
                                      onTap: () {
                                        Loading.showLoading(context);
                                        ApiController().follow(_getController.getFollowers.value.res![index].businessId).then((value) => {
                                          if (value.status == true){
                                            ApiController().getMyFollowers(context,businessId),
                                            Navigator.pop(context),
                                            showDialogValidation(context, 'Obuna qilindi', 'Obuna qilindi'),
                                          } else {
                                            Navigator.pop(context),
                                            showDialogValidation(context, 'Obuna qilinmadi', 'Obuna qilinmadi'),
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: w * 0.2,
                                        height: h * 0.04,
                                        margin: EdgeInsets.only(right: w * 0.02),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.blue,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Obuna',
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: w * 0.035,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    else
                                      InkWell(
                                        onTap: () {
                                          Loading.showLoading(context);
                                          ApiController().unFollow(_getController.getFollowers.value.res![index].businessId).then((value) => {
                                            if (value == true){
                                              ApiController().getMyFollowers(context,businessId),
                                              ApiController().getMyFollowing(context,_getController.meUsers.value.res!.id!),
                                              Navigator.pop(context),
                                              showDialogValidation(context, 'Obuna bekor qilindi', 'Obuna bekor qilindi'),
                                            } else {
                                              Navigator.pop(context),
                                              showDialogValidation(context, 'Obuna bekor qilinmadi', 'Obuna bekor qilinmadi'),
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: w * 0.2,
                                          height: h * 0.04,
                                          margin: EdgeInsets.only(right: w * 0.02),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey[400],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Bekor',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                          : SizedBox(
                        child: Center(
                          child: Text(
                            'Obunachilar topilmadi',
                            style: TextStyle(
                              fontSize: w * 0.035,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                      Obx(() => _getController.getFollowing.value.res!.isNotEmpty
                          ? Container(
                        margin: EdgeInsets.only(top: h * 0.02),
                        padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _getController.getFollowing.value.res!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: h * 0.08,
                              padding: EdgeInsets.only(left: w * 0.01, right: w * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200]!,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(bottom: h * 0.015),
                              child: Row(
                                children: [
                                  Container(
                                    width: w * 0.12,
                                    height: w * 0.12,
                                    margin: EdgeInsets.only(right: w * 0.04, left: w * 0.02),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(w),
                                      image: DecorationImage(
                                        image: NetworkImage('${_getController.getFollowing.value.res![index].photoUrl}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: w * 0.45,
                                    child: Text(
                                      '${_getController.getFollowing.value.res![index].userName}',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  //button Dostlar
                                  InkWell(
                                    onTap: () {

                                    },
                                    child: Container(
                                      width: w * 0.2,
                                      height: h * 0.04,
                                      margin: EdgeInsets.only(right: w * 0.02),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Dostlar',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: w * 0.035,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                          : SizedBox(
                        child: Center(
                          child: Text(
                            'Dostlar topilmadi',
                            style: TextStyle(
                              fontSize: w * 0.035,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
              )
            ],
          ),
        );
      },
    );
  }

  void _onRefresh() async {
    ApiController().getMePostList(_getController.getProfileById.value.res?.id,3,0).then((value) => _refreshController.refreshCompleted());
  }

  void _onLoading() async {
    ApiController().getMePostList(_getController.getProfileById.value.res?.id, 3, _getController.lengthList.value).then((value) => _refreshController.loadComplete());
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    _getController.show.value = false;
    _tabController = TabController(length: 2, vsync: Navigator.of(context));
    ApiController().getMePostList(_getController.getProfileById.value.res?.id,3,0);
    ApiController().bookingListBookingAndBookingCategory(_getController.bookingBusinessGetListByID.value, '');
    ApiController().getMyFollowing(context, _getController.meUsers.value.res!.id!);
    _scrollControllerPage.addListener(() {
      if (_scrollControllerPage.position.userScrollDirection == ScrollDirection.reverse) {
        _getController.onScroll.value = true;
      } else {
        _getController.onScroll.value = false;
      }
      if (_scrollControllerPage.position.pixels == _scrollControllerPage.position.maxScrollExtent) {
        _getController.onScroll.value = true;
      }

    });
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
              title:  _getController.getProfileById.value.res == null
                  ? Text('Ma\'lumotlar yo\'q',
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w500,
                ))
                  : Text(_getController.getProfileById.value.res!.userName ?? '',
                style: TextStyle(
                  fontSize: w * 0.05,
                  fontWeight: FontWeight.w500,
                )
              ),
              centerTitle: true,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                  child: SingleChildScrollView(
                    controller: _scrollControllerPage,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getController.getProfileById.value.res == null
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
                                  radius: w * 0.12,
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
                        SizedBox(height: h * 0.02),
                        Center(child:_getController.getProfileById.value.res == null
                            ? Text('Salom, Mehmon', style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.w500))
                            : Text('${_getController.getProfileById.value.res!.fistName} ${_getController.getProfileById.value.res!.lastName}',
                            style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.w500))),
                        SizedBox(height: h * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                             _getController.getProfileById.value.res == null
                                ? const SizedBox()
                                : InkWell(
                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                _scrollControllerPage.animateTo(_scrollControllerPage.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                              },
                              child: UserDetIalWidget(labelText: 'Post', labelTextCount: '${_getController.meUsers.value.res?.business?.postsCount}',
                                icon: 1,
                              ),),
                             _getController.getProfileById.value.res == null
                                ? const SizedBox()
                                : InkWell(
                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                showBottomSheetFollowers(context,_getController.getProfileById.value.res!.id,0);
                              },
                              child: UserDetIalWidget(
                                labelText: 'Obunachilar',
                                labelTextCount: '${_getController.getProfileById.value.res?.followersCount}',
                                icon: 2,
                              ),
                            ),
                             _getController.getProfileById.value.res == null
                                ? const SizedBox()
                                : InkWell(
                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                showBottomSheetFollowers(context,_getController.getProfileById.value.res!.id,1);
                              },
                              child: UserDetIalWidget(
                                labelText: 'Do\'stlar',
                                labelTextCount:
                                '${_getController.getProfileById.value.res?.followingCount}',
                                icon: 3,
                              ),),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Foydalanuvchi haqida',
                                style: TextStyle(
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              InkWell(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  onTap: () {
                                    showDialogValidation(context, 'Foydalanuvchi haqida', '${_getController.getProfileById.value.res?.bio}');
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Batafsil',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(width: w * 0.01),
                                      HeroIcon(
                                        HeroIcons.chevronRight,
                                        color: Colors.blue,
                                        size: w * 0.04,
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02),
                          child: Text(
                            '${_getController.getProfileById.value.res?.bio}',
                            style: TextStyle(
                              fontSize: w * 0.04,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02, bottom: h * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Foydalanuvchi ma’lumotlari',
                                style: TextStyle(
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              InkWell(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  onTap: () {
                                    showDialogValidation(context, 'Foydalanuvchi ma’lumotlari', ''
                                        '${_getController.getProfileById.value.res?.phoneNumber}\n'
                                        '${_getController.getProfileById.value.res?.officeAddress}\n'
                                        '${_getController.getProfileById.value.res?.officeName}\n'
                                        '${_getController.getProfileById.value.res?.experience}\n'
                                        '${_getController.getProfileById.value.res?.categoryName}\n');
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Batafsil',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(width: w * 0.01),
                                      HeroIcon(
                                        HeroIcons.chevronRight,
                                        color: Colors.blue,
                                        size: w * 0.04,
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                        //Obx(() => _getController.meUsers.value.res?.business != null
                         _getController.getProfileById.value.res != null
                             ? Padding(
                            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, bottom: h * 0.02),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //Text(_getController.meUsers.value.res?.business?.categoryName ?? '',
                                    Text(_getController.getProfileById.value.res?.categoryName ?? '',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: w * 0.02),
                                    Text(
                                      //_getController.meUsers.value.res?.business?.experience == null ? '' : '${_getController.meUsers.value.res?.business?.experience} yillik ish tajribasi',
                                      _getController.getProfileById.value.res?.experience == null ? '' : '${_getController.getProfileById.value.res?.experience} yillik ish tajribasi',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: h * 0.01),
                                TextEditButton(
                                  //text: '${_getController.meUsers.value.res?.phoneNumber}',
                                  text: '${_getController.getProfileById.value.res?.phoneNumber}',
                                  color: Colors.blue,
                                  icon: 'assets/images/user_call.png',
                                ),
                                TextEditButton(
                                  //text: '${_getController.meUsers.value.res?.business?.officeAddress}',
                                  text: '${_getController.getProfileById.value.res?.officeAddress}',
                                  color: Colors.blue,
                                  icon: 'assets/images/user_location.png',
                                ),
                                TextEditButton(
                                  //text: '${_getController.meUsers.value.res?.business?.officeName}',
                                  text: '${_getController.getProfileById.value.res?.officeName}',
                                  color: Colors.blue,
                                  icon: 'assets/images/user_work.png',
                                ),
                              ],
                            )
                        )
                             : const SizedBox(),
                         _getController.getFollowing.value.res != null && _getController.getFollowing.value.res!.isNotEmpty
                             ? Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, bottom: h * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Dostlar',
                                style: TextStyle(
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              InkWell(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  onTap: () {
                                    showBottomSheetFollowers(context,_getController.getProfileById.value.res!.id,1);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Batafsil',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(width: w * 0.01),
                                      HeroIcon(
                                        HeroIcons.chevronRight,
                                        color: Colors.blue,
                                        size: w * 0.04,
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        )
                             : const SizedBox(),
                         _getController.getFollowing.value.res != null && _getController.getFollowing.value.res!.isNotEmpty
                            ? SizedBox(
                          height: h * 0.15,
                          width: w * 0.95,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _getController.getFollowing.value.res!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                overlayColor: MaterialStateProperty.all(Colors.transparent),
                                onTap: () {
                                  Loading.showLoading(context);
                                  ApiController().profileById(int.parse(_getController.getFollowing.value.res![index].id.toString())).then((value) => {_getController.changeProfileById(value),
                                    Navigator.pop(context),
                                    _getController.changeBookingBusinessGetListByID(int.parse(_getController.getFollowing.value.res![index].id.toString())),
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails()))
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: w * 0.15,
                                        height: w * 0.15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(w),
                                          image: DecorationImage(
                                            image: NetworkImage('${_getController.getFollowing.value.res![index].photoUrl}'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: h * 0.01),
                                      SizedBox(
                                        width: w * 0.17,
                                        child: Text(
                                          '${_getController.getFollowing.value.res![index].fistName}',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                             : const SizedBox(),
                        //ish jadvali button
                        Center(
                          child: SizedBox(
                            width: w * 0.9,
                            child:ElevatedButton(
                              onPressed: () {
                                showBottomSheetList(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Ish jadvali',
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //postlar
                        //Obx(() => _getController.meUsers.value.res?.business != null
                         _getController.getProfileById.value.res != null
                            ? Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, bottom: h * 0.02, top: h * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Postlar',
                                style: TextStyle(
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                        )
                             : const SizedBox(),
                         _getController.getPostList.value.res == null || _getController.getPostList.value.res!.isEmpty
                             ? SizedBox(
                          width: w,
                          height: h * 0.6,
                          child: const Center(child: Text('Ma\'lumotlar topilmadi'),),
                        )
                             : SizedBox(
                          height: h * 0.6,
                          child: SizedBox(
                            width: w,
                            child: SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: true,
                              header: CustomHeader(
                                builder: (BuildContext
                                context, RefreshStatus?mode) {
                                  Widget body;
                                  if (mode == RefreshStatus.idle) {
                                    body = const Text("Ma`lumotlarni yangilash uchun tashlang");
                                  } else if (mode == RefreshStatus.refreshing) {
                                    body = const CircularProgressIndicator(
                                      color: Colors.blue,
                                      backgroundColor: Colors.white,
                                      strokeWidth: 2,
                                    );
                                  } else if (mode == RefreshStatus.failed) {
                                    body = const Text("Yuklashda xatolik");
                                  } else if (mode == RefreshStatus.canRefresh) {
                                    body = const Text("Ma`lumotlarni yangilash uchun tashlang");
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
                                builder: (BuildContext
                                context, LoadStatus?mode) {
                                  Widget body;
                                  if (mode == LoadStatus.idle) {
                                    body = const SizedBox();
                                  } else if (mode == LoadStatus.loading) {
                                    body = const CircularProgressIndicator(
                                      color: Colors.blue,
                                      backgroundColor:
                                      Colors.white,
                                      strokeWidth: 2,
                                    );
                                  } else if (mode == LoadStatus.failed) {
                                    body = const Text("Yuklashda xatolik");
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
                              controller:
                              _refreshController,
                              onRefresh: _onRefresh,
                              onLoading: _onLoading,
                              child:
                              ListView.builder(
                                  //itemCount: _getController.getPostList.value.res!.length,
                                  itemCount: _getController.lengthList.value,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsPage(postId: _getController.getPostList.value.res![index].id,)));
                                      },
                                      child:
                                      Column(
                                        children: [
                                           _getController.getPostList.value.res![index].mediaType == 'video'
                                               ? Stack(
                                            children: [
                                              if (_getController.getPostList.value.res![index].photo != '')
                                                Container(
                                                  width: w,
                                                  height: h * 0.6,
                                                  padding: EdgeInsets.all(w * 0.01),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage('${_getController.getPostList.value.res![index].photo}'),
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                              if (_getController.getPostList.value.res![index].photo == '')
                                                Container(
                                                  width: w,
                                                  height: h * 0.6,
                                                  padding: EdgeInsets.all(w * 0.01),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              Positioned(
                                                  width: w,
                                                  height: h * 0.6,
                                                  child: Center(
                                                    child: Container(
                                                      padding: EdgeInsets.all(w * 0.025),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black.withOpacity(0.5),
                                                        borderRadius: BorderRadius.circular(w * 0.1),
                                                      ),
                                                      child: HeroIcon(
                                                        HeroIcons.play,
                                                        color: Colors.white,
                                                        size: w * 0.05,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          )
                                               : Container(
                                            width: w,
                                            height: h * 0.6,
                                            padding: EdgeInsets.all(w * 0.01),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage('${_getController.getPostList.value.res![index].photo}'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: w,
                                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Column(
                                                      children: [
                                                         _getController.getPostList.value.res![index].title == '' && _getController.getPostList.value.res![index].description == ''
                                                            ? const SizedBox()
                                                            : SizedBox(
                                                          width: w * 0.9,
                                                          child: Text('${_getController.getPostList.value.res![index].title}',
                                                            style: TextStyle(
                                                              fontSize: w * 0.04,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                         _getController.getPostList.value.res![index].title == '' && _getController.getPostList.value.res![index].description == ''
                                                            ? const SizedBox()
                                                            : SizedBox(
                                                          width: w * 0.9,
                                                          child: ReadMoreText('${_getController.getPostList.value.res![index].description}',
                                                            trimLines: 2,
                                                            colorClickableText: Colors.blue,
                                                            trimMode: TrimMode.Line,
                                                            trimCollapsedText: ' Ko\'proq',
                                                            trimExpandedText: ' Yashirish',
                                                            style: TextStyle(
                                                              fontSize: w * 0.04,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                            moreStyle: TextStyle(
                                                              fontSize: w * 0.035,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                            lessStyle: TextStyle(
                                                              fontSize: w * 0.035,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                SizedBox(
                                                    child: IconButton(
                                                      onPressed: () {
                                                      },
                                                      icon: HeroIcon(
                                                        HeroIcons.ellipsisVertical,
                                                        color: Colors.black,
                                                        size: w * 0.05,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            )
          ],
        )),
      floatingActionButton: Obx(() => _getController.onScroll.value == true
          ? FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.1),
              ),
              onPressed: () {
                _scrollControllerPage.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              },
              backgroundColor: Colors.blue,
              child: HeroIcon(
                HeroIcons.arrowUp,
                color: Colors.white,
                size: w * 0.05,
              ),
            )
          : const SizedBox()),
    );

  }
}
