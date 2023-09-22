import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../elements/professions_list.dart';
import '../pages/professions_list_elements.dart';
import '../pages/professions_list_users.dart';
import '../res/getController.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());

  var professions = [
    'Sartaroshlik',
    'Ta’lim',
    'Tibbiyot',
    'Iqtisodiyot',
    'Texnika',
    'Ishlab chiqarish',
    'Xizmatlar',
    'Boshqa',
    'Tibbiyot',
    'Iqtisodiyot',
    'Texnika',
    'Ishlab chiqarish',
    'Xizmatlar',
    'Boshqa',
    'Sartaroshlik',
    'Ta’lim',
    'Tibbiyot',
    'Iqtisodiyot',
    'Texnika',
    'Ishlab chiqarish',
    'Xizmatlar',
    'Boshqa',
    'Tibbiyot',
    'Iqtisodiyot',
    'Texnika'
  ];
  var profession = [
    'Stomatolog',
    'Kardiolog',
    'Terapevt',
    'Nevrolog',
    'Oftalmolog',
    'Dermatolog',
    'Ginekolog',
    'Urolog',
    'Endokrinolog',
    'Nevrohirurg',
    'Psixolog',
    'Psixiater',
    'Onkolog',
    'Radiolog',
    'Rentgenolog',
    'Mikrobiolog',
    'Parazitolog',
    'Immunolog',
    'Epidemiolog',
    'Patolog',
    'Anesteziolog',
    'Reanimatolog',
    'Feldsher'
  ];

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: h * 0.02),
        /*Obx(() => _getController.enterProfessionsListElements.value
            ? ProfessionsListElements(
            professions: profession,
            onTap: (profession) {
              _getController.enterProfessionsListElements.value = false;
            })
            : ProfessionsList(
            professions: professions,
            onTap: (profession) {
              _getController.enterProfessionsListElements.value = true;
            })),*/
        //_getController.enterProfessionsListElements.value = 0 ProfessionsList else ProfessionsListElements if 2 ProfessionsListUsers
        Obx(() => _getController.enters.value == 0
            ? ProfessionsList(
                professions: professions,
                onTap: (profession) {
                  _getController.enters.value = 1;
                })
            : _getController.enters.value == 1
                ? ProfessionsListElements(
                    professions: profession,
                    onTap: (profession) {
                      _getController.enters.value = 2;
                    })
                : ProfessionsListUsers(
                    professions: profession,
                    onTap: (profession) {
                      _getController.enters.value = 0;
                    },
                  )),
      ],
    );
  }
}
