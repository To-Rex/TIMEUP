import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../api/api_controller.dart';
import '../res/getController.dart';

class ProfessionsListElements extends StatelessWidget {
  int? index;
  final Function(String) onTap;

  ProfessionsListElements({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);
  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    ApiController().getSubCategory(index!.toInt()).then((value) => {
          _getController.changeSubCategory(value),
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
    ApiController().getSubCategory(index!.toInt()).then((value) => {
          _getController.changeSubCategory(value),
          _getController.changeTitleListElements(
              _getController.category.value.res![index!].name!)
        });
    return Column(
      children: [
        SizedBox(
            height: h * 0.06,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                _getController.clearSubCategory();
                _getController.enters.value = 0;
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.black, size: w * 0.05),
            ),
            title: const Text(
              'Tibbiyot Kasblar royhati',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),

        Obx(
          () => _getController.subCategory.value.res == null
              ? const Center(child: Text('No data'))
              : SizedBox(
                  height: h * 0.74,
                  width: w * 0.95,
                  child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: CustomHeader(
                        builder: (BuildContext context, RefreshStatus? mode) {
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
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              _getController.categoryByID.value = _getController
                                  .subCategory.value.res![index].id!;
                              _getController.enters.value = 2;
                              _getController.changeTitleListElements(
                                  _getController
                                      .subCategory.value.res![index].name!);
                            },
                            child: Container(
                              height: h * 0.04,
                              width: w * 0.98,
                              margin: EdgeInsets.only(bottom: h * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: w * 0.02),
                                      Text(_getController.subCategory.value.res?[index].name ?? '',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Icon(Icons.arrow_forward_ios, size: w * 0.04),
                                      SizedBox(width: w * 0.02),
                                    ],
                                  ),
                                  SizedBox(height: h * 0.01),
                                  Divider(
                                    color: Colors.grey[300],
                                    thickness: 1,
                                    height: 1,
                                  ),
                                ],
                              )
                            ),
                          );
                        },
                        itemCount: _getController.subCategory.value.res?.length,
                        cacheExtent: w * 0.1,
                        dragStartBehavior: DragStartBehavior.down,
                        prototypeItem: Container(
                          height: h * 0.04,
                          margin: EdgeInsets.only(bottom: h * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(w * 0.02),
                          ),
                        ),
                      )),
                ),
        ),
      ],
    );
  }
}
