import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_up/api/api_controller.dart';
import '../res/getController.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    ApiController()
        .getFollowList()
        .then((value) => _getController.changeFollowList(value));
    return Obx(() => _getController.followList.value.res == null
        ? SizedBox()
        : SizedBox(
            width: w,
            height: h * 0.9,
            child: ListView.builder(
                itemCount: _getController.followList.value.res?.length ?? 0,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      //image
                      SizedBox(
                        height: h * 0.02,
                      ),
                      if (_getController.followList.value.res?[index].photoUrl != null)
                        SizedBox(
                          height: h * 0.3,
                          child: Image.network(
                            'http://${_getController.followList.value.res?[index].photoUrl}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      SizedBox(
                        width: w * 0.95,
                        child:Row(
                          children: [
                            IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.phone, color: Colors.blue, size: w * 0.08,)
                            ),
                            IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.location_on, color: Colors.blue, size: w * 0.08,)
                            ),
                            IconButton(
                                onPressed: (){},
                                //job
                                icon: Icon(Icons.work, color: Colors.blue, size: w * 0.08,)
                            ),
                          ],
                        ),
                      ),
                      //name
                      SizedBox(
                        width: w * 0.9,
                        child: Text(
                          '${_getController.followList.value.res?[index].userName}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: w * 0.9,
                        child: Text(
                          '${_getController.followList.value.res?[index].categoryName}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: w * 0.9,
                        child: Text(
                          '${_getController.followList.value.res?[index].bio}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  );
                }),
          ));
  }
}
