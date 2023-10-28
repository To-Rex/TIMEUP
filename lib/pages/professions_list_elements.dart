import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/api_controller.dart';
import '../res/getController.dart';

class ProfessionsListElements extends StatelessWidget {
  int? index;
  final Function(String) onTap;

  ProfessionsListElements({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    ApiController().getSubCategory(index!.toInt()).then((value) => {
      _getController.changeSubCategory(value),
      _getController.changeTitleListElements(_getController.category.value.res![index!].name!)});
    return Column(
      children: [
        SizedBox(
          child: GestureDetector(
            onTap: () {
              _getController.clearSubCategory();
              _getController.enters.value = 0;
            },
            child: Row(
              children: [
                SizedBox(width: w * 0.04),
                const Icon(Icons.arrow_back_ios),
                const Expanded(child: SizedBox()),
                Text('Tibbiyot Kasblar royhati', style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.w500,),),
                const Expanded(child: SizedBox()),
                SizedBox(width: w * 0.04),
              ],
            ),
          ),
        ),
        SizedBox(height: h * 0.02),
        // List of professions taking up the remaining space
        Obx(() => _getController.subCategory.value.res == null
            ? const Center(child: Text('No data'))
            : SizedBox(
            height: h * 0.74,
            width: w * 0.9,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      _getController.categoryByID.value = _getController.subCategory.value.res![index].id!;
                      _getController.enters.value = 2;
                      _getController.changeTitleListElements(_getController.subCategory.value.res![index].name!);
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              _getController.subCategory.value.res?[index].name ?? '',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Icon(Icons.arrow_forward_ios, size: w * 0.04),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ));
              },
              itemCount: _getController.subCategory.value.res?.length,
              cacheExtent: w * 0.1,
              dragStartBehavior: DragStartBehavior.down,
              prototypeItem: Container(
                height: h * 0.04,
                margin: EdgeInsets.only(bottom: h * 0.02),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(w * 0.02),
                ),
              ),
            )),
        ),
      ],
    );
  }
}