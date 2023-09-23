import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_up/pages/professions_list_details.dart';
import '../res/getController.dart';

class ProfessionsListUsers extends StatelessWidget {
  final List<String> professions;
  final Function(String) onTap;

  ProfessionsListUsers({
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
              _getController.enters.value = 1;
            },
            child: Row(
              children: [
                SizedBox(width: w * 0.04),
                const Icon(Icons.arrow_back_ios),
                const Expanded(child: SizedBox()),
                Text(
                  'Urolog',
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
            height: h * 0.74,
            width: w * 0.9,
            child: ListView(
              children: [
                for (int i = 0; i < 15; i++)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails()));
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            //circle avatar
                            SizedBox(
                              width: w * 0.2,
                              height: w * 0.2,
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/images/doctor.png'),
                              ),
                            ),
                            SizedBox(width: w * 0.05),
                            //name and profession
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. John Doe',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Urolog',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.02),
                      ],
                    ),
                  ),
              ],
            )
        ),
      ],
    );
  }
}
