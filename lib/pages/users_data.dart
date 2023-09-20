
import 'package:flutter/material.dart';

class LoginUserData extends StatelessWidget {
  const LoginUserData({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('LoginUserData'),
          ],
        ),
      ),
    );
  }
}