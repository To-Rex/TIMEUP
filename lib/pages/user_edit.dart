import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_up/elements/functions.dart';

import '../api/api_controller.dart';
import '../elements/btn_users.dart';
import '../elements/text_filds.dart';
import '../res/getController.dart';

class EditUserPage extends StatelessWidget {
  EditUserPage({Key? key}) : super(key: key);

  final GetController getController = Get.put(GetController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nikNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  var croppedImage;

  getUsers() async {
    getController.changeMeUser(
        await ApiController().getUserData(GetStorage().read('token')));
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
  }

  Future<void> _cropImage(String imagePath) async {
    croppedImage = await ImageCropper.platform
        .cropImage(sourcePath: imagePath, aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),compressQuality: 100,compressFormat: ImageCompressFormat.jpg,);
    getController.changeImage(croppedImage.path);
  }


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    nameController.text = getController.meUsers.value.res?.lastName ?? '';
    surnameController.text = getController.meUsers.value.res?.fistName ?? '';
    nikNameController.text = getController.meUsers.value.res?.userName ?? '';
    addressController.text = getController.meUsers.value.res?.address ?? '';

    return SizedBox(
      width: w,
      child: Column(
        children: [
          SizedBox(height: h * 0.01),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                getController.entersUser.value = 0;
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: Text('Edit profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: w * 0.05,
              ),
            ),
            centerTitle: true,
          ),
          Center(
            child: Obx (() => getController.image.value == '' ? CircleAvatar(
              radius: w * 0.12,
              foregroundColor: Colors.blue,
              backgroundImage: NetworkImage('http://${getController.meUsers.value.res?.photoUrl}'),
            ) : CircleAvatar(
              radius: w * 0.12,
              foregroundColor: Colors.blue,
              backgroundImage: FileImage(File(getController.image.value)),
            ),),
          ),
          TextButton(
            onPressed: () {
              _pickImage(ImageSource.gallery);
            },
            child: Text(
              'Edit profile photo',
              style: TextStyle(
                fontSize: w * 0.04,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: h * 0.05),
          TextFildWidget(
            controller: nameController,
            labelText: 'Name',
          ),
          SizedBox(height: h * 0.015),
          TextFildWidget(
            controller: surnameController,
            labelText: 'Surname',
          ),
          SizedBox(height: h * 0.015),
          TextFildWidget(
            controller: nikNameController,
            labelText: 'Nikname',
          ),
          SizedBox(height: h * 0.015),
          TextFildWidget(
            controller: addressController,
            labelText: 'Adress',
          ),
          SizedBox(height: h * 0.15),
          EditButton(
            text: 'Save data',
            onPressed: () {
              if (nameController.text == '' ||
                  surnameController.text == '' ||
                  nikNameController.text == '' ||
                  addressController.text == '') {
                Toast.showToast(context, 'Please fill in all the fields', Colors.red, Colors.white);
                return;
              }
              if (getController.image.value == '') {
                ApiController().editUser(
                  GetStorage().read('token'),
                  nameController.text,
                  surnameController.text,
                  nikNameController.text,
                  addressController.text,
                ).then((value) {
                  if (value.status == true) {
                    getController.entersUser.value = 0;
                    getUsers();
                  } else {
                    Toast.showToast(context, 'Error', Colors.red, Colors.white );
                  }
                });
              }else{
                ApiController().editUserPhoto(GetStorage().read('token'), getController.image.value).then((value) {
                  if (value == true) {
                    ApiController().editUser(
                      GetStorage().read('token'),
                      nameController.text,
                      surnameController.text,
                      nikNameController.text,
                      addressController.text,
                    ).then((value) {
                      if (value.status == true) {
                        getController.entersUser.value = 0;
                        getUsers();
                      } else {
                        Toast.showToast(context, 'Error', Colors.red, Colors.white );
                      }
                    });
                  } else {
                    Toast.showToast(context, 'Error', Colors.red, Colors.white );
                  }
                });
              }
            },
          ),
          SizedBox(height: h * 0.05),
        ],
      ),
    );
  }
}
