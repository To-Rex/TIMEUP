import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/api_controller.dart';
import '../elements/professions_list.dart';
import '../pages/login_page.dart';
import '../pages/professions_list_elements.dart';
import '../pages/professions_list_users.dart';
import '../res/getController.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());
  int? index;

  var profession = [
    'Stomatolog',
    'Anesteziolog',
    'Reanimatolog',
    'Feldsher'
  ];

  @override
  Widget build(BuildContext context) {
    if(GetStorage().read('token') == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: h * 0.02),
        Obx(() => _getController.enters.value == 0
            ? ProfessionsList(
                onTap: (profession) {
                  _getController.enters.value = 1;
                  index = profession;
                })
            : _getController.enters.value == 1
                ? ProfessionsListElements(
                    index: index,
                    onTap: (profession) {
                      _getController.enters.value = 2;
                    })
                : ProfessionsListUsers(
                    onTap: (profession) {
                      _getController.enters.value = 0;
                    },
                  )),
      ],
    );
  }
}
