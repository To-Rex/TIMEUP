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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(''),
      ),
    );
  }
}