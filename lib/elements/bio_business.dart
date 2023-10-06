import 'package:flutter/material.dart';

class BioBusiness extends StatelessWidget {
  String text;
  BioBusiness({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      width: w * 0.95,
      height: h * 0.26,
      margin: EdgeInsets.only(top: h * 0.02),
      padding: EdgeInsets.all(w * 0.02),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: SingleChildScrollView(
        child: Text(
          text,
          style: TextStyle(
            fontSize: w * 0.04,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
