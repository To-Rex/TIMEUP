import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/elements/functions.dart';
import '../pages/post_details.dart';
import '../pages/professions_list_details.dart';
import '../res/getController.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:readmore/readmore.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GetController _getController = Get.put(GetController());
  var _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  showDialogs(BuildContext context, text, disc, ok, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            text,
            style:
            TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Center(
            child: Text(
              disc,
              style:
              TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
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
                      child: Text('Cancel',
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
                        if (index == 1) {
                          FlutterPhoneDirectCaller.callNumber(text);
                          Navigator.pop(context);
                        } else if (index == 2) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text(ok,
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          const Icon(Icons.check, color: Colors.white),
                          const Expanded(child: SizedBox()),
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

  showLoadingDialog(BuildContext context, w) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => AlertDialog(
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
                  backgroundColor: Colors.white,
                  strokeWidth: 2,
                ),
              ),
              SizedBox(
                width: w * 0.07,
              ),
              Text(
                'Loading...',
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
    _scrollController = ScrollController();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    if (_getController.meUsers.value.res == null) {
      ApiController().getUserData();
    }
    ApiController().getFollowPostList(1000, 0);

    void _onRefresh() async {
      _getController.getFollowPost.value.res?.clear();
      ApiController().getFollowPostList(1000, 0).then((value) => {
        _refreshController.refreshCompleted(),
      });
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
    _scrollController.addListener(onScroll);

    return Obx(() => _getController.getFollowPost.value.res == null
        ? SizedBox(
      width: w,
      height: h * 0.9,
      child: const Center(child: CircularProgressIndicator()),
    ) : Obx(() => _getController.getFollowPost.value.res!.isNotEmpty || _getController.getFollowPost.value.res != null
          ? Obx(() => _getController.uplAodVideo.value == true
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
                        showLoadingDialog(context, w);
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
                      height: h * 0.33,
                      child: Obx(() => _getController.getFollowPost.value.res?[index].mediaType == 'video'
                          ? Stack(
                        children: [
                          SizedBox(
                            width: w,
                            height: h * 0.33,
                            child: Image.network('${_getController.getFollowPost.value.res?[index].photo}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              height: h * 0.33,
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PostDetailsPage(
                                                    postId: _getController
                                                        .getFollowPost
                                                        .value
                                                        .res?[index]
                                                        .id)));
                                      },
                                      icon: Icon(
                                        Icons.play_arrow,
                                        color:
                                        Colors.white,
                                        size: w * 0.1,
                                      )),
                                ),
                              )),
                        ],
                      )
                          : InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PostDetailsPage(
                                          postId: _getController
                                              .getFollowPost
                                              .value
                                              .res?[index]
                                              .id)));
                        },
                        child: SizedBox(
                          width: w,
                          height: h * 0.33,
                          child: Image.network(
                            '${_getController.getFollowPost.value.res?[index].photo}',
                            fit: BoxFit.cover,
                          ),
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
                                ApiController()
                                    .profileById(int.parse(
                                    _getController
                                        .getFollowPost
                                        .value
                                        .res![index]
                                        .businessId
                                        .toString()))
                                    .then((value) => {
                                  _getController
                                      .changeProfileById(
                                      value),
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfessionsListDetails()));
                              },
                              icon: HeroIcon(
                                HeroIcons.heart,
                                color: Colors.blue,
                                size: w * 0.07,
                              )),
                        ),
                        SizedBox(
                          width: w * 0.01,
                        ),
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
                        SizedBox(
                          width: w * 0.01,
                        ),
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
                      trimCollapsedText: 'more',
                      trimExpandedText: ' less',
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
              controller: _scrollController,
              itemCount: _getController.getFollowPost.value.res?.length ?? 0,
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
                          showLoadingDialog(context, w);
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
                                      backgroundImage: NetworkImage(
                                          '${_getController.getFollowPost.value.res?[index].posterPhotoUrl}'),
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
                    if (_getController.getFollowPost.value
                        .res?[index].photo !=
                        null)
                      SizedBox(
                        width: w,
                        height: h * 0.33,
                        child:
                        Obx(() =>
                        _getController
                            .getFollowPost
                            .value
                            .res?[index]
                            .mediaType ==
                            'video'
                            ? Stack(
                          children: [
                            SizedBox(
                              width: w,
                              height: h * 0.33,
                              child:
                              Image.network(
                                '${_getController.getFollowPost.value.res?[index].photo}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                height: h * 0.33,
                                width: w,
                                child: Center(
                                  child:
                                  Container(
                                    decoration:
                                    BoxDecoration(
                                      color: Colors
                                          .black
                                          .withOpacity(
                                          0.5),
                                      borderRadius:
                                      BorderRadius.circular(
                                          100),
                                    ),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => PostDetailsPage(postId: _getController.getFollowPost.value.res?[index].id)));
                                        },
                                        icon: Icon(
                                          Icons
                                              .play_arrow,
                                          color: Colors
                                              .white,
                                          size: w *
                                              0.1,
                                        )),
                                  ),
                                )),
                          ],
                        )
                            : InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostDetailsPage(
                                        postId: _getController
                                            .getFollowPost
                                            .value
                                            .res?[
                                        index]
                                            .id)));
                          },
                          child: SizedBox(
                            width: w,
                            height: h * 0.33,
                            child: Image.network(
                              '${_getController.getFollowPost.value.res?[index].photo}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
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
                        trimCollapsedText: 'more',
                        trimExpandedText: ' less',
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
        ),
      ))
          : SizedBox(
        width: w,
        height: h * 0.9,
        child: const Center(
          child: Text('No data'),
        ),
      ),
    ));
  }
}