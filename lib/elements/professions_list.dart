import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_up/api/api_controller.dart';

import '../res/getController.dart';

class ProfessionsList extends StatelessWidget {
  final List<String> professions;
  //on tap
  final Function(String) onTap;

  ProfessionsList({
    Key? key,
    required this.professions,
    required this.onTap,
  }) : super(key: key);

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    ApiController().getCategory().then((value) => _getController.changeCategory(value));


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Kasblar royhati',
          style: TextStyle(
            fontSize: w * 0.05,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: h * 0.02),
        SizedBox(
          width: w,
          height: h * 0.74,
          child: ListView.builder(
            itemCount: _getController.category.value.res?.length ?? 0,
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print(_getController.category.value.res?[index].id.toString() ?? '');
                  onTap(_getController.category.value.res?[index].id.toString() ?? '');
                },
                child: Container(
                  height: h * 0.06,
                  margin: EdgeInsets.only(bottom: h * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(w * 0.02),
                  ),
                  child: Center(
                    child: Text(
                      _getController.category.value.res?[index].name ?? '',
                      style: TextStyle(
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
