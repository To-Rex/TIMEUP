import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:time_up/pages/verify_login.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //phone number controller
  final TextEditingController _controller = TextEditingController();
  var code = '+998';

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
          Container(
            width: w * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.grey[300],
            ),
            child: IntlPhoneField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              flagsButtonPadding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const InputDecoration(
                hintText: 'Telefon raqam',
                hintStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  borderSide: BorderSide.none,
                ),
                counterText: '',
                counter: null,
                //counter false
                semanticCounterText: null,
                //counter false
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                error: null,
                errorText: null,
                isDense: true,
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
              ),
              showCountryFlag: false,
              showCursor: false,
              showDropdownIcon: false,
              initialCountryCode: 'UZ',
              onCountryChanged: (phone) {
                print('Country code changed to: ' + phone.fullCountryCode);
                code = phone.fullCountryCode;
              },
            ),
          ),
          SizedBox(height: h * 0.02),
          Text('Royhatdan o`tish uchun raqamingizni yozing!',
              style: TextStyle(fontSize: w * 0.04 > 20 ? 20 : w * 0.04),
              textAlign: TextAlign.center),
          SizedBox(height: h * 0.02),
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
                print(code + _controller.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginVerifyPage()),
                );
              },
              child: Text(
                'Yuborish',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.04 > 20 ? 20 : w * 0.04,
                  //bold
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
