import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:time_up/api/api_controller.dart';

import '../res/getController.dart';

class ProfessionsList extends StatelessWidget {
  final Function(int) onTap;

  ProfessionsList({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    ApiController().getCategory().then((value) => {
          _getController.changeCategory(value),
          _refreshController.refreshCompleted(),
        });
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    ApiController().getCategory();
    /*return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Kasblar royhati',
          style: TextStyle(
            fontSize: w * 0.05,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: h * 0.02),
        Obx(() => _getController.category.value.res == null
            ? const Center(child: Text('No data'))
            : Obx(() => _getController.category.value.res!.isNotEmpty
                ? SizedBox(
                    width: w,
                    height: h * 0.74,
                    child: SmartRefresher(
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
                            body = const Text("Load Failed!Click retry!");
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
                        itemCount: _getController.category.value.res?.length ?? 0,
                        padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _getController.changeOccupation(_getController.category.value.res?[index].name ?? '');
                              onTap(_getController.category.value.res?[index].id ?? 0);
                            },
                            child: Container(
                              height: h * 0.06,
                              margin: EdgeInsets.only(bottom: h * 0.02),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(w * 0.02),
                              ),
                              child: Center(
                                child: Text(
                                  _getController.category.value.res?[index].name ?? '',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : const Center(child: Text('No data')))),
      ],
    );*/
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              child: Container(
                  height: h * 0.2,
                  width: w,
                  margin: EdgeInsets.only(bottom: h * 0.02),
                  color: Colors.blue,
                  child: Column(
                    children: [
                      SizedBox(height: h * 0.03),
                      Text(
                        'Kasblar royhati',
                        style: TextStyle(
                          fontSize: w * 0.05,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
            ),
            Positioned(
              top: h * 0.15,
              child: Container(
                  height: h * 0.1,
                  width: w * 0.9,
                  margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.04),
                      HeroIcon(
                        HeroIcons.userCircle,
                        color: Colors.orangeAccent,
                        size: w * 0.1,
                      ),
                      SizedBox(width: w * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Admin bilan aloqa',
                            style: TextStyle(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            'Taklif va shukoyatlar uchun',
                            style: TextStyle(
                              fontSize: w * 0.03,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        height: h * 0.04,
                        width: w * 0.08,
                        margin: EdgeInsets.only(right: w * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: HeroIcon(
                            HeroIcons.phone,
                            color: Colors.white,
                            size: w * 0.05,
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),
            Positioned(
              top: h * 0.15,
              bottom: 0,
              child: Container(
                width: w,
                margin: EdgeInsets.only(top: h * 0.15),
                color: Colors.white,
                child: Obx(() => _getController.category.value.res == null
                    ? const Center(child: Text('No data'))
                    : Obx(() => _getController.category.value.res!.isNotEmpty
                    ? SizedBox(
                    width: w,
                    child: SmartRefresher(
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
                            body = const Text("Load Failed!Click retry!");
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
                        itemCount: _getController.category.value.res?.length ?? 0,
                        padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _getController.changeOccupation(_getController.category.value.res?[index].name ?? '');
                              onTap(_getController.category.value.res?[index].id ?? 0);
                            },
                            child: Container(
                              height: h * 0.06,
                              margin: EdgeInsets.only(bottom: h * 0.02),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(w * 0.02),
                              ),
                              child: Center(
                                child: Text(
                                  _getController.category.value.res?[index].name ?? '',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ))
                    : const Center(child: Text('No data')))),
              ),),
          ],
        ),
      )
    );
  }
}
