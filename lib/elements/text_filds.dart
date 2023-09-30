import 'package:flutter/material.dart';

class TextFildWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const TextFildWidget({super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.06,
      width: w * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.grey[200],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: const TextStyle(color: Colors.black54),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
        ),
      ),
    );
  }
}

