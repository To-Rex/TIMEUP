import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_up/api/api_controller.dart';
import '../res/getController.dart';

late List<CameraDescription> _cameras;

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPage();
}

class _AddPostPage extends State<AddPostPage> {
  late CameraController controller;
  late bool isFlashOn = true;

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
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    setState(() {
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void setFlashMode(FlashMode mode) async {
    try {
      await controller.setFlashMode(mode);
    } catch (e) {
      print(e);
    }
  }

  //flash on off function
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

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
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
                  //gallery button
                  IconButton(
                    onPressed: () {},
                    icon: const HeroIcon(
                      HeroIcons.photo,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                  //press circle photo and video, if one of them is pressed, it will take a picture, if it is long pressed, it will take a video
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: IconButton(
                      onPressed: () async {
                        if (await Permission.camera.request().isGranted) {
                          await controller.takePicture().then((value) {
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

                  //caemra reverse button
                  IconButton(
                    onPressed: () {
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
                      setState(() {
                      });
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

    );
  }
}
