import 'package:flutter/material.dart';
import 'package:time_up/api/api_controller.dart';

class ProfessionsList extends StatelessWidget {
  final List<String> professions;
  //on tap
  final Function(String) onTap;

  const ProfessionsList({
    Key? key,
    required this.professions,
    required this.onTap,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    ApiController().getCategory();
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
            itemCount: professions.length,
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onTap(professions[index]);
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
                      professions[index],
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
