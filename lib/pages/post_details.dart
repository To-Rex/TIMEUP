import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:video_player/video_player.dart';

import '../res/getController.dart';

class PostDetailsPage extends StatelessWidget {
  var postId;
  PostDetailsPage({Key? key, this.postId}) : super(key: key);
  final GetController getController = Get.put(GetController());
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    ApiController().getByIdPost(postId).then((value) => {
      if (getController.getPostById.value.res!.mediaType == 'video'){
          _controller = VideoPlayerController.networkUrl(Uri.parse(getController.getPostById.value.res!.video!)),
          _initializeVideoPlayerFuture = _controller.initialize(),
        },
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
            getController.changeStartVideo();
          },
        ),
        centerTitle: true,
        title: const Text('My post'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),],
      ),
      body: Obx(() => getController.getPostById.value.res == null
          ? const Center(child: Text('No data'))
          : Column(
        children: [
          SizedBox(height: h * 0.02),
          Obx(() => getController.startVideo == true
              ? SizedBox(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              initialData: null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      Container(
                        width: w,
                        height: h * 0.32,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: SizedBox(
                            width: _controller.value.size.width,
                            height: _controller.value.size.height,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.065,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black.withOpacity(0.5),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds - 10));
                                        },
                                        icon: const HeroIcon(
                                          HeroIcons.arrowLeft,
                                          color: Colors.white,
                                        ),
                                        color: Colors.white,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (_controller.value.isPlaying) {
                                            _controller.pause();
                                            getController.changePauseVideo();
                                          } else {
                                            _controller.play();
                                            getController.changePauseVideo();
                                          }
                                        },
                                        icon: Obx(() => getController.pauseVideo == true
                                            ? const HeroIcon(
                                          HeroIcons.pause,
                                          color: Colors.white,
                                        )
                                            : const HeroIcon(
                                          HeroIcons.play,
                                          color: Colors.white,
                                        )),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds + 10));
                                        },
                                        icon: const HeroIcon(
                                          HeroIcons.arrowRight,
                                          color: Colors.white,
                                        ),
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: VideoProgressIndicator(
                                    _controller,
                                    allowScrubbing: true,
                                    colors: const VideoProgressColors(
                                      playedColor: Colors.blue,
                                      bufferedColor: Colors.grey,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
          : Stack(
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
                  top: h * 0.15,
                  left: w * 0.4,
                  right: w * 0.4,
                  bottom: h * 0.15,
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
                  )
              )
                  : const SizedBox(),
            ],
          ),),
          SizedBox(height: h * 0.02),
          Row(
            children: [
              SizedBox(width: w * 0.03),
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: w * 0.06,
                backgroundImage: NetworkImage(
                    getController.getPostById.value.res!.photo!),
              ),
              SizedBox(width: w * 0.03),
              Text(
                getController.getPostById.value.res!.posterName!,
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border),
              ),
              SizedBox(width: w * 0.03),
            ],
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            width: w * 0.95,
            child: Padding(
              padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
              child: Text(
                getController.getPostById.value.res!.title!,
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            width: w * 0.95,
            child: Padding(
              padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
              child: Text(
                getController.getPostById.value.res!.description!,
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}