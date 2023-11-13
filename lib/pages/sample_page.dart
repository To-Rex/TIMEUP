import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:time_up/bottomBarPages/home.dart';
import '../bottomBarPages/history.dart';
import '../bottomBarPages/profile.dart';
import '../bottomBarPages/search.dart';
import '../res/getController.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});

  final GetController _getController = Get.put(GetController());

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    //AddPostPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    _getController.changeWidgetOptions();
    _getController.enters.value = 0;
    _getController.entersUser.value = 0;
    _getController.clearCategory();
    _getController.clearSubCategory();
    _getController.changeIndex(index);
    _getController.nextPagesUserDetails.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(h * 0.066),
          child: Obx(() => _getController.index.value != 5
              ? Container(
                  height: h * 0.06,
                  margin: EdgeInsets.only(top: h * 0.045),
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.04),
                      Image(
                        image: const AssetImage('assets/images/text.png'),
                        width: w * 0.2,
                        height: h * 0.05,
                      ),
                    ],
                  ),
                )
              : Container(height: h * 0.03))),
      body: SingleChildScrollView(
        //child: Obx(() => _widgetOptions.elementAt(_getController.index.value)),
        child: Obx(() => _getController.widgetOptions.elementAt(_getController.index.value)),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          selectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: HeroIcon(
                HeroIcons.home,
                size: w * 0.07,
              ),
              label: 'Home',
              activeIcon: HeroIcon(
                HeroIcons.home,
                size: w * 0.07,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              icon: HeroIcon(
                HeroIcons.magnifyingGlass,
                size: w * 0.07,
              ),
              label: 'Search',
              activeIcon: HeroIcon(
                HeroIcons.magnifyingGlass,
                size: w * 0.07,
                color: Colors.blue,
              ),
            ),
            if (_getController.meUsers.value.res?.business != null)
              BottomNavigationBarItem(
                icon: HeroIcon(
                  HeroIcons.plusCircle,
                  size: w * 0.07,
                ),
                label: 'add',
                activeIcon: HeroIcon(
                  HeroIcons.plusCircle,
                  size: w * 0.07,
                  color: Colors.blue,
                ),
              ),
            BottomNavigationBarItem(
              icon: HeroIcon(
                HeroIcons.bell,
                size: w * 0.07,
              ),
              label: 'History',
              //notification icon
              activeIcon: HeroIcon(
                HeroIcons.bell,
                size: w * 0.07,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              icon: HeroIcon(
                HeroIcons.userCircle,
                size: w * 0.07,
              ),
              label: 'Profile',
              activeIcon: HeroIcon(
                HeroIcons.userCircle,
                size: w * 0.07,
                color: Colors.blue,
              ),
            ),
          ],
          currentIndex: _getController.index.value,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
