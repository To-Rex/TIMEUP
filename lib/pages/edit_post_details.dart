import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/pages/professions_list_details.dart';
import 'package:video_player/video_player.dart';
import '../elements/functions.dart';
import '../res/getController.dart';


class EditPostDetails extends StatelessWidget {
  var postId;
  EditPostDetails({Key? key, this.postId}) : super(key: key);

  final GetController getController = Get.put(GetController());
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late CustomVideoPlayerController _customVideoPlayerController;
  final GetController _getController = Get.put(GetController());
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

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
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.blue,
                    ),
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
            ),
            videoPlayerController: _controller,
            context: context
        ),
      },
    });
    if (getController.startVideo == true){
      _controller.pause();
      _customVideoPlayerController.playedOnceNotifier.value = false;
      getController.changeStartVideo();
    }
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: (){
          if (getController.startVideo == true){
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
                if (getController.startVideo == true){
                  _controller.pause();
                  getController.changeStartVideo();
                }else{
                  _controller.pause();
                }
              },
            ),
            centerTitle: true,
            title: Text(
              'Edit Post',
              style: TextStyle(
                color: Colors.black,
                fontSize: w * 0.05,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return {'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      onTap: (){
                        if (choice == 'Delete'){
                          ApiController().deletePost(getController.getPostById.value.res?.id);
                          Navigator.pop(context);
                          ApiController().getMePostList(getController.meUsers.value.res!.business?.id);
                        }
                      },
                      value: choice,
                      child: Row(
                        children: [
                          HeroIcon(
                            choice == 'Delete'
                                ? HeroIcons.trash
                                : HeroIcons.pencilSquare,
                            color: choice == 'Delete'
                                ? Colors.red
                                : Colors.blue,
                          ),
                          SizedBox(width: w * 0.02),
                          Text(
                            choice,
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
                  child: WillPopScope(
                    onWillPop: (){
                      Navigator.pop(context);
                      _controller.dispose();
                      _customVideoPlayerController.dispose();
                      if (getController.startVideo == true){
                        _controller.pause();
                        getController.changeStartVideo();
                      }
                      return Future.value(true);
                    },
                    child: CustomVideoPlayer(customVideoPlayerController: _customVideoPlayerController),
                  )
              ) : Stack(
                children: [
                  SizedBox(
                    height: h * 0.4,
                    width: w ,
                    child: Image.network(
                      getController.getPostById.value.res!.photo!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  getController.getPostById.value.res!.mediaType == 'video'
                      ? Positioned(
                      height: h * 0.4,
                      width: w ,
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
                            icon: Icon(Icons.play_arrow, color: Colors.white, size: w * 0.08),
                          ),
                        ),
                      )
                  )
                      : const SizedBox(),],),),
              SizedBox(height: h * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.06,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontSize: w * 0.034,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Container(
                width: w * 0.95,
                height: h * 0.2,
                padding: EdgeInsets.only(right: w * 0.02, left: w * 0.02, bottom: h * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 30,
                  maxLength: 600,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Description',
                    hintStyle: TextStyle(
                      fontSize: w * 0.04,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: w * 0.04,
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Update Post',
                      style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ),
              ),
            ],
          )),
        ));
  }
}
