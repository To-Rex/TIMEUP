import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class LoginVerifyPage extends StatelessWidget {
  LoginVerifyPage({super.key});

  final int _otpLength = 6; // Adjust this based on your OTP length
  String _otp = '';
  int _secondsRemaining =
      120; // Set the countdown time to 2 minutes (120 seconds)
  CountdownController _controller = CountdownController();

  void startCountdown() {
    _controller.restart();
  }

  String formatDuration(Duration duration) {
    return '${(duration.inSeconds ~/ 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

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
          SizedBox(height: h * 0.02),
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
          SizedBox(height: h * 0.02),
          //1min 59sec count down
          Countdown(
            controller: _controller,
            seconds: _secondsRemaining,
            build: (_, double time) {
              final formattedTime =
                  formatDuration(Duration(seconds: time.toInt()));
              return Text(
                'Kodni qayta yuborish uchun kuting: $formattedTime',
                style: TextStyle(fontSize: 16),
              );
            },
            interval: Duration(seconds: 1),
            onFinished: () {
              // Handle the timer finish event here
            },
          ),
          SizedBox(height: h * 0.02),
          /*TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            onPressed: () {
              // Resend OTP button pressed
              startCountdown();
            },
            child: Text('Kod yet kelmadimi?'),
          ),*/

          SizedBox(height: h * 0.04),
          SizedBox(
            height: h * 0.06,
            width: w * 0.9,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginVerifyPage()),
                );
              },
              child: Text(
                'Tasdiqlash',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
