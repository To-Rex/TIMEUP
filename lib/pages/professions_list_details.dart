import 'package:flutter/material.dart';

class ProfessionsListDetails extends StatelessWidget {
  const ProfessionsListDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(h * 0.1),
          child: Container(
            margin: EdgeInsets.only(top: h * 0.03, bottom: h * 0.01),
            child: Row(
              children: [
                SizedBox(
                  width: w * 0.04,
                ),
                Image(
                  image: const AssetImage('assets/images/text.png'),
                  width: w * 0.2,
                  height: h * 0.05,
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //back button
              SizedBox(
                width: w * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Text(
                'Sobit_Doctor',
                style: TextStyle(
                  fontSize: w * 0.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                width: w * 0.04,
              ),
            ],
          ),
          SizedBox(
            height: h * 0.02,
          ),
          SizedBox(
            width: w,
            child: const Image(
              image: AssetImage('assets/images/doctor.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Container(
              margin: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Boymirzayev Sobit',
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Row(
                    children: [
                      Text(
                        'Urolog',
                        //text style bold
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w500,
                          //bold
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(
                        width: w * 0.02,
                      ),
                      //8 yillik ish tajribasi
                      Text(
                        '8 yillik ish tajribasi',
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_android,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: w * 0.02,
                      ),
                      Text(
                        '+998 99 999 99 99',
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: w * 0.02,
                      ),
                      Text(
                        'Кибрайский район Qibray tumaniУзбекистан',
                        style: TextStyle(
                          fontSize: w * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.work,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: w * 0.02,
                      ),
                      Text(
                        'Toshkent shahar 5 bolalar shifoxonasi',
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: w * 0.2,
                        height: h * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          'Bio',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                          height: h * 0.05,
                          padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Center(
                            child: Text(
                              'Ish jadvali',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      const Expanded(child: SizedBox()),
                      Container(
                          width: w * 0.2,
                          height: h * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Center(
                            child: Text(
                              'Booking',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      const Expanded(child: SizedBox()),
                      Container(
                        alignment: Alignment.center,
                        width: w * 0.1,
                        height: h * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02,bottom: h * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Izoh qoldirish',
                        hintStyle: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                        counterText: '0/100',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: w * 0.02),
                      ),
                    ),
                  )
                ],
              )),
        ],
      )),
    );
  }
}
