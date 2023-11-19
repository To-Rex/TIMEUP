import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/elements/functions.dart';
import 'package:video_player/video_player.dart';
import '../res/getController.dart';

late List<CameraDescription> _cameras;

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPage();
}

class _AddPostPage extends State<AddPostPage> {
  final GetController _getController = Get.put(GetController());
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late CameraController controller;
  late bool isFlashOn = true;

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  Future<void> _pickMedia() async {
    if (await _promptPermissionSetting()) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _getController.changePostFile(pickedFile.path);
      }
    }
  }

  Future<void> _pickVideo() async {
    if (await _promptPermissionSetting()) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        print(pickedFile.path);
        _getController.changePostVideoFile(pickedFile.path);
        _controller = VideoPlayerController.file(File(pickedFile.path));
        _initializeVideoPlayerFuture = _controller.initialize();
        _controller.setLooping(true);
      }
    }
  }

  initCamera() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras.first, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    _getController.changePostFile('');
    _getController.changePostVideoFile('');
    setState(() {});
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted ||
          await Permission.storage.request().isGranted) {
        return true;
      }
    }
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted ||
          await Permission.photos.request().isGranted &&
              await Permission.videos.request().isGranted) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    controller.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void setFlashMode(FlashMode mode) async {
    try {
      await controller.setFlashMode(mode);
    } catch (e) {
      _getController.changePostFile('');
    }
  }

  void toggleFlash() {
    if (controller.value.flashMode == FlashMode.off) {
      setFlashMode(FlashMode.torch);
      setState(() {
        isFlashOn = true;
      });
    } else {
      setFlashMode(FlashMode.off);
      setState(() {
        isFlashOn = false;
      });
    }
  }

  showGallery() {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              Text('Choose media type', style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Photo'),
                onTap: () {
                  _pickMedia();
                  Navigator.pop(context);
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(Icons.video_collection),
                title: const Text('Video'),
                onTap: () {
                  _pickVideo();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (_getController.postFile.value == '') {
          return true;
        } else {
          _getController.changePostFile('');
          _getController.changePostVideoFile('');
          _controller.dispose();
          return false;
        }
      },
      child: Obx(() => _getController.postFile.value == '' && _getController.postVideoFile.value == ''
          ? SizedBox(
        height: MediaQuery.of(context).size.height * 0.81,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CameraPreview(controller),
            ),
            Positioned(
              child: IconButton(
                onPressed: () {
                  toggleFlash();
                },
                icon: const HeroIcon(
                  HeroIcons.bolt,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        _getController.changePostFile('');
                        _getController.changePostVideoFile('');
                        showGallery();
                      },
                      icon: const HeroIcon(
                        HeroIcons.photo,
                        color: Colors.white,
                      ),
                      color: Colors.white,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: IconButton(
                        onPressed: () async {
                          if (await Permission.camera.request().isGranted) {
                            await controller.takePicture().then((value) {
                              _getController.changePostFile(value.path);
                            });
                          }
                        },
                        icon: const HeroIcon(
                          HeroIcons.camera,
                          color: Colors.black,
                        ),
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (controller.description == _cameras.first) {
                          controller = CameraController(_cameras.last, ResolutionPreset.max);
                          controller.initialize().then((_) {
                            if (!mounted) {
                              return;
                            }
                            setState(() {});
                          }).catchError((Object e) {
                            if (e is CameraException) {
                              switch (e.code) {
                                case 'CameraAccessDenied':
                                  break;
                                default:
                                  break;
                              }
                            }
                          });
                          setState(() {});
                        } else {
                          controller = CameraController(
                              _cameras.first, ResolutionPreset.max);
                          controller.initialize().then((_) {
                            if (!mounted) {
                              return;
                            }
                            setState(() {});
                          }).catchError((Object e) {
                            if (e is CameraException) {
                              switch (e.code) {
                                case 'CameraAccessDenied':
                                  break;
                                default:
                                  break;
                              }
                            }
                          });
                          setState(() {});
                        }
                      },
                      icon: const HeroIcon(
                        HeroIcons.arrowPath,
                        color: Colors.white,
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ) : SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    _getController.changePostFile('');
                    _getController.changePostVideoFile('');
                    _controller.dispose();
                  },
                  icon: const HeroIcon(
                    HeroIcons.chevronLeft,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(() => _getController.postFile.value == ''
                            ?GestureDetector(
                          onTap: () {
                            _pickMedia();
                          },
                          child: Container(
                            width: w,
                            height: h * 0.1,
                            padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                            margin: EdgeInsets.all(w * 0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: SizedBox(
                                width: w * 0.005,
                                height: h * 0.01,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Iltimos, rasm yuklang',
                                        style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600])),
                                    HeroIcon(
                                      HeroIcons.photo,
                                      color: Colors.red,
                                      size: w * 0.08,
                                    ),
                                  ],
                                )
                            ),
                          ) ,
                        )
                            :_getController.postVideoFile.value != '' && _getController.postFile.value != '' || _getController.postVideoFile.value != '' && _getController.postFile.value == ''
                            ?Column(
                          children: [
                            Text('Rasm yoki video yuklang',
                                style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600])),
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: h * 0.02),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.32,
                                  child: Image.file(File(_getController.postFile.value), fit: BoxFit.cover),
                                ),
                                //edit icon button bottom, end
                                Positioned(
                                  bottom: h * 0.022,
                                  right: w * 0.01,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.height * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        _pickMedia();
                                      },
                                      icon: const HeroIcon(
                                        HeroIcons.pencil,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                            ),
                            SizedBox(height: h * 0.01),
                          ],
                        )
                            : const SizedBox()

                        ),
                        Obx(() => _getController.postVideoFile.value != '' && _getController.postFile.value != '' || _getController.postVideoFile.value != '' && _getController.postFile.value == ''
                            ? Column(
                          children: [
                            Text('Video yuklang',
                                style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600])),
                            SizedBox(
                              child: FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
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
                                                            } else {
                                                              _controller.play();
                                                            }
                                                            setState(() {});
                                                          },
                                                          icon: _controller.value.isPlaying
                                                              ? const HeroIcon(
                                                            HeroIcons.pause,
                                                            color: Colors.white,
                                                          )
                                                              : const HeroIcon(
                                                            HeroIcons.play,
                                                            color: Colors.white,
                                                          ),
                                                          color: Colors.white,
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
                                        //edit icon button bottom, end
                                        Positioned(
                                          bottom: h * 0.015,
                                          right: w * 0.01,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.1,
                                            height: MediaQuery.of(context).size.height * 0.05,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                _pickVideo();
                                              },
                                              icon: const HeroIcon(
                                                HeroIcons.pencil,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
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
                          ],
                        ) : Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: h * 0.02),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.32,
                              child: Image.file(File(_getController.postFile.value), fit: BoxFit.cover),
                            ),
                            Positioned(
                              bottom: h * 0.022,
                              right: w * 0.01,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _pickMedia();
                                  },
                                  icon: const HeroIcon(
                                    HeroIcons.pencil,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ),
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
                            onPressed: () {
                              if (_getController.postFile.value == '') {
                                Toast.showToast(context, 'Iltimos, rasm yuklang', Colors.red, Colors.white);
                                return;
                              }
                              ApiController().createPost(titleController.text, descriptionController.text, _getController.meUsers.value.res!.business!.id!,
                                  _getController.postFile.value.toString(),
                                  _getController.postVideoFile.value.toString()
                              ).then((value) => {if (value){
                                _getController.changePostFile(''),
                                _getController.changePostVideoFile(''),
                                titleController.clear(),
                                descriptionController.clear(),
                                _getController.changeIndex(0),
                                ApiController().getUserData(),
                                Toast.showToast(context, 'Post created', Colors.green, Colors.white),
                              } else {
                                Toast.showToast(context, 'Error', Colors.red, Colors.white),
                              }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('Post yaratish',
                                style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    )
                ),
              )
            ],
          ))),
    );
  }
}