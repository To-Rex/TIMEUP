import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_up/api/api_controller.dart';

import '../res/getController.dart';

class PostDetailsPage extends StatelessWidget {
  var postId;
  PostDetailsPage({Key? key, this.postId}) : super(key: key);
  final GetController getController = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    print(postId);
    ApiController().getByIdPost(postId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
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
          SizedBox(
            height: h * 0.4,
            width: w ,
            child: Image.network(
              getController.getPostById.value.res!.photo!,
              fit: BoxFit.cover,
            ),
          ),
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
          //title
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