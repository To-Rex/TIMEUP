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
      /*child: Stack(
        children: [
          CameraPreview(controller),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      toggleFlash();
                    },
                    icon: HeroIcon(
                      HeroIcons.bolt,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: HeroIcon(
                      HeroIcons.camera,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: HeroIcon(
                      HeroIcons.videoCamera,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),*/
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
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: HeroIcon(
                      HeroIcons.camera,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: HeroIcon(
                      HeroIcons.videoCamera,
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
