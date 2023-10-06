import 'package:flutter/material.dart';

class BusinessEditButton extends StatelessWidget {
  String text;
  late Color color;
  late double radius;
  Function()? onPressed;

  BusinessEditButton({
    Key? key,
    required this.text,
    required this.color,
    required this.radius,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      width: w * 0.9,
      margin: EdgeInsets.only(top: h * 0.02),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: w * 0.04,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
