import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/pages/professions_list_details.dart';
import '../res/getController.dart';

class PostDetailsPage extends StatelessWidget {
  var postId;
  PostDetailsPage({Key? key, this.postId}) : super(key: key);

  final GetController getController = Get.put(GetController());
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  Widget build(BuildContext context) {
    getController.clearGetByIdPost();

    ApiController().getByIdPost(postId).then((value) => {
      if (getController.getPostById.value.res!.mediaType == 'video'){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.blue),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    const Text('Loading...'),
                  ],
                ),
              ),
            );
          },
        ),
        _controller = VideoPlayerController.networkUrl(Uri.parse(getController.getPostById.value.res!.video!)),
        _initializeVideoPlayerFuture = _controller.initialize().then((value) => {
              Navigator.pop(context),
              _controller.setLooping(true),
              _controller.pause(),
            }),
        _customVideoPlayerController = CustomVideoPlayerController(
            customVideoPlayerSettings: CustomVideoPlayerSettings(
              customAspectRatio: _controller.value.aspectRatio,
              exitFullscreenOnEnd: false,
              deviceOrientationsAfterFullscreen: [
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ],
            ),
            videoPlayerController: _controller,
            context: context),
      },
    });
    if (getController.startVideo == true) {
      _controller.pause();
      _customVideoPlayerController.playedOnceNotifier.value = false;
      getController.changeStartVideo();
    }
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () {
          if (getController.startVideo == true) {
            _controller.pause();
            _controller.dispose();
            _customVideoPlayerController.dispose();
            getController.changeStartVideo();
          }
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
                _controller.dispose();
                _customVideoPlayerController.dispose();
                if (getController.startVideo == true) {
                  _controller.pause();
                  getController.changeStartVideo();
                } else {
                  _controller.pause();
                }
              },
            ),
            centerTitle: true,
            title: Obx(() => getController.getPostById.value.res == null ||
                getController.getPostById.value.res!.id == null
                ? Center(
                child: Text('No data',
                    style: TextStyle(color: Colors.black, fontSize: w * 0.04)))
                : Text(getController.getPostById.value.res!.title!,
                style: const TextStyle(color: Colors.black, fontSize: 18))),
            actions: [
              Obx(() => getController.meUsers.value.res?.business?.id == getController.getPostById.value.res?.businessId
                  ? PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return {'Delete', 'Edit'}.map((String choice) {
                    return PopupMenuItem<String>(
                      onTap: () {
                        if (choice == 'Delete') {
                          ApiController().deletePost(getController.getPostById.value.res?.id);
                          Navigator.pop(context);
                          ApiController().getMePostList(getController.meUsers.value.res!.business?.id);
                        }
                      },
                      value: choice,
                      child: Row(
                        children: [
                          HeroIcon(
                            choice == 'Delete' ? HeroIcons.trash : HeroIcons.pencilSquare,
                            color: choice == 'Delete' ? Colors.red : Colors.blue,
                          ),
                          SizedBox(width: w * 0.02),
                          Text(choice,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w * 0.04,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList();
                },
              )
                  : const SizedBox()
              ),
            ],
          ),
          body: Obx(() => getController.getPostById.value.res == null || getController.getPostById.value.res!.id == null
              ? const Center(child: Text('No data'))
              : Column(
            children: [
              SizedBox(height: h * 0.02),
              Obx(() => getController.startVideo == true
                    ? SizedBox(
                  height: h * 0.4,
                  width: w,
                  child: CustomVideoPlayer(customVideoPlayerController: _customVideoPlayerController),)
                    : Stack(
                  children: [
                    SizedBox(
                      height: h * 0.4,
                      width: w,
                      child: Image.network(
                        getController.getPostById.value.res!.photo!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    getController.getPostById.value.res!.mediaType == 'video'
                        ? Positioned(
                        height: h * 0.4,
                        width: w,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(w * 0.1),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _controller.play();
                                getController.changeStartVideo();
                              },
                              icon: Icon(Icons.play_arrow,
                                  color: Colors.white,
                                  size: w * 0.08),
                            ),
                          ),
                        ))
                        : const SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),
              Row(
                children: [
                  SizedBox(width: w * 0.03),
                  GestureDetector(
                    onTap: () {
                      ApiController().profileById(getController.getPostById.value.res!.businessId!).then((value) => {
                        getController.changeProfileById(value),
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails()));
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: w * 0.06,
                        backgroundImage: NetworkImage(getController.getPostById.value.res!.posterPhotoUrl!)),
                  ),
                  SizedBox(width: w * 0.03),
                  GestureDetector(
                    onTap: () {
                      ApiController().profileById(getController.getPostById.value.res!.businessId!).then((value) => {
                        getController.changeProfileById(value),
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails()));
                    },
                    child: Text(
                      getController.getPostById.value.res!.posterName!,
                      style: TextStyle(
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border, color: Colors.black),
                  ),
                  SizedBox(width: w * 0.03),
                ],
              ),
              SizedBox(height: h * 0.02),
              SizedBox(
                width: w * 0.95,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                  child: Text(
                    getController.getPostById.value.res!.title!,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.01),
              SizedBox(
                width: w * 0.95,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                  child: Text(
                    getController.getPostById.value.res!.description!,
                    style: TextStyle(
                      fontSize: w * 0.03,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}