import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_up/bottomBarPages/home.dart';
import '../bottomBarPages/history.dart';
import '../bottomBarPages/profile.dart';
import '../bottomBarPages/search.dart';
import '../res/getController.dart';

class SamplePage extends StatelessWidget {
  SamplePage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    _getController.enters.value = 0;
    _getController.changeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(h * 0.1),
        child: Container(
          margin: EdgeInsets.only(top: h * 0.03, bottom: h * 0.01),
          child: Row(
            children: [
              SizedBox(width: w * 0.04,),
              Image(image: const AssetImage('assets/images/text.png'), width: w * 0.2, height: h * 0.05,),
            ],
          ),
        )
      ),
      body: Column(
        children: [
          Obx(() => _widgetOptions.elementAt(_getController.index.value)),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          selectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image(image: AssetImage('assets/images/home_icon.png'), width: 25, height: 25,),
              label: 'Home',
              activeIcon: Image(image: AssetImage('assets/images/home_icon.png'), width: 25, height: 25,
                color: Colors.blue,),
            ),
            BottomNavigationBarItem(
              icon: Image(image: AssetImage('assets/images/search_icon.png'), width: 25, height: 25,),
              label: 'Search',
              activeIcon: Image(image: AssetImage('assets/images/search_icon.png'), width: 25, height: 25,
                color: Colors.blue,),
            ),
            BottomNavigationBarItem(
              icon: Image(image: AssetImage('assets/images/histoy_icon.png'), width: 25, height: 25,),
              label: 'History',
              activeIcon: Image(image: AssetImage('assets/images/histoy_icon.png'), width: 25, height: 25,
                color: Colors.blue,),
            ),
            BottomNavigationBarItem(
              icon: Image(image: AssetImage('assets/images/user_icon.png'), width: 25, height: 25,),
              label: 'Profile',
              activeIcon: Image(image: AssetImage('assets/images/user_icon.png'), width: 25, height: 25,
                color: Colors.blue,),
            ),
          ],
          currentIndex: _getController.index.value,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}