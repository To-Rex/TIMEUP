import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            const Image(image: AssetImage('assets/images/logo.png')),
            SizedBox(height: h * 0.01),
            Image(image: const AssetImage('assets/images/text.png'), height: h * 0.05),
            Expanded(child: Container()),
            const Text('Vaqtingizni tejang!'),
            SizedBox(height: h * 0.06),
          ],
        ),
      ),
    );
  }
}