import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:time_up/api/api_controller.dart';
import '../pages/post_details.dart';
import '../pages/professions_list_details.dart';
import '../res/getController.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:readmore/readmore.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());

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

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    //ApiController().getUserData();
    ApiController().getFollowPostList();
    return Obx(() => _getController.getFollowPost.value.res == null
        ? SizedBox(
            width: w,
            height: h * 0.9,
            child: const Center(child: CircularProgressIndicator()),
          )
        : Obx(
            () => _getController.getFollowPost.value.res!.isNotEmpty
                ? SizedBox(
                    width: w,
                    height: h * 0.83,
                    child: ListView.builder(
                        itemCount: _getController.getFollowPost.value.res?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(height: h * 0.02),
                              if (_getController.getFollowPost.value.res?[index].posterPhotoUrl != null)
                                InkWell(
                                  onTap: () {
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
                                                child: const CircularProgressIndicator(color: Colors.blue,backgroundColor: Colors.white,strokeWidth: 2,),
                                              ),
                                              SizedBox(width: w * 0.07,),
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
                                    ApiController().profileById(int.parse(_getController.getFollowPost.value.res![index].businessId.toString())).then((value) => {
                                      _getController.changeProfileById(value),
                                      Navigator.pop(context),
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails()))
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: w * 0.9,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: w * 0.11,
                                              height: w * 0.11,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage('${_getController.getFollowPost.value.res?[index].posterPhotoUrl}'),
                                              ),
                                            ),
                                            SizedBox(
                                              width: w * 0.02,
                                            ),
                                            SizedBox(
                                              width: w * 0.6,
                                              child: Text('${_getController.getFollowPost.value.res?[index].posterName}',
                                                style: TextStyle(
                                                  fontSize: w * 0.05,
                                                  fontWeight: FontWeight.w500,
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
                                                    decoration: BoxDecoration(
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
                                                        )
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ],
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsPage(postId: _getController.getFollowPost.value.res?[index].id)));
                                          },
                                          child: SizedBox(
                                            width: w,
                                            height: h * 0.33,
                                            child: Image.network('${_getController.getFollowPost.value.res?[index].photo}',
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
                                              ApiController().profileById(int.parse(_getController.getFollowPost.value.res![index].businessId.toString())).then((value) => {_getController.changeProfileById(value),});
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails()));
                                          },
                                          icon: HeroIcon(
                                            HeroIcons.heart,
                                            color: Colors.blue,
                                            size: w * 0.07,
                                          )),
                                    ),
                                    SizedBox(width: w * 0.01,),
                                    SizedBox(
                                      height: w * 0.07,
                                      width: w * 0.07,
                                      child: IconButton(
                                          hoverColor: Colors.blue,
                                          iconSize: w * 0.07,
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                          },
                                          icon: HeroIcon(
                                            HeroIcons.phone,
                                            color: Colors.blue,
                                            size: w * 0.07,
                                          )),
                                    ),
                                    SizedBox(width: w * 0.01,),
                                    const Expanded(child: SizedBox()),
                                    SizedBox(
                                      height: w * 0.07,
                                      width: w * 0.07,
                                      child: IconButton(
                                          hoverColor: Colors.blue,
                                          iconSize: w * 0.07,
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                          },
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
                        SizedBox(height: h * 0.01,),
                        ],
                      );
                    }),
                  )
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
