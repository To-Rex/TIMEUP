import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/elements/functions.dart';
import 'package:time_up/pages/sample_page.dart';
import '../elements/text_filds.dart';
import '../res/getController.dart';

class LoginUserData extends StatelessWidget {
  String? phoneNumber;
  LoginUserData({Key? key, required this.phoneNumber}) : super(key: key);

  final GetController getController = Get.put(GetController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nikNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  var croppedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
  }

  Future<void> _cropImage(String imagePath) async {
    croppedImage = await ImageCropper.platform.cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
    );
    getController.changeImage(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    ApiController().getRegion().then((value) {
      getController.changeRegion(value);
    });
    phoneNumberController.text = phoneNumber ?? '';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
            width: w,
            child: Column(
              children: [
                SizedBox(height: h * 0.08),
                const Image(image: AssetImage('assets/images/text.png')),
                SizedBox(height: h * 0.01),
                const Text(
                  'Ilovadan foydalanish uchun ma’lumotlarni toldiring',
                ),
                SizedBox(height: h * 0.01),
                IconButton(
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                  },
                  icon: Obx(
                    () => getController.image.value == ''
                        ? HeroIcon(
                            HeroIcons.userCircle,
                            color: Colors.blue,
                            size: w * 0.2 > 100 ? 100 : w * 0.2,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                FileImage(File(getController.image.value)),
                            radius: 50,
                          ),
                  ),
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
                Container(
                  height: h * 0.06,
                  width: w * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2025),
                          ).then((value) => _dateController.text =
                              '${value!.day}/${value.month}/${value.year}');
                        },
                        child: HeroIcon(
                          HeroIcons.calendar,
                          color: Colors.blue,
                          size: w * 0.05 > 20 ? 20 : w * 0.05,
                        ),
                      ),
                      hintText: 'Birth date',
                      hintStyle: TextStyle(
                        fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
                    ),
                  ),
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
                  child: Obx(
                    () => getController.getRegion.value.res == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: getController.getRegion.value
                                  .res![getController.regionIndex.value],
                              onChanged: (String? newValue) {
                                getController.changeRegionIndex(getController
                                    .getRegion.value.res!
                                    .indexOf(newValue!));
                              },
                              items: getController.getRegion.value.res!
                                  .map<DropdownMenuItem<String>>(
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
                ),
                SizedBox(height: h * 0.05),
                ElevatedButton(
                  onPressed: () {
                    if (getController.image.value == '') {
                      Toast.showToast(context, 'Iltimos Rasm tanlang!',
                          Colors.red, Colors.white);
                      return;
                    }
                    if (nameController.text.isEmpty) {
                      Toast.showToast(context, 'Ismingizni kiriting!',
                          Colors.red, Colors.white);
                      return;
                    }
                    if (surnameController.text.isEmpty) {
                      Toast.showToast(context, 'Familiyaningizni kiriting!',
                          Colors.red, Colors.white);
                      return;
                    }
                    if (nikNameController.text.isEmpty) {
                      Toast.showToast(context, 'Nikname ni toldiring',
                          Colors.red, Colors.white);
                      return;
                    }
                    if (phoneNumberController.text.isEmpty) {
                      Toast.showToast(context, 'Telefon raqamingizni kiriting!',
                          Colors.red, Colors.white);
                      return;
                    }
                    if (_dateController.text.isEmpty) {
                      Toast.showToast(context, 'Tugilgan kuningizni kiriting!',
                          Colors.red, Colors.white);
                      return;
                    }
                    //_dateController if exampel 12/2/2021 to 12/02/2021
                    if (_dateController.text.split('/')[0].length == 1) {
                      _dateController.text = '0${_dateController.text}';
                    }
                    if (_dateController.text.split('/')[1].length == 1) {
                      _dateController.text =
                          '${_dateController.text.split('/')[0]}/0${_dateController.text.split('/')[1]}/${_dateController.text.split('/')[2]}';
                    }
                    ApiController()
                        .registerUser(
                      nameController.text.toString(),
                      surnameController.text.toString(),
                      nikNameController.text.toString(),
                      phoneNumberController.text.toString(),
                      getController.getRegion.value
                          .res![getController.regionIndex.value],
                      getController.image.value,
                      _dateController.text.toString(),
                    )
                        .then((value) {
                      if (value.status == true) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SamplePage()));
                        GetStorage().write('token', value.res?.token);
                      } else {
                        Toast.showToast(context, 'Exx Nimadur xato ketdi',
                            Colors.red, Colors.white);
                      }
                    });
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
