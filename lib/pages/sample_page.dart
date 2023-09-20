import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../res/getController.dart';

class SamplePage extends StatelessWidget {
  SamplePage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Search',
    ),
    Text(
      'Index 2: History',
    ),
    Text(
      'Index 3: Profile',
    ),

  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    _getController.changeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        width: w,
        child: Column(
          children: [
            Obx(() => _widgetOptions.elementAt(_getController.index.value)),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          selectedLabelStyle: const TextStyle(color: Colors.black),
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: w * 0.03,
          unselectedFontSize: w * 0.03,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _getController.index.value,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),

    );
  }
}
