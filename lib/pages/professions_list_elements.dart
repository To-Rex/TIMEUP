import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/getController.dart';

class ProfessionsListElements extends StatelessWidget {
  final List<String> professions;
  final Function(String) onTap;

  ProfessionsListElements({
    Key? key,
    required this.professions,
    required this.onTap,
  }) : super(key: key);

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          child: GestureDetector(
            onTap: () {
              _getController.enters.value = 0;
            },
            child: Row(
              children: [
                SizedBox(width: w * 0.04),
                const Icon(Icons.arrow_back_ios),
                const Expanded(child: SizedBox()),
                Text(
                  'Tibbiyot Kasblar royhati',
                  style: TextStyle(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Expanded(child: SizedBox()),
                SizedBox(width: w * 0.04),
              ],
            ),
          ),
        ),
        SizedBox(height: h * 0.02),
        // List of professions taking up the remaining space
        SizedBox(
            height: h * 0.75,
            width: w * 0.9,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      _getController.enters.value = 2;
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              professions[index],
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Icon(Icons.arrow_forward_ios, size: w * 0.04),
                          ],
                        ),
                        const Divider(),
                      ],
                    ));
              },
              itemCount: professions.length,
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
      ],
    );
  }
}
