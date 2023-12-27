import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class UserDetIalWidget extends StatelessWidget {
  final String labelText;
  final String labelTextCount;
  final int icon;

  const UserDetIalWidget({
    super.key,
    required this.labelText,
    required this.labelTextCount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w * 0.3,
      child: Column(
        children: [
          if (icon == 1)
            //post
            HeroIcon(
              HeroIcons.film,
              size: w * 0.08 > 50 ? 50 : w * 0.08,
              color: Colors.blue,
            ),
          if (icon == 2)
            HeroIcon(
              HeroIcons.users,
              size: w * 0.08 > 50 ? 50 : w * 0.08,
              color: Colors.blue,
            ),
          if (icon == 3)
            HeroIcon(
              HeroIcons.link,
              size: w * 0.08 > 50 ? 50 : w * 0.08,
              color: Colors.blue,
            ),
          Text(labelText,
            style: TextStyle(
              color: Colors.black,
              fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
            ),
          ),
          Text(labelTextCount,
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
