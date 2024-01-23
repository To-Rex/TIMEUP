import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../elements/professions_list.dart';
import '../pages/login_page.dart';
import '../pages/professions_list_elements.dart';
import '../pages/professions_list_users.dart';
import '../res/getController.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());
  int? index;

  showDialogs(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Haqiqatan ham chiqmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yo\'q'),
          ),
          TextButton(
            onPressed: () {
              GetStorage().remove('token');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: const Text('Ha', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          if (_getController.enters.value == 0) {
            return true;
          } else if (_getController.enters.value == 1) {
            _getController.enters.value = 0;
            return false;
          } else if (_getController.enters.value == 2) {
            _getController.enters.value = 1;
            return false;
          } else {
            return false;
          }
        },
        child: Column(
          children: [
            SizedBox(height: h * 0.02),
            Obx(() => _getController.enters.value == 0
                ? ProfessionsList(onTap: (profession) {
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
                          _getController.enters.value = 1;
                        },
                      )),
          ],
        ));
  }
}
