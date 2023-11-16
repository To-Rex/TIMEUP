import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
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
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late CameraController controller;
  late bool isFlashOn = true;

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
        _getController.changePostFile(pickedFile.path);
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

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted || await Permission.storage.request().isGranted) {
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

  showGallery(){
    //photo or video
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              Text('Choose media type', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.w500)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Photo'),
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
                leading: Icon(Icons.video_collection),
                title: Text('Video'),
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
                    onPressed: () {
                      _getController.changePostFile('');
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
                        setState(() {
                        });
                      } else {
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
          if (_getController.postFile.value.contains('.mp4') || _getController.postFile.value.contains('.mov'))
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white12,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: const HeroIcon(
                    HeroIcons.videoCamera,
                    color: Colors.black,
                  ),
                )
              )
            ) else
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
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              onPressed: () {
                _getController.changePostFile('');
                
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