
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          height: h * 0.5,
          width: w * 0.5,
          child: SvgPicture.asset('assets/svgs/logo.svg'),
        ),
      ),
    );
  }
}