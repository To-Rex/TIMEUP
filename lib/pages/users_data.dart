import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_up/pages/sample_page.dart';
import '../elements/text_filds.dart';

class LoginUserData extends StatelessWidget {
  LoginUserData({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nikNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  //var caun =
  var countries = ['Uzbekistan', 'Russia', 'USA', 'China', 'Korea'];
  var dropdownValue = 'Uzbekistan';

  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
  }

  Future<void> _cropImage(String imagePath) async {
    final croppedImage = await ImageCropper.cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio16x9, CropAspectRatioPreset.original],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Crop Image',
      ),
    );

    if (croppedImage != null) {
      setState(() {
        _imageFile = croppedImage;
      });
    }
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
                  _pickImage();
                },
                    icon: Image.asset('assets/images/user.png'),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SamplePage(),
                      ),
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
