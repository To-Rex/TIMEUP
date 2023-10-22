import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/getController.dart';

class ProfessionsListDetails extends StatelessWidget {
  ProfessionsListDetails({Key? key}) : super(key: key);

  final GetController _getController = Get.put(GetController());
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
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
              ? const Center(child: Text('No data'))
              : SizedBox(
              child: _getController.getProfileById.value.res!.photoUrl == null
                  ? const CircleAvatar(backgroundImage: AssetImage('assets/images/doctor.png'),)
                  : Row(
                children: [
                  SizedBox(width: w * 0.04),
                  CircleAvatar(
                    radius: w * 0.18,
                    backgroundImage: NetworkImage("http://${_getController.getProfileById.value.res!.photoUrl}",),),
                ],
              )
          )),
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
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(3),
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
                      const Expanded(child: SizedBox()),
                      Container(
                          height: h * 0.05,
                          padding:
                              EdgeInsets.only(left: w * 0.02, right: w * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Center(
                            child: Text(
                              'Ish jadvali',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      const Expanded(child: SizedBox()),
                      Container(
                          width: w * 0.2,
                          height: h * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Center(
                            child: Text(
                              'Booking',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      const Expanded(child: SizedBox()),
                      Container(
                        alignment: Alignment.center,
                        width: w * 0.1,
                        height: h * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                            () => _getController.getProfileById.value.res == null
                                    ? const SizedBox()
                                    : Text(
                                        _getController.getProfileById.value.res!.bio ?? '',
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
                            () =>
                                _getController.getProfileById.value.res == null
                                    ? const SizedBox()
                                    : Text(
                                        _getController.getProfileById.value.res!
                                                .bio ?? '',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                          ),
                        ),
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
