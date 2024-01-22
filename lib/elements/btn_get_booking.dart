import 'package:flutter/material.dart';

class BookingGetSer extends StatelessWidget {
  String text;
  var color;
  late double radius;
  Function()? onPressed;

  BookingGetSer({
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
      width: w * 0.4,
      margin: EdgeInsets.only(top: h * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),

      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.blue.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          elevation: 6,
        ),
        child: Text(text,
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
