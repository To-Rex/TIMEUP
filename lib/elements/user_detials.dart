import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class UserDetIalWidget extends StatelessWidget {
  final String labelText;
  final String labelTextCount;

  const UserDetIalWidget({
    super.key,
    required this.labelText,
    required this.labelTextCount,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w * 0.3,
      child: Column(
        children: [
          Text(
            labelText,
            style: TextStyle(
              color: Colors.black,
              fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
            ),
          ),
          Text(
            labelTextCount,
            style: TextStyle(
              color: Colors.black,
              fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
            ),
          ),
        ],
      ),
    );
  }
}
