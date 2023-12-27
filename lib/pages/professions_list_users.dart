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

  showLoadingDialog(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
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
                  backgroundColor: Colors.grey,
                  strokeWidth: 2,
                ),
              ),
              SizedBox(
                width: w * 0.07,
              ),
              Text(
                'Kuting...',
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

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    _getController.clearByCategory();
    ApiController().getByCategory(_getController.categoryByID.value).then((value) => _getController.changeByCategory(value));
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              _getController.enters.value = 1;
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          title: Obx(() => _getController.titleListElements.value == ''
              ? Center(child: Text('Ma\'lumotlar yo\'q', style: TextStyle(fontSize: w * 0.04)))
              : Text(
                  _getController.titleListElements.value,
                  style: TextStyle(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          centerTitle: true,
        ),
        //SizedBox(height: h * 0.02),
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
    );
  }
}
