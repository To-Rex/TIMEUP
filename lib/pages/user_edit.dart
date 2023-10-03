import 'package:flutter/material.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //{{host}}/api/v1/media/profilephoto/image_cropper_1696326992390-1696326997.jpg
          //networkImage('https://picsum.photos/250?image=9'),
          Image(image: NetworkImage('http://16.16.182.36:443/api/v1/media/profilephoto/image_cropper_1696326992390-1696326997.jpg'),),
        ],
      )
    );
  }
}