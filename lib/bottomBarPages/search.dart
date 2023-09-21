import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../elements/professions_list.dart';
import '../pages/professions_list_elements.dart';
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

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Expanded(
      child: Column(
        children: [
          Text(
            'Kasblar ro’yxati',
            style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          ProfessionsList(
              professions: professions,
              onTap: (profession) {
                // Navigate to the professions list page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfessionsListElements(
                      professions: professions,
                      onTap: (profession){
                        print(profession);
                      }
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
