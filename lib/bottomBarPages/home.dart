import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../res/getController.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: h * 0.02,
          ),
          Image(
            image: const AssetImage('assets/images/home.png'),
            //height: h * 0.2,
            fit: BoxFit.contain,
            width: w,
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: w * 0.05,
              ),
              const Icon(
                //phone
                Icons.phone,
                color: Colors.blue,
              ),
              SizedBox(
                width: w * 0.02,
              ),
              const Icon(
                Icons.location_on,
                color: Colors.blue,
              ),
              SizedBox(
                width: w * 0.02,
              ),
              const Icon(
                Icons.work,
                color: Colors.blue,
              ),
            ],
          ),
          SizedBox(
            height: h * 0.02,
          ),
          //Doctor_sobit
          Container(
            margin: EdgeInsets.only(left: w * 0.05),
            child: const Text(
              'Doctor_Sobit',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //Urolog
          Container(
            margin: EdgeInsets.only(left: w * 0.05),
            child: const Text(
              'Urolog',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          //САЛОМ МЕН ДОКТОР ИСЧАНОВ НОДИРБЕК ИСЧАНOВИЧ,\n
          // МИЛЛАТИМ ЎЗБЕК...More
          SizedBox(
            height: h * 0.02,
          ),
          Container(
            margin: EdgeInsets.only(left: w * 0.05),
            child: Text(
              'САЛОМ МЕН ДОКТОР ИСЧАНОВ НОДИРБЕК ИСЧАНOВИЧ,\nМИЛЛАТИМ ЎЗБЕК... More',
              style: TextStyle(
                fontSize: w * 0.03 > 15 ? 15 : w * 0.03,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
