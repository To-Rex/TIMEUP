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
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            'Postni tahrirlash',
            style: TextStyle(
              color: Colors.black,
              fontSize: w * 0.05,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return {'O`chirish'}.toList().map((String choice) {
                  return PopupMenuItem<String>(
                    onTap: () {
                      if (choice == 'O`chirish') {
                        Loading.showLoading(context);
                      ApiController().deletePost(getController.getPostById.value.res?.id).then((value) => {
                        if (value == true){
                          Navigator.pop(context),
                            ApiController().getMePostList(getController.meUsers.value.res!.business?.id,3,0).then((value) => {
                              Navigator.pop(context),
                            })
                          } else {
                            Navigator.pop(context),
                            Toast.showToast(context, 'Nimadir xato ketdi', Colors.red, Colors.white),
                          }
                        });

                    }
                    },
                    value: choice,
                    child: Row(
                      children: [
                        HeroIcon(
                          choice == 'O`chirish'
                              ? HeroIcons.trash
                              : HeroIcons.pencilSquare,
                          color: choice == 'O`chirish'
                              ? Colors.red : Colors.blue,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: h * 0.02),
              Obx(() => getController.getPostById.value.res != null
                  ? Stack(
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
                                      borderRadius:
                                          BorderRadius.circular(w * 0.1),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.play_arrow, color: Colors.white, size: w * 0.08),
                                    ),
                                  ),
                                ))
                            : const SizedBox(),
                      ],
                    )
                  : const SizedBox()),
              SizedBox(height: h * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.06,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Sarlavha',
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
                padding: EdgeInsets.only(right: w * 0.03, left: w * 0.03, bottom: h * 0.01),
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
                    hintText: 'Tavsif',
                    hintStyle: TextStyle(
                      fontSize: w * 0.03,
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
                    Loading.showLoading(context);
                    ApiController().updatePost(postId, getController.meUsers.value.res!.business?.id, titleController.text, descriptionController.text).then((value) => {
                              if (value == true){
                                Navigator.pop(context),
                                ApiController().getMePostList(getController.meUsers.value.res!.business?.id,3,0).then((value) => {
                                  Navigator.pop(context),
                                })
                              } else {
                                  Navigator.pop(context),
                                  Toast.showToast(context, 'Nimadir xato ketdi', Colors.red, Colors.white),
                                }
                            });
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('O`zgarishlarni saqlash',
                      style: TextStyle(fontSize: w * 0.04, color: Colors.white)),
                ),
              ),
            ],
          ),
        ));
  }
}
