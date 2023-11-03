import 'package:flutter/material.dart';

class TextEditButton extends StatelessWidget {
  String text;
  late Color color;
  late String icon;

  TextEditButton({
    Key? key,
    required this.text,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      width: w * 0.9,
      height: h * 0.032,
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          SizedBox(
            width: w * 0.06,
            height: h * 0.05,
            child: Image(
              image: AssetImage(icon),
              width: w * 0.05,
              height: h * 0.05,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: w * 0.01,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
