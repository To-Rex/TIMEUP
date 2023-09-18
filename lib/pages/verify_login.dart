import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class LoginVerifyPage extends StatelessWidget {
  const LoginVerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/images/logo.png')),
          SizedBox(height: h * 0.01),
          Image(
              image: const AssetImage('assets/images/text.png'),
              height: h * 0.05),
          SizedBox(height: h * 0.06),

          VerificationCode(
            textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
            underlineColor: Colors.red[900],
            keyboardType: TextInputType.number,
            length: 4,
            onCompleted: (String value) {
              print(value);
            },
            onEditing: (bool value) {
              print(value);
            },
          ),

        ],
      ),
    ));
  }
}
