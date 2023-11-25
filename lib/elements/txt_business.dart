import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

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
    return Container(
      width: w ,
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: w * 0.03,
            child: Image(
              image: AssetImage(icon),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: w * 0.02),
          SizedBox(
            width: w * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReadMoreText(
                  text,
                  trimLines: 1,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' more',
                  trimExpandedText: ' less',
                  moreStyle: TextStyle(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                  ),
                  style: TextStyle(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
