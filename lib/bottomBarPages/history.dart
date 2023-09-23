import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../res/getController.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());
  //controller for date
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: w * 0.45,
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Eslatma',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  width: w * 0.005,
                  height: h * 0.03,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: w * 0.45,
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Sizning Mijozlaringiz',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            //data time textfild MM / DD / YYYY and icon
            SizedBox(
              width: w * 0.9,
              height: h * 0.07,
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  suffixIcon:  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025),
                      );
                    },
                    child: const Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'MM / DD / YYYY',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            //List 10 User icon and text
            SizedBox(
                height: h * 0.68,
                child: ListView(
                  children: [
                    for (var i = 0; i < 10; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //CircleAvatar User icon Image.asset('assets/images/doctor.png'),
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/images/doctor.png',
                            ),
                          ),
                          //User name and profession
                          SizedBox(
                            width: w * 0.6,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //User name
                                Text(
                                  'Doctor_sobit',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                //User profession
                                Text(
                                  'Sobit Boymirzayev',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '+998 99 999 99 99',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Sizning navbatingiz: 11/02/2023 15 : 00',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
