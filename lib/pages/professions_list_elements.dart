import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:time_up/pages/post_details.dart';
import '../api/api_controller.dart';
import '../res/getController.dart';

class ProfessionsListElements extends StatelessWidget {
  int? index;
  final Function(String) onTap;

  ProfessionsListElements({Key? key, required this.index, required this.onTap,}) : super(key: key);

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  var scrollController = ScrollController();

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
          //_getController.changeTitleListElements(_getController.category.value.res![index!].name!)
        });
    /*return Column(
      children: [
        SizedBox(height: h * 0.06,
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
            title: Obx(() => Text(
              _getController.occupation.value,
              style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )),
            centerTitle: true,
          ),
        ),

        Obx(() => _getController.subCategory.value.res == null
              ? Center(child: Text('Ma`lumotlar yo`q', style: TextStyle(fontSize: w * 0.04)))
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
                          return InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              _getController.categoryByID.value = _getController.subCategory.value.res![index].id!;
                              _getController.enters.value = 2;
                              _getController.changeTitleListElements(_getController.subCategory.value.res![index].name!);
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
    );*/
    return Expanded(
        child: Stack(children: [
          Positioned(
            child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                _getController.clearSubCategory();
                _getController.enters.value = 0;
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white, size: w * 0.05),
            ),
            title: Obx(() => Text(
              _getController.occupation.value,
              style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            )),
            centerTitle: true),
          ),
          Positioned(
              top: h * 0.04,
              child: SizedBox(
                height: h * 0.2,
                width: w,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: w * 0.05),
                      height: h * 0.03,
                      width: w * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: InkWell(
                        onTap: () {
                          scrollController.animateTo(
                            scrollController.offset - w * 0.3,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Center(
                          child: HeroIcon(
                            HeroIcons.chevronLeft,
                            color: Colors.blue,
                            size: w * 0.05,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: w * 0.05),
                          child: Obx(() => _getController.getFollowPost.value.res!.isNotEmpty
                              ? SizedBox(
                            height: h * 0.11,
                            child: ListView(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              semanticChildCount: _getController.getFollowPost.value.res!.length,
                              children: [
                                for (int i = 0; i < _getController.getFollowPost.value.res!.length; i++)
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsPage(postId: _getController.getFollowPost.value.res?[i].id)));
                                    },
                                    child: Container(
                                      height: h * 0.03,
                                      width: w * 0.3,
                                      margin: EdgeInsets.only(right: w * 0.02),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image: NetworkImage('${_getController.getFollowPost.value.res?[i].photo}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                              ],),
                          ) : const SizedBox()
                          ),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(right: w * 0.05, left: w * 0.05),
                      height: h * 0.03,
                      width: w * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: InkWell(
                        onTap: () {
                          scrollController.animateTo(
                            scrollController.offset + w * 0.3,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Center(
                          child: HeroIcon(
                            HeroIcons.chevronRight,
                            color: Colors.blue,
                            size: w * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
          Positioned(
              top: h * 0.23,
              bottom: 0,
              child: Container(
                width: w,
                color: Colors.white,
                child: Obx(() => _getController.subCategory.value.res == null || _getController.subCategory.value.res!.isEmpty
                    ? SizedBox(
                  //height: h * 0.755,
                  width: w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text('Ma`lumotlar yo`q', style: TextStyle(fontSize: w * 0.04)),
                      SizedBox(height: h * 0.2),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ) : Container(
                  //height: h * 0.6,
                  width: w * 0.9,
                  margin: EdgeInsets.only(top: h * 0.02),
                  padding: EdgeInsets.only(bottom: h * 0.03),
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
                      itemCount: _getController.subCategory.value.res?.length,
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _getController.categoryByID.value = _getController.subCategory.value.res![index].id!;
                            _getController.enters.value = 2;
                            _getController.changeTitleListElements(_getController.subCategory.value.res![index].name!);
                          },
                          child: Container(
                            height: h * 0.06,
                            margin: EdgeInsets.only(bottom: h * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(w * 0.02),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: w * 0.04),
                                SizedBox(
                                  width: w * 0.6,
                                  child: Text(
                                    _getController.subCategory.value.res?[index].name ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Container(
                                  width: w * 0.08,
                                  height: h * 0.04,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.blue,
                                      size: w * 0.05,
                                    ),
                                  ),
                                ),
                                SizedBox(width: w * 0.04),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ),
              )
          )
        ],
    ));
  }
}
