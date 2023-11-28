import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:time_up/api/api_controller.dart';

import '../res/getController.dart';

class ProfessionsList extends StatelessWidget {

  final Function(int) onTap;

  ProfessionsList({Key? key, required this.onTap,}) : super(key: key);

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    ApiController().getCategory().then((value) =>{
      _getController.changeCategory(value),
      _refreshController.refreshCompleted(),
    }
    );
  }

  void _onLoading() async{
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    ApiController().getCategory().then((value) => _getController.changeCategory(value));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Kasblar royhati', style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.w500,),),
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
                  body =  const Text("Ma`lumotlarni yangilash uchun tashlang");
                }
                else if (mode == RefreshStatus.refreshing) {
                  body =  const CircularProgressIndicator(
                    color: Colors.blue,
                    backgroundColor:
                    Colors.white,
                    strokeWidth: 2,
                  );
                }
                else if (mode == RefreshStatus.failed) {
                  body = const Text("Load Failed!Click retry!");
                }
                else if (mode == RefreshStatus.canRefresh) {
                  body = const Text("Ma`lumotlarni yangilash uchun tashlang");
                }
                else {
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
                }
                else if (mode == LoadStatus.loading) {
                  body = const CircularProgressIndicator(
                    color: Colors.blue,
                    backgroundColor:
                    Colors.white,
                    strokeWidth: 2,
                  );
                }
                else if (mode == LoadStatus.failed) {
                  body = const Text("Load Failed!Click retry!");
                }
                else if (mode == LoadStatus.canLoading) {
                  body = const SizedBox();
                }
                else {
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
                    onTap(_getController.category.value.res?[index].id?? 0);
                  },
                  child: Container(
                    height: h * 0.06,
                    margin: EdgeInsets.only(bottom: h * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                    child: Center(
                      child: Text(_getController.category.value.res?[index].name ?? '',
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
            : const Center(child: Text('No data'))
        )
        ),
      ],
    );
  }
}
