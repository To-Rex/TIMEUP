import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class BottomEditButton extends StatelessWidget {
  String text;
  var icon;
  late Color color;
  Function()? onPressed;
  BottomEditButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      width: w * 0.9,
      height: h * 0.06,
      margin: EdgeInsets.only(top: h * 0.02),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue.shade600,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeroIcon(
              icon,
              size: w * 0.055,
              color: color,
            ),
            SizedBox(width: w * 0.04),
            SizedBox(
              width: w * 0.6,
              child: Text(
                maxLines: 1,
                text,
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              width: w * 0.06,
              height: h * 0.03,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: w * 0.04,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
