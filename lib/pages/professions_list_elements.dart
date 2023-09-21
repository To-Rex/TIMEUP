import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_up/pages/professions_list_details.dart';
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
              _getController.enterProfessionsListElements.value = false;
            },
            child: Row(
              children: [
                SizedBox(width: w * 0.04),
                const Icon(Icons.arrow_back_ios),
                const Expanded(child: SizedBox()),
                Text(
                  'Kasblar ro’yxati (${professions.length})',
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
          child: Expanded(
              child: ListView(
            children: [
              for (var profession in professions)
                GestureDetector(
                  onTap: () {
                    //ProfessionsListDetails
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProfessionsListDetails();
                    }));
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
                        profession,
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          )),
        )
      ],
    );
  }
}
