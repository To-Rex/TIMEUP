import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:time_up/elements/functions.dart';
import '../api/api_controller.dart';
import '../elements/btn_users.dart';
import '../elements/text_filds.dart';
import '../res/getController.dart';

class MakeBusinessPage extends StatelessWidget {
  MakeBusinessPage({Key? key}) : super(key: key);

  final GetController getController = Get.put(GetController());
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nikNameController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameInstitutionController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController dayOffController = TextEditingController();
  final PageController pageController = PageController();

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
    if (croppedImage != null) {
      getController.changeImage(croppedImage.path);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    fullNameController.text = '${getController.meUsers.value.res?.fistName} ${getController.meUsers.value.res!.lastName}';
    nikNameController.text = getController.meUsers.value.res?.userName ?? '';
    phoneNumberController.text = getController.meUsers.value.res?.phoneNumber ?? '';

    ApiController().getRegion();
    ApiController().getCategory().then((value) {
      ApiController().getSubCategory(getController.categoryIndex.value);
    });
    return SingleChildScrollView(
      child:Column(
        children: [
          SizedBox(
            width: w,
            height: h * 0.74,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                SizedBox(
                  width: w,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: h * 0.01,bottom: h * 0.01),
                        padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: w * 0.1,
                              child: IconButton(
                                onPressed: () {
                                  getController.entersUser.value = 0;
                                },
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                            ),
                            const Spacer(),
                            Obx(() => getController.image.value == ''
                                ? CircleAvatar(
                              radius: w * 0.12,
                              foregroundColor: Colors.blue,
                              backgroundImage: NetworkImage('${getController.meUsers.value.res?.photoUrl}'),
                            )
                                : CircleAvatar(
                              radius: w * 0.12,
                              foregroundColor: Colors.blue,
                              backgroundImage: FileImage(File(getController.image.value)),
                            )),
                            const Spacer(),
                            SizedBox(width: w * 0.1)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.05,
                        child: TextButton(
                          onPressed: () {
                            _pickImage(ImageSource.gallery);
                          },
                          child: Text(
                            'Profil rasmini tahrirlash',
                            style: TextStyle(
                              fontSize: w * 0.04,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.05),
                      TextFildWidget(
                        controller: nikNameController,
                        labelText: 'Foydalanuvchi nomi',
                      ),
                      SizedBox(height: h * 0.02),
                      Container(
                        width: w * 0.9,
                        height: h * 0.06,
                        margin: EdgeInsets.only(bottom: h * 0.02),
                        padding: EdgeInsets.only(right: w * 0.02, left: w * 0.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Obx(() => getController.getRegion.value.res != null
                            ? DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                            iconSize: w * 0.06,
                            value: getController.getRegion.value.res![getController.regionIndex.value],
                            hint: Padding(
                              padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
                              child: Text('Region', style: TextStyle(fontSize: w * 0.04,),
                              ),
                            ),
                            items: getController.getRegion.value.res!.map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, style: TextStyle(fontSize: w * 0.035),
                              ),
                            ),
                            ).toList(),
                            onChanged: (value) {
                              int index = getController.getRegion.value.res!.indexWhere((element) => element == value);
                              getController.changeRegionIndex(index);
                            },
                          ),
                        ) : SizedBox(
                          width: w * 0.1,
                          height: h * 0.1,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        ),
                      ),
                      //dropdown menu for category
                      Container(
                        width: w * 0.9,
                        height: h * 0.06,
                        margin: EdgeInsets.only(bottom: h * 0.02),
                        padding: EdgeInsets.only(right: w * 0.02, left: w * 0.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Obx(() => getController.category.value.res != null
                            ? DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                            iconSize: w * 0.06,
                            value: getController.categoryIndex.value,
                            hint: Padding(
                              padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
                              child: Text('Faoliyat turi', style: TextStyle(fontSize: w * 0.04),),
                            ),
                            items: getController.category.value.res!.map((e) => DropdownMenuItem(
                              value: e.id,
                              child: Text(e.name ?? '', style: TextStyle(fontSize: w * 0.035),
                              ),
                            ),
                            ).toList(),
                            onChanged: (value) {
                              getController.changeCategoryID(int.parse(value.toString()));
                              int index = getController.category.value.res!.indexWhere((element) => element.id == value);
                              ApiController().getSubCategory(getController.category.value.res![index].id!);
                            },
                          ),
                        )
                            : SizedBox(
                          width: w * 0.1,
                          height: h * 0.1,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        ),
                      ),
                      Container(
                        width: w * 0.9,
                        height: h * 0.06,
                        margin: EdgeInsets.only(bottom: h * 0.02),
                        padding: EdgeInsets.only(right: w * 0.02, left: w * 0.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Obx(() => getController.subCategory.value.res != null
                            ? DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Colors.white,
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                              iconSize: w * 0.06,
                              value: getController.subCategoryIndex.value,
                              hint: Padding(
                                padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
                                child: Text('Yo\'nalishlar', style: TextStyle(fontSize: w * 0.04,),
                                ),
                              ),
                              items: getController.subCategory.value.res!.map((e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name ?? '', style: TextStyle(fontSize: w * 0.035)))).toList(),
                              onChanged: (value) {getController.changeSubCategoryID(int.parse(value.toString()));},
                            )) : SizedBox(
                          width: w * 0.1,
                          height: h * 0.1,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        ),
                      ),
                      //dropdown menu for experience
                      TextFildWidget(
                        controller: nameInstitutionController,
                        labelText: 'Shirkat (tashkilot) nomi',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: w * 0.01),
                          IconButton(
                            onPressed: () {
                              pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                              getController.nextPages.value = 0;
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: h * 0.01),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.07),
                        child: Text(
                          'O\'zingiz haqingizda qisqacha',
                          style: TextStyle(fontSize: w * 0.03),
                        ),
                      ),
                      Container(
                        width: w,
                        height: h * 0.2,
                        margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        padding: EdgeInsets.only(
                            right: w * 0.02, left: w * 0.02, bottom: h * 0.01),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: TextField(
                          maxLines: 10,
                          maxLength: 300,
                          controller: bioController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'O\'zingiz haqingizda',
                            hintStyle: TextStyle(
                              fontSize: w * 0.04,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: w * 0.04,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.07, top: h * 0.01),
                        child: Text(
                          'Ish kunlaringizni kiriting',
                          style: TextStyle(fontSize: w * 0.03),
                        ),
                      ),
                      Container(
                        width: w,
                        height: h * 0.25,
                        margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        padding: EdgeInsets.only(right: w * 0.02, left: w * 0.02, bottom: h * 0.01),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: TextField(
                          maxLines: 10,
                          controller: dayOffController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ish kunlaringizni',
                            hintStyle: TextStyle(
                              fontSize: w * 0.04,
                            ),
                          ),
                        ),
                      ),
                      //Ish tajribangiz
                      SizedBox(height: h * 0.01),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.07),
                        child: Text(
                          'Ish tajribangiz (yil)',
                          style: TextStyle(fontSize: w * 0.03),
                        ),
                      ),
                      TextFildWidget(
                        //keyboardType: number keyboard not ',' and '.'
                        keyboardType: TextInputType.number,
                        controller: experienceController,
                        labelText: 'Faqat raqamlar bilan',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
              controller: pageController,
              // PageController
              count: 2,
              axisDirection: Axis.horizontal,
              effect: WormEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.blue,
                  dotHeight: h * 0.005,
                  dotWidth: w * 0.08,
                  spacing: 8.0),
              // your preferred effect
              onDotClicked: (index) {}),
          Obx(() => getController.nextPages.value == 1
              ? EditButton(text: 'Save',
            onPressed: () {
              if (nikNameController.text.isEmpty) {
                getController.changeFullName(nikNameController.text);
                Toast.showToast(context, 'Foydalanuvchi nomi bo\'sh', Colors.red, Colors.white,);
                return;
              }
              if (nameInstitutionController.text.isEmpty) {
                getController.changeFullName(fullNameController.text);
                Toast.showToast(context, 'Shirkat (tashkilot) nomi bo\'sh', Colors.red, Colors.white,);
                return;
              }
              if (getController.subCategory.value.res == null) {
                Toast.showToast(context, 'Yo\'nalishlar bo\'sh', Colors.red, Colors.white,);
                return;
              }
              if (getController.getRegion.value.res == null) {
                Toast.showToast(context, 'Viloyatlar bo\'sh', Colors.red, Colors.white,);
                return;
              }
              if (experienceController.text.isEmpty) {
                Toast.showToast(context, 'Ish tajribangizni kiriting', Colors.red, Colors.white,);
                return;
              }
              experienceController.text = experienceController.text.replaceAll(',', '.');

              if (experienceController.text.split('.').length > 2) {
                Toast.showToast(context, 'Iltimos, to\'g\'ri raqam kiriting', Colors.red, Colors.white,);
                return;
              }
              num experience;
              if (experienceController.text.contains('.')) {
                experience = double.parse(experienceController.text);
              }
              else {
                experience = int.parse(experienceController.text);
              }
              if (croppedImage != null) {
                ApiController().editUserPhoto(croppedImage.path).then(
                        (value) => ApiController().editUser(
                        getController.meUsers.value.res?.fistName ?? '',
                        getController.meUsers.value.res?.lastName ?? '',
                        nikNameController.text,
                        getController.getRegion.value.res![getController.regionIndex.value]
                    ).then((value) {
                      if (value.status!) {
                        ApiController().getUserData().then((value) {
                          ApiController().createBusiness(
                              getController.subCategoryIndex.value,
                              getController.getRegion.value.res![
                              getController.regionIndex.value],
                              nameInstitutionController.text,
                              experience,
                              bioController.text,
                              dayOffController.text).then((value) {
                            if (value) {
                              getController.index.value = 0;
                              ApiController().getUserData().then((value) =>finish());
                            } else {
                              //Toast.showToast(context, 'Error', Colors.red, Colors.white);
                              Toast.showToast(context, 'Nimadir xato ketdi', Colors.red, Colors.white,);
                            }
                          });
                        });
                      } else {
                        Toast.showToast(context, 'Nimadir xato ketdi', Colors.red, Colors.white,);
                      }
                    }));
              } else {
                ApiController().editUser(
                    getController.meUsers.value.res?.fistName ?? '',
                    getController.meUsers.value.res?.lastName ?? '',
                    nikNameController.text,
                    getController.getRegion.value.res![getController.regionIndex.value]
                ).then((value) {
                  if (value.status!) {
                    ApiController().getUserData().then((value) {
                      ApiController().createBusiness(
                          getController.subCategoryIndex.value,
                          getController.getRegion.value.res![getController.regionIndex.value],
                          nameInstitutionController.text,
                          experience,
                          bioController.text,
                          dayOffController.text).then((value) {
                        if (value) {
                          getController.index.value = 0;
                          ApiController().getUserData().then((value) => finish());
                        } else {
                          Toast.showToast(context, 'Nimadir xato ketdi', Colors.red, Colors.white,);
                        }
                      });
                    });
                  } else {
                    Toast.showToast(context, 'Ex Nimadir xato ketdi', Colors.red, Colors.white,);
                  }
                });
              }
            },
          ) : EditButton(
            text: 'Keyingi',
            onPressed: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
              getController.nextPages.value = 1;
            },
          )),
          SizedBox(height: h * 0.01),
        ],
      ),
    );
  }

  finish() {
    getController.entersUser.value = 0;
    getController.nextPages.value = 0;
  }
}
