import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/elements/functions.dart';
import '../pages/post_details.dart';
import '../pages/professions_list_details.dart';
import '../res/getController.dart';
import 'package:readmore/readmore.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GetController _getController = Get.put(GetController());
  var _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    if (_getController.meUsers.value.res == null) {
      ApiController().getUserData();
    }
    ApiController().getFollowPostList(3, 0);

    void onRefresh() async {
      _getController.getFollowPost.value.res?.clear();
      ApiController().getFollowPostList(3, 0).then((value) => {
        _refreshController.refreshCompleted(),
      });
    }

    void onLoading() async {
      print('lengthList: ${_getController.getFollowPost.value.res?.length}');
      print('lengthList: ${_getController.getFollowPost.value.res!.length + 1}');
      print('lengthList: ${_getController.lengthList.value}');

      ApiController().getFollowPostList(3, _getController.lengthList.value
      ).then((value) => {
        _refreshController.loadComplete(),
      });
    }

    return Obx(() => _getController.getFollowPost.value.res == null || _getController.getFollowPost.value.res!.isEmpty
        ? SizedBox(
      width: w,
      height: h * 0.9,
      child: Center(child: Text('Ma`lumotlar yo\'q',style: TextStyle(fontSize: w * 0.04, color: Colors.black))),
    ) : Obx(() => _getController.getFollowPost.value.res!.isNotEmpty || _getController.getFollowPost.value.res != null
        ? _getController.uplAodVideo.value == true
        ? SizedBox(
      width: w,
      height: h * 0.75,
      child: ListView.builder(
          controller: _scrollController,
          itemCount: _getController.getFollowPost.value.res?.length ?? 0,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(height: h * 0.02),
                if (_getController.getFollowPost.value.res?[index].posterPhotoUrl != null)
                  InkWell(
                    onTap: () {
                      Loading.showLoading(context);
                      ApiController().profileById(int.parse(_getController.getFollowPost.value.res![index].businessId.toString())).then((value) => {_getController.changeProfileById(value),
                        Navigator.pop(context),
                        _getController.changeBookingBusinessGetListByID(int.parse(_getController.getFollowPost.value.res![index].businessId.toString())),
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails()))
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: w * 0.9,
                          child: Row(
                            children: [
                              SizedBox(width: w * 0.03),
                              SizedBox(
                                width: w * 0.11,
                                height: w * 0.11,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('${_getController.getFollowPost.value.res?[index].posterPhotoUrl}'),
                                ),
                              ),
                              SizedBox(width: w * 0.02),
                              SizedBox(
                                width: w * 0.6,
                                child: Text('${_getController.getFollowPost.value.res?[index].posterName}',
                                  style: TextStyle(
                                    fontSize: w * 0.05,
                                    fontWeight:
                                    FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: h * 0.02),
                if (_getController.getFollowPost.value.res?[index].photo != null)
                  SizedBox(
                    width: w,
                    height: h * 0.6,
                    child: Obx(() => _getController.getFollowPost.value.res?[index].mediaType == 'video'
                        ? Stack(
                      children: [
                        SizedBox(
                          width: w,
                          height: h * 0.6,
                          child: Image.network('${_getController.getFollowPost.value.res?[index].photo}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                            height: h * 0.6,
                            width: w,
                            child: Center(
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsPage(postId: _getController.getFollowPost.value.res?[index].id)));
                                    },
                                    icon: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: w * 0.1,
                                    )),
                              ),
                            )),
                      ],
                    ) : InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsPage(postId: _getController.getFollowPost.value.res?[index].id)));
                      },
                      child: SizedBox(
                        width: w,
                        height: h * 0.6,
                        child: Image.network('${_getController.getFollowPost.value.res?[index].photo}', fit: BoxFit.cover,),
                      ),
                    )),
                  ),
                SizedBox(height: h * 0.02),
                SizedBox(
                  width: w * 0.95,
                  child: Row(
                    children: [
                      SizedBox(
                        height: w * 0.07,
                        width: w * 0.07,
                        child: IconButton(
                            hoverColor: Colors.blue,
                            iconSize: w * 0.07,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              ApiController().profileById(int.parse(_getController.getFollowPost.value.res![index].businessId.toString())).then((value) => {
                                _getController.changeProfileById(value),
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails()));
                            },
                            icon: HeroIcon(
                              HeroIcons.heart,
                              color: Colors.blue,
                              size: w * 0.07,
                            )),
                      ),
                      SizedBox(width: w * 0.01),
                      SizedBox(
                        height: w * 0.07,
                        width: w * 0.07,
                        child: IconButton(
                            hoverColor: Colors.blue,
                            iconSize: w * 0.07,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: HeroIcon(
                              HeroIcons.phone,
                              color: Colors.blue,
                              size: w * 0.07,
                            )),
                      ),
                      SizedBox(width: w * 0.01),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        height: w * 0.07,
                        width: w * 0.07,
                        child: IconButton(
                            hoverColor: Colors.blue,
                            iconSize: w * 0.07,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: HeroIcon(
                              HeroIcons.bookmark,
                              color: Colors.blue,
                              size: w * 0.07,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.02),
                SizedBox(
                  width: w * 0.9,
                  child: Text(
                    '${_getController.getFollowPost.value.res?[index].title}',
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                SizedBox(
                  width: w * 0.9,
                  child: ReadMoreText(
                    '${_getController.getFollowPost.value.res?[index].description}',
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Koproq',
                    trimExpandedText: ' Yashirish',
                    moreStyle: TextStyle(
                      fontSize: w * 0.03,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                    lessStyle: TextStyle(
                      fontSize: w * 0.03,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                    style: TextStyle(
                      fontSize: w * 0.035,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.01,
                ),
              ],
            );
          }),
    )
        : SizedBox(
      width: w,
      height: h * 0.83,
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: CustomHeader(
          builder:
              (BuildContext context, RefreshStatus? mode) {
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
              body = const Text("Ex nimadir xato ketdi", style: TextStyle(fontSize: 14, color: Colors.red));
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
              body = const Text("Ex nimadir xato ketdi", style: TextStyle(fontSize: 14, color: Colors.red));
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
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: ListView.builder(
            controller: _scrollController,
            //itemCount: _getController.getFollowPost.value.res?.length ?? 0,
            itemCount: _getController.lengthList.value,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(height: h * 0.02),
                  if (_getController.getFollowPost.value.res?[index].posterPhotoUrl != null)
                    InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Loading.showLoading(context);
                        ApiController().profileById(int.parse(_getController.getFollowPost.value.res![index].businessId.toString())).then((value) => {_getController.changeProfileById(value),
                          Navigator.pop(context),
                          _getController.changeBookingBusinessGetListByID(int.parse(_getController.getFollowPost.value.res![index].businessId.toString())),
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails()))
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: w * 0.9,
                            child: Row(
                              children: [
                                SizedBox(width: w * 0.03),
                                SizedBox(
                                  width: w * 0.11,
                                  height: w * 0.11,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage('${_getController.getFollowPost.value.res?[index].posterPhotoUrl}'),
                                  ),
                                ),
                                SizedBox(width: w * 0.02),
                                SizedBox(
                                  width: w * 0.6,
                                  child: Text(
                                    '${_getController.getFollowPost.value.res?[index].posterName}',
                                    style: TextStyle(
                                      fontSize: w * 0.05,
                                      fontWeight:
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: h * 0.02),
                  if (_getController.getFollowPost.value.res?[index].photo != null)
                    SizedBox(
                      width: w,
                      height: h * 0.6,
                      child:
                      _getController.getFollowPost.value.res?[index].mediaType == 'video'
                          ? Stack(
                        children: [
                          SizedBox(
                            width: w,
                            height: h * 0.6,
                            child: Image.network(
                              '${_getController.getFollowPost.value.res?[index].photo}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              height: h * 0.6,
                              width: w,
                              child: Center(
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsPage(postId: _getController.getFollowPost.value.res?[index].id)));
                                      },
                                      icon: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: w * 0.1,
                                      )),
                                ),
                              )),
                        ],
                      ) : InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PostDetailsPage(postId: _getController.getFollowPost.value.res?[index].id)));
                        },
                        child: SizedBox(
                          width: w,
                          height: h * 0.6,
                          child: Image.network(
                            '${_getController.getFollowPost.value.res?[index].photo}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: h * 0.02),
                  SizedBox(
                    width: w * 0.9,
                    child: Text(
                      '${_getController.getFollowPost.value.res?[index].title}',
                      style: TextStyle(
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  SizedBox(
                    width: w * 0.9,
                    child: ReadMoreText(
                      '${_getController.getFollowPost.value.res?[index].description}',
                      trimLines: 2,
                      colorClickableText: Colors.grey,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Ko\'proq',
                      trimExpandedText: ' Yashirish',
                      moreStyle: TextStyle(
                        fontSize: w * 0.03,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                      ),
                      lessStyle: TextStyle(
                        fontSize: w * 0.03,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                      ),
                      style: TextStyle(
                        fontSize: w * 0.035,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.01,),
                ],
              );
            }),
      )
    ) : SizedBox(
      width: w,
      height: h * 0.9,
      child: Center(child: Text('Ma`lumotlar yo\'q', style: TextStyle(fontSize: w * 0.05, color: Colors.black))),
    )
    ));
  }
}
