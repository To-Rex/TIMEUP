import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameInstitutionController =
      TextEditingController();

  getUsers() async {
    getController.changeMeUser(
        await ApiController().getUserData(GetStorage().read('token')));
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    fullNameController.text = getController.meUsers.value.res?.lastName ?? '';
    nikNameController.text = getController.meUsers.value.res?.userName ?? '';
    addressController.text = getController.meUsers.value.res?.address ?? '';

    ApiController().getCategory().then((value) {
      getController.changeCategory(value);
      getController.categoryIndex.value = value.res![0].id!;
    });

    ApiController().getSubCategory(getController.categoryIndex.value).then((value) {
      getController.changeSubCategory(value);
      print(getController.subCategoryIndex.value);
    });

    ApiController().getRegion().then((value) {
      getController.changeRegion(value);
    });

    return SizedBox(
      width: w,
      child: Column(
        children: [
          SizedBox(
            height: h * 0.01,
          ),
          Center(
            child: CircleAvatar(
              radius: w * 0.12,
              foregroundColor: Colors.blue,
              backgroundImage: NetworkImage(
                  'http://${getController.meUsers.value.res?.photoUrl}'),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Edit profile photo',
              style: TextStyle(
                fontSize: w * 0.04,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: h * 0.01),
          TextFildWidget(
            controller: nikNameController,
            labelText: 'Nikname',
          ),
          SizedBox(height: h * 0.015),
          TextFildWidget(
            controller: fullNameController,
            labelText: 'Full name',
          ),

          SizedBox(height: h * 0.015),
          TextFildWidget(
            controller: addressController,
            labelText: 'Adress',
          ),
          SizedBox(height: h * 0.015),
          //dropdown menu for region
          Container(
            width: w * 0.9,
            height: h * 0.07,
            padding: EdgeInsets.only( right: w * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  iconSize: w * 0.06,
                  value: getController.getRegion.value.res![getController.regionIndex.value],
                  hint: Padding(
                    padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
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
                            padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
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
                    int index = getController.getRegion.value.res!
                        .indexWhere((element) => element == value);
                    getController.changeRegionIndex(index);
                  },
                ),
              ),
            ),
          ),

          SizedBox(height: h * 0.015),

          //dropdown menu for category
          Container(
            width: w * 0.9,
            height: h * 0.07,
            padding: EdgeInsets.only( right: w * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  iconSize: w * 0.06,
                  value: getController.categoryIndex.value,
                  hint: Padding(
                    padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
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
                            padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
                            child: Text(
                              e.name!,
                              style: TextStyle(
                                fontSize: w * 0.04,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    getController.changeCategoryID(value as int);
                    int index = getController.category.value.res!
                        .indexWhere((element) => element.id == value);
                    ApiController()
                        .getSubCategory(getController.category.value.res![index].id!)
                        .then((value) {
                      getController.changeSubCategory(value);
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: h * 0.015),

          //dropdown menu for subcategory
          Container(
            width: w * 0.9,
            height: h * 0.07,
            padding: EdgeInsets.only( right: w * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  iconSize: w * 0.06,
                  value: getController.subCategoryIndex.value,
                  hint: Padding(
                    padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
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
                            padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
                            child: Text(
                              e.name!,
                              style: TextStyle(
                                fontSize: w * 0.04,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    getController.changeSubCategoryID(value as int);
                  },
                ),
              ),
            ),
          ),

          SizedBox(height: h * 0.015),
          TextFildWidget(
            controller: nameInstitutionController,
            labelText: 'Name of the institution',
          ),
          EditButton(
            text: 'Save data',
            onPressed: () {

            },
          ),
          SizedBox(height: h * 0.05),
        ],
      ),
    );
  }
}
