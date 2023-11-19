import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

  getUsers() async {
    getController.changeMeUser(await ApiController().getUserData());
  }

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
    }else{
      print('null$croppedImage');
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

    ApiController().getRegion().then((value) {getController.changeRegion(value);});
    ApiController().getCategory().then((value) {
      getController.changeCategory(value);
      getController.categoryIndex.value = value.res![0].id!;
      ApiController().getSubCategory(getController.categoryIndex.value).then((value) {
        getController.changeSubCategory(value);
        getController.subCategoryIndex.value = value.res![0].id!;
      });
    });

    return Column(
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
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Container(
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
                                  backgroundImage: NetworkImage(
                                      '${getController.meUsers.value.res?.photoUrl}'),
                                )
                              : CircleAvatar(
                                  radius: w * 0.12,
                                  foregroundColor: Colors.blue,
                                  backgroundImage: FileImage(
                                      File(getController.image.value)),
                                )),
                          const Spacer(),
                          SizedBox(width: w * 0.1)
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    SizedBox(
                      height: h * 0.05,
                      child: TextButton(
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
                    ),
                    SizedBox(height: h * 0.05),
                    TextFildWidget(
                      controller: nikNameController,
                      labelText: 'Nikname',
                    ),
                    SizedBox(height: h * 0.02),
                    //dropdown menu for region
                    Container(
                      width: w * 0.9,
                      height: h * 0.07,
                      padding: EdgeInsets.only(right: w * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Obx(
                        () => getController.getRegion.value.res != null
                            ? DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                  iconSize: w * 0.06,
                                  value: getController.getRegion.value
                                      .res![getController.regionIndex.value],
                                  hint: Padding(
                                    padding: EdgeInsets.only(
                                        left: w * 0.02, right: w * 0.02),
                                    child: Text(
                                      'Region',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                      ),
                                    ),
                                  ),
                                  items: getController.getRegion.value.res!
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: w * 0.02,
                                                right: w * 0.02),
                                            child: Text(
                                              e,
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    int index = getController
                                        .getRegion.value.res!
                                        .indexWhere(
                                            (element) => element == value);
                                    getController.changeRegionIndex(index);
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
                    SizedBox(height: h * 0.02),
                    //dropdown menu for category
                    Container(
                      width: w * 0.9,
                      height: h * 0.07,
                      padding: EdgeInsets.only(right: w * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Obx(
                        () => getController.category.value.res != null
                            ? DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                  iconSize: w * 0.06,
                                  value: getController.categoryIndex.value,
                                  hint: Padding(
                                    padding: EdgeInsets.only(
                                        left: w * 0.02, right: w * 0.02),
                                    child: Text(
                                      'Type of activity',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                      ),
                                    ),
                                  ),
                                  items: getController.category.value.res!
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.id,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: w * 0.02,
                                                right: w * 0.02),
                                            child: Text(
                                              e.name ?? '',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    getController
                                        .changeCategoryID(value as int);
                                    int index = getController
                                        .category.value.res!
                                        .indexWhere(
                                            (element) => element.id == value);
                                    ApiController()
                                        .getSubCategory(getController
                                            .category.value.res![index].id!)
                                        .then((values) {
                                      getController.changeSubCategory(values);
                                    });
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
                    SizedBox(height: h * 0.02),
                    //dropdown menu for subcategory
                    Container(
                      width: w * 0.9,
                      height: h * 0.07,
                      padding: EdgeInsets.only(right: w * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Obx(
                        () => getController.subCategory.value.res != null
                            ? DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                  iconSize: w * 0.06,
                                  value: getController.subCategoryIndex.value,
                                  hint: Padding(
                                    padding: EdgeInsets.only(
                                        left: w * 0.02, right: w * 0.02),
                                    child: Text(
                                      'Subcategory',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                      ),
                                    ),
                                  ),
                                  items: getController.subCategory.value.res!
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.id,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: w * 0.02,
                                                right: w * 0.02),
                                            child: Text(
                                              e.name ?? '',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    getController
                                        .changeSubCategoryID(value as int);
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
                    SizedBox(height: h * 0.02),
                    TextFildWidget(
                      controller: nameInstitutionController,
                      labelText: 'Name of the institution',
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
                        IconButton(
                          onPressed: () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                            getController.nextPages.value = 0;
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: h * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05),
                      child: Text(
                        'About yourself',
                        style: TextStyle(fontSize: w * 0.03),
                      ),
                    ),
                    Container(
                      width: w,
                      height: h * 0.2,
                      margin: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
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
                          hintText: 'About yourself',
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
                      padding: EdgeInsets.only(left: w * 0.05, top: h * 0.01),
                      child: Text(
                        'Write down your days off',
                        style: TextStyle(fontSize: w * 0.03),
                      ),
                    ),
                    Container(
                      width: w,
                      height: h * 0.25,
                      margin: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
                      padding: EdgeInsets.only(
                          right: w * 0.02, left: w * 0.02, bottom: h * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextField(
                        maxLines: 10,
                        controller: dayOffController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write down your days off',
                          hintStyle: TextStyle(
                            fontSize: w * 0.04,
                          ),
                        ),
                      ),
                    ),
                    //Ish tajribangiz
                    SizedBox(height: h * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05),
                      child: Text(
                        'Ish tajribangiz',
                        style: TextStyle(fontSize: w * 0.03),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                      child: TextFildWidget(
                        //keyboardType: number keyboard not ',' and '.'
                        keyboardType: TextInputType.number,
                        controller: experienceController,
                        labelText: '__',
                      ),
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
        Obx(
          () => getController.nextPages.value == 1
              ? EditButton(
                  text: 'Save',
                  onPressed: () {
                    if (nikNameController.text.isEmpty) {
                      getController.changeFullName(nikNameController.text);
                      Toast.showToast(
                        context,
                        'Nikname is empty',
                        Colors.red,
                        Colors.white,
                      );
                      return;
                    }
                    if (nameInstitutionController.text.isEmpty) {
                      getController.changeFullName(fullNameController.text);
                      Toast.showToast(
                        context,
                        'Name of the institution is empty',
                        Colors.red,
                        Colors.white,
                      );
                      return;
                    }
                    /*if (phoneNumberController.text.isEmpty) {
                      getController.changeFullName(phoneNumberController.text);
                      Toast.showToast(
                        context,
                        'Phone number is empty',
                        Colors.red,
                        Colors.white,
                      );
                      return;
                    }*/
                    if (getController.subCategory.value.res == null) {
                      getController.changeFullName(getController
                          .subCategory
                          .value
                          .res![getController.subCategoryIndex.value]
                          .name!);
                      Toast.showToast(
                        context,
                        'Subcategory is empty',
                        Colors.red,
                        Colors.white,
                      );
                      return;
                    }
                    if (getController.getRegion.value.res == null) {
                      getController.changeFullName(getController.getRegion.value.res![getController.regionIndex.value]);
                      Toast.showToast(context, 'Region is empty', Colors.red, Colors.white,);
                      return;
                    }
                    if (experienceController.text.isEmpty) {
                      Toast.showToast(context, 'Experience is empty', Colors.red, Colors.white,);
                      return;
                    }
                    experienceController.text = experienceController.text.replaceAll(',', '.');

                    if (experienceController.text.split('.').length > 2) {
                      Toast.showToast(context, 'Please enter a valid number', Colors.red, Colors.white,);
                      return;
                    }
                    num experience;
                    if (experienceController.text.contains('.')) {
                      experience = double.parse(experienceController.text);
                    } else {
                      experience = int.parse(experienceController.text);
                    }
                    if (croppedImage!=null) {
                      ApiController().editUserPhoto(croppedImage.path).then((value) =>
                          ApiController().editUser(
                              getController.meUsers.value.res?.fistName ?? '',
                              getController.meUsers.value.res?.lastName ?? '',
                              getController.getRegion.value.res![getController.regionIndex.value],
                              nikNameController.text).then((value) {
                            if (value.status!) {
                              ApiController().getUserData().then((value) {
                                ApiController().createBusiness(
                                    getController.subCategory.value.res![getController.subCategoryIndex.value].id!,
                                    getController.getRegion.value.res![getController.regionIndex.value],
                                    nameInstitutionController.text,
                                    experience, bioController.text,
                                    dayOffController.text).then((value) {
                                  if (value) {
                                    ApiController().getUserData().then((value) {getController.changeMeUser(value);});
                                    finish();
                                  } else {
                                    Toast.showToast(context, 'Error', Colors.red, Colors.white,);
                                  }
                                });
                                getController.changeMeUser(value);
                              });
                            } else {
                              Toast.showToast(context, 'Error', Colors.red, Colors.white);
                            }
                          })
                      );
                    } else {
                      ApiController().editUser(
                          getController.meUsers.value.res?.fistName ?? '',
                          getController.meUsers.value.res?.lastName ?? '',
                          getController.getRegion.value.res![getController.regionIndex.value],
                          nikNameController.text).then((value) {
                        if (value.status!) {
                          ApiController().getUserData().then((value) {
                            ApiController().createBusiness(
                                getController.subCategory.value.res![getController.subCategoryIndex.value].id!,
                                getController.getRegion.value.res![getController.regionIndex.value],
                                nameInstitutionController.text,
                                experience,
                                bioController.text,
                                dayOffController.text).then((value) {
                              if (value) {
                                ApiController().getUserData().then((value) {getController.changeMeUser(value);});
                                finish();
                              } else {
                                Toast.showToast(context, 'Error', Colors.red, Colors.white,);
                              }
                            });
                            getController.changeMeUser(value);
                          });
                        } else {
                          Toast.showToast(
                            context,
                            'Error',
                            Colors.red,
                            Colors.white,
                          );
                        }
                      });
                    }

                  },
                )
              : EditButton(
                  text: 'Next',
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                    getController.nextPages.value = 1;
                  },
                ),
        ),
        SizedBox(height: h * 0.01),
      ],
    );
  }

  finish() {
    getController.entersUser.value = 0;
    getController.nextPages.value = 0;
  }
}
