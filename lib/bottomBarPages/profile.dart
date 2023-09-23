import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w,
      child: Column(
        children: [
          SizedBox(
            height: h * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: w * 0.05,
              ),
              CircleAvatar(
                radius: w * 0.12,
                foregroundColor: Colors.blue,
                backgroundImage: const AssetImage(
                  'assets/images/doctor.png',
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          Container(
            width: w * 0.9,
            margin: const EdgeInsets.only(top: 15),
            child: const Text('Sobit Boymirzayev',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            width: w * 0.9,
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                const Text('Urolog',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    )),
                SizedBox(
                  width: w * 0.02,
                ),
                const Text(
                  '8 yillik ish tajribasi',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: w * 0.9,
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  size: 15,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: w * 0.02,
                ),
                const Text(
                  '+998 99 999 99 99',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: w * 0.9,
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                //location
                const Icon(
                  Icons.location_on,
                  size: 15,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: w * 0.02,
                ),
                const Text(
                  'Кибрайский район Qibray tumaniУзбекистан',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: w * 0.9,
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                //location
                const Icon(
                  Icons.work,
                  size: 15,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: w * 0.02,
                ),
                const Text(
                  'Toshkent shahar 5 bolalar shifoxonasi',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: w * 0.9,
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                //location
                const Icon(
                  Icons.access_time_outlined,
                  size: 15,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: w * 0.02,
                ),
                const Text(
                  'Shanba, Yakshanba',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: w * 0.9,
            height: h * 0.045,
            padding: EdgeInsets.only(
              left: w * 0.05,
            ),
            margin: EdgeInsets.only(right: w * 0.6, top: h * 0.02),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: const Text('Edit profile',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )),
            ),
          ),
          Container(
            width: w,
            margin: EdgeInsets.only(top: h * 0.05),
            color: Colors.grey[200],
            //Biografiya and Ish jadvali TabBar
            child: Row(
              children: [
                Container(
                  width: w * 0.5,
                  color: Colors.blue,
                  child: TextButton(
                    onPressed: () {

                    },
                    child: const Text(
                      'Biografiya',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: w * 0.5,
                  child: TextButton(
                    onPressed: () {

                    },
                    child: const Text(
                      'Ish jadvali',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          Container(
            width: w,
            height: h * 0.25,
            padding: EdgeInsets.only(
              left: w * 0.02,
              right: w * 0.02,
            ),
            margin: EdgeInsets.only(top: h * 0.02, left: w * 0.02, right: w * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: const Text(
              textAlign: TextAlign.start,
              'САЛОМ МЕН ДОКТОР ИСЧАНОВ НОДИРБЕК ИСЧАНOВИЧ, МИЛЛАТИМ ЎЗБЕК, ЎЗБЕКИСТОН ФУҚАРОСИМАН, МАЪЛУМОТИМ ОЛИЙ, ТИББИЙ МУТАХАССИСЛИКЛАРИМ 10 ГА ЯҚИН. ОИЛАЛИМАН, ШИФОКОРЛАР ОИЛАСИДА ТУҒИЛГАНМАН.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
