import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/elements/functions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../res/getController.dart';

class ProfessionsList extends StatelessWidget {
  final Function(int) onTap;

  ProfessionsList({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    ApiController().getCategory().then((value) => {
          _refreshController.refreshCompleted(),
        });
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  final Uri _url = Uri.parse('https://t.me/TimeUP_test');

  Future<void> _launchTelegram(context) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }else{
      Toast.showToast(context, 'Telegram ochildi', Colors.green, Colors.white);
    }
  }

  //launch phone +998931561464
  Future<void> _launchPhone(context) async {
    const url = 'tel:+998931561464';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }else{
      Toast.showToast(context, 'Telefon ochildi', Colors.green, Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    ApiController().getCategory();
    return Expanded(
      child: SizedBox(
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
              top: h * 0.2,
              child: Container(
                height: h * 0.12,
                width: w,
                color: Colors.grey[50],
              )
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
                  child: InkWell(
                    onTap: () {
                      _launchTelegram(context);
                    },
                    child: Row(
                      children: [
                        SizedBox(width: w * 0.04),
                        //image call_me.png
                        Container(
                          height: h * 0.06,
                          width: w * 0.1,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/call_me.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
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
                        InkWell(
                          onTap: () {
                            _launchPhone(context);
                          },
                          child: Container(
                            height: h * 0.04,
                            width: w * 0.08,
                            margin: EdgeInsets.only(right: w * 0.04),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: w * 0.05,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
            Positioned(
              top: h * 0.15,
              bottom: 0,
              child: Container(
                width: w,
                margin: EdgeInsets.only(top: h * 0.15),
                color: Colors.grey[50],
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
                                  if (_getController.category.value.res?[index].icon_url != '')
                                  Container(
                                    height: h * 0.04,
                                    width: w * 0.08,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(_getController.category.value.res?[index].icon_url ?? ''),
                                        fit: BoxFit.fill,
                                        colorFilter: const ColorFilter.mode(Colors.deepOrangeAccent, BlendMode.color),
                                        invertColors: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: w * 0.04),
                                  SizedBox(
                                    width: w * 0.6,
                                    child: Text(
                                      _getController.category.value.res?[index].name ?? '',
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
                    ))
                    : const Center(child: Text('No data')))),
              ),),
          ],
        ),
      )
    );
  }
}
