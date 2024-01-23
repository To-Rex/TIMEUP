import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/elements/functions.dart';
import 'package:time_up/pages/professions_list_details.dart';
import '../res/getController.dart';

class ProfessionsListUsers extends StatelessWidget {
  final Function(String) onTap;

  ProfessionsListUsers({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    ApiController().getByCategory(_getController.categoryByID.value).then((value) => _refreshController.refreshCompleted());
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    _getController.clearByCategory();
    ApiController().getByCategory(_getController.categoryByID.value).then((value) => _getController.changeByCategory(value));
    /*return Column(
      children: [
        AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              _getController.enters.value = 1;
            },
            child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: w * 0.06,
            ),
          ),
          title: Obx(() => _getController.titleListElements.value == ''
              ? Center(child: Text('Ma\'lumotlar yo\'q', style: TextStyle(fontSize: w * 0.04)))
              : Text(
                  _getController.titleListElements.value,
                  style: TextStyle(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )),
          centerTitle: true,
        ),
        Container(
          color: Colors.white,
          height: h * 0.74,
          width: w,
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          child: Obx(
            () => _getController.getByCategory.value.res == null || _getController.getByCategory.value.res!.isEmpty
                ? Center(child: Text('Ma`lumotlar yo`q', style: TextStyle(fontSize: w * 0.04)))
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: CustomHeader(
                      builder: (BuildContext context, RefreshStatus? mode) {
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
                          body = const Text("Ex Nimadir Xato ketdi");
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
                          body = const Text("Ex Nimadir Xato ketdi");
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
                      itemBuilder: (context, index) {
                        if (_getController.getByCategory.value.res?[index].userId != _getController.meUsers.value.res?.business?.userId) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              showLoadingDialog(context);
                              ApiController().profileById(_getController.getByCategory.value.res![index].businessId!).then((value) => {
                                Navigator.pop(context),
                                _getController.bookingBusinessGetListByID.value = _getController.getByCategory.value.res![index].businessId!,
                                _getController.nextPagesUserDetails.value = 0,
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails())),
                              });
                            },
                            child: Container(
                              height: h * 0.1,
                              width: w * 0.9,
                              margin: EdgeInsets.only(bottom: h * 0.02),
                              child: Row(
                                children: [
                                  if (_getController.getByCategory.value.res?[index].photoUrl == null)
                                    SizedBox(
                                      width: w * 0.15,
                                      height: w * 0.15,
                                      child: const CircleAvatar(backgroundImage: AssetImage('assets/images/doctor.png'),),
                                    )
                                  else
                                    SizedBox(
                                      width: w * 0.15,
                                      height: w * 0.15,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage("${_getController.getByCategory.value.res![index].photoUrl}"),
                                      ),
                                    ),
                                  SizedBox(width: w * 0.05),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _getController.getByCategory.value.res?[index].lastName ?? '',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        _getController.getByCategory.value.res?[index].fistName ?? '',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Expanded(child: SizedBox()),
                                  if (_getController.getByCategory.value.res?[index].userId != _getController.meUsers.value.res?.business?.userId)
                                    Obx(() => _getController.getByCategory.value.res?[index].followed == true
                                        ? SizedBox(
                                      height: h * 0.045,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ApiController().unFollow(_getController.getByCategory.value.res?[index].businessId ?? 0).then((value) => {
                                            if (value == true){
                                                ApiController().getByCategory(_getController.categoryByID.value).then((value) => _getController.changeByCategory(value))
                                              } else {
                                                Toast.showToast(context, 'Nimadir xato ketdi', Colors.red, Colors.white),
                                              }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          backgroundColor: Colors.grey,
                                        ),
                                        child: Text(
                                          'Do\'stlar',
                                          style: TextStyle(
                                            fontSize: w * 0.03,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                        : SizedBox(
                                      height: h * 0.045,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ApiController().follow(_getController.getByCategory.value.res?[index].businessId ?? 0).then((value) => {
                                            if (value.status == true){
                                                ApiController().getByCategory(_getController.categoryByID.value).then((value) => _getController.changeByCategory(value))
                                              } else {
                                                Toast.showToast(context, 'Nimadir xato ketdi', Colors.red, Colors.white),
                                              }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          backgroundColor: Colors.blue,
                                        ),
                                        child: Text(
                                          'Obuna bo\'lish',
                                          style: TextStyle(
                                            fontSize: w * 0.03,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )),
                                ],
                              ),
                            ),
                          );
                        }else {
                          return const SizedBox();
                        }
                      },
                      itemCount: _getController.getByCategory.value.res?.length ?? 0,
                    ),
                  ),
          ),
        ),
      ],
    );*/
    return Expanded(
      child: SizedBox(
        child: Stack(
          children: [
            Positioned(
                top: h * 0,
                width: w,
                child: AppBar(
                  backgroundColor: Colors.blue,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () {
                      onTap('back');
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: w * 0.06,
                    ),
                  ),
                  title: Text(
                    'Kasb egalari',
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                )
            ),
            Positioned(
              top: h * 0.12,
                bottom: 0,
                child: Container(
                  width: w,
                  height: h * 0.1,
                  color: Colors.white,
                )
            ),
            Positioned(
              width: w,
              height: h * 0.06,
              top: h * 0.09,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: w * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  //appBar title
                  child: Center(
                    child: Obx(() => _getController.titleListElements.value == ''
                        ? Center(child: Text('Ma\'lumotlar yo\'q', style: TextStyle(fontSize: w * 0.04)))
                        : Text(
                      _getController.titleListElements.value,
                      style: TextStyle(
                        fontSize: w * 0.045,
                        color: Colors.black,
                      ),
                    )),
                  )
                )
            ),
            Positioned(
              top: h * 0.18,
              width: w,
              bottom: 0,
                child: Obx(
                      () => _getController.getByCategory.value.res == null || _getController.getByCategory.value.res!.isEmpty
                      ? Center(child: Text('Ma`lumotlar yo`q', style: TextStyle(fontSize: w * 0.04)))
                      : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: CustomHeader(
                      builder: (BuildContext context, RefreshStatus? mode) {
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
                          body = const Text("Ex Nimadir Xato ketdi");
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
                          body = const Text("Ex Nimadir Xato ketdi");
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
                      itemBuilder: (context, index) {
                        if (_getController.getByCategory.value.res?[index].userId != _getController.meUsers.value.res?.business?.userId) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Loading.showLoading(context);
                              ApiController().profileById(_getController.getByCategory.value.res![index].businessId!).then((value) => {
                                Navigator.pop(context),
                                _getController.bookingBusinessGetListByID.value = _getController.getByCategory.value.res![index].businessId!,
                                _getController.nextPagesUserDetails.value = 0,
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails())),
                              });
                            },
                            child: Container(
                              height: h * 0.1,
                              width: w,
                              margin: EdgeInsets.only(bottom: h * 0.02, left: w * 0.04, right: w * 0.04),
                              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  if (_getController.getByCategory.value.res?[index].photoUrl == null)
                                    SizedBox(
                                      width: w * 0.15,
                                      height: w * 0.15,
                                      child: const CircleAvatar(backgroundImage: AssetImage('assets/images/doctor.png'),),
                                    )
                                  else
                                    SizedBox(
                                      width: w * 0.15,
                                      height: w * 0.15,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage("${_getController.getByCategory.value.res![index].photoUrl}"),
                                      ),
                                    ),
                                  SizedBox(width: w * 0.05),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _getController.getByCategory.value.res?[index].lastName ?? '',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        _getController.getByCategory.value.res?[index].fistName ?? '',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Expanded(child: SizedBox()),
                                  if (_getController.getByCategory.value.res?[index].userId != _getController.meUsers.value.res?.business?.userId)
                                    Obx(() => _getController.getByCategory.value.res?[index].followed == true
                                        ? SizedBox(
                                      height: h * 0.045,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ApiController().unFollow(_getController.getByCategory.value.res?[index].businessId ?? 0).then((value) => {
                                            if (value == true){
                                              ApiController().getByCategory(_getController.categoryByID.value).then((value) => _getController.changeByCategory(value))
                                            } else {
                                              Toast.showToast(context, 'Nimadir xato ketdi', Colors.red, Colors.white),
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          backgroundColor: Colors.grey,
                                        ),
                                        child: Text(
                                          'Do\'stlar',
                                          style: TextStyle(
                                            fontSize: w * 0.03,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                        : SizedBox(
                                      height: h * 0.045,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ApiController().follow(_getController.getByCategory.value.res?[index].businessId ?? 0).then((value) => {
                                            if (value.status == true){
                                              ApiController().getByCategory(_getController.categoryByID.value).then((value) => _getController.changeByCategory(value))
                                            } else {
                                              Toast.showToast(context, 'Nimadir xato ketdi', Colors.red, Colors.white),
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          backgroundColor: Colors.blue,
                                        ),
                                        child: Text(
                                          'Obuna bo\'lish',
                                          style: TextStyle(
                                            fontSize: w * 0.03,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )),
                                ],
                              ),
                            ),
                          );
                        }else {
                          return const SizedBox();
                        }
                      },
                      itemCount: _getController.getByCategory.value.res?.length ?? 0,
                    ),
                  ),
                ),
            )
          ],
        ),
      )
    );
  }
}
