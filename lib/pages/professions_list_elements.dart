
import 'package:flutter/material.dart';

class ProfessionsListElements extends StatelessWidget {
  final List<String> professions;
  final Function(String) onTap;

  const ProfessionsListElements({Key? key, required this.professions, required this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Kasblar ro’yxati'),
      ),
      body: SizedBox(
        width: w,
        height: h,
        child: Expanded(
          child: SizedBox(
            width: w,
            child: ListView.builder(
              itemCount: professions.length,
              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Call the onTap callback with the selected profession
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
        ),
      )
    );
  }
}