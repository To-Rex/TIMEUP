import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/pages/sample_page.dart';
import '../elements/text_filds.dart';
import '../res/getController.dart';

class LoginUserData extends StatelessWidget {
  LoginUserData({super.key});

  final GetController getController = Get.put(GetController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nikNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  //var caun =
  var countries = ['Uzbekistan', 'Russia', 'USA', 'China', 'Korea'];
  var dropdownValue = 'Uzbekistan';

  final ImagePicker _picker = ImagePicker();
  var croppedImage;

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
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      //AssetImage('assets/images/user.png') vertical center
      body: SingleChildScrollView(
        child: SizedBox(
            width: w,
            child: Column(
              children: [
                SizedBox(height: h * 0.1),
                const Image(image: AssetImage('assets/images/logo.png')),
                SizedBox(height: h * 0.01),
                const Text(
                  'Ilovadan foydalanish uchun ma’lumotlarni toldiring',
                ),
                SizedBox(height: h * 0.01),
                IconButton(onPressed: (){
                  _pickImage(ImageSource.gallery);
                },
                    /*icon: Image.asset('assets/images/user.png'),*/
                  icon: Obx(() => getController.image.value == '' ? Image.asset('assets/images/user.png') : CircleAvatar(backgroundImage: FileImage(File(getController.image.value)),radius: 50,),),
                ),
                Text(
                  'Upload image',
                  style: TextStyle(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: h * 0.02),
                TextFildWidget(
                  controller: nameController,
                  labelText: 'Ism',
                ),
                SizedBox(height: h * 0.02),
                TextFildWidget(
                  controller: surnameController,
                  labelText: 'Familiya',
                ),
                SizedBox(height: h * 0.02),
                TextFildWidget(
                  controller: nikNameController,
                  labelText: 'Nikname',
                ),
                SizedBox(height: h * 0.02),
                TextFildWidget(
                  controller: phoneNumberController,
                  labelText: 'Telefon raqam',
                ),
                SizedBox(height: h * 0.02),
                Container(
                  height: h * 0.06,
                  width: w * 0.9,
                  padding: EdgeInsets.only(left: w * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        dropdownValue = newValue!;
                      },
                      items: countries.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.02),
                ElevatedButton(
                  onPressed: () {
                    ApiController().registerUser(
                      nameController.text,
                      surnameController.text,
                      nikNameController.text,
                      phoneNumberController.text,
                      dropdownValue,
                      getController.image.value,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.blue,
                    minimumSize: Size(w * 0.9, h * 0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Saqlash',
                    style: TextStyle(
                      fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
