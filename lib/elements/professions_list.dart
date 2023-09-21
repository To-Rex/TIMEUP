import 'package:flutter/material.dart';

class ProfessionsList extends StatelessWidget {
  final List<String> professions;

  const ProfessionsList({Key? key, required this.professions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      height: h * 0.05,
      child: ListView.builder(
    scrollDirection: Axis.horizontal,
      itemCount: professions.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          child: Center(
            child: Text(
              professions[index],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    ),);
  }
}