import 'package:flutter/material.dart';

class ProfessionsList extends StatelessWidget {
  final List<String> professions;

  const ProfessionsList({Key? key, required this.professions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Expanded(
      child: SizedBox(
        width: w,
        child: ListView.builder(
          itemCount: professions.length,
          padding: EdgeInsets.all(w * 0.02),
          itemBuilder: (context, index) {
            return Container(
              height: h * 0.07,
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
            );
          },
        ),
      ),
    );
  }
}
