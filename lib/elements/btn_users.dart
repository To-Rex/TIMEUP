import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  String text;
  Function()? onPressed;
  EditButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      width: w * 0.9,
      height: h * 0.06,
      margin: const EdgeInsets.only(top: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
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
