import 'package:flutter/material.dart';
import 'home/homepage.dart';
import 'mine/mine.dart';
import '../gen_a/A.dart';

class IndexPage extends StatefulWidget {

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(
    icon: Image.asset(A.tabbar_home, width: 32,),
    activeIcon: Image.asset(A.tabbar_home_highlighted, width: 32,),
    label: "首页",
  ),
  BottomNavigationBarItem(
    icon: Image.asset(A.tabbar_profile, width: 32, gaplessPlayback: true,),
    activeIcon: Image.asset(A.tabbar_profile_highlighted, width: 32, gaplessPlayback: true),
    label: "我的",
  ),
];

List<Widget> pages = [
  HomePage(),
  MinePage()
];
