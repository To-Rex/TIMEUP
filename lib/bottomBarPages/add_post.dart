import 'dart:io';

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
  final GetController _getController = Get.put(GetController());
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

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    if (!controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Obx(() => _getController.postFile.value == ''
        ?SizedBox(
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
                    onPressed: () {},
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
    ) :SizedBox(
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
              },
              icon: const HeroIcon(
                HeroIcons.chevronLeft,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.file(File(_getController.postFile.value), fit: BoxFit.cover),
          ),
          SizedBox(height: h * 0.02),
          //EditableText(controller: controller, focusNode: focusNode, style: style, cursorColor: cursorColor, backgroundCursorColor: backgroundCursorColor)
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.06,
            child:TextField(
              //controller: _dateController,
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
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Post yaratish', style: TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.w500, color: Colors.white)),
            ),
          ),
        ],
      )
    ));
  }
}