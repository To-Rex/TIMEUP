import 'package:flutter/material.dart';

class TextFildWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final String? suffixText;

  const TextFildWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      this.keyboardType,
      this.suffixText
      });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.06,
      width: w,
      margin: EdgeInsets.only(left: w * 0.05, right: w * 0.05,),
      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: 1,
        minLines: 1,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: TextStyle(color: Colors.black54, fontSize: w * 0.035),
          border: InputBorder.none,
          suffixText: suffixText,
          suffixStyle: TextStyle(color: Colors.black54, fontSize: w * 0.035),
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: w * 0.035 > 20 ? 20 : w * 0.035,
        ),
      ),
    );
  }
}
