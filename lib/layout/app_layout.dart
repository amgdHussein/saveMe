import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//screens
import 'package:save_me/screen/chat.dart';
import 'package:save_me/screen/home.dart';
import 'package:save_me/screen/profile.dart';
import 'package:save_me/screen/search.dart';
import 'package:save_me/screen/camera.dart';
import 'package:save_me/styles/bar_icons.dart';
import 'package:save_me/styles/colors.dart';

class AppLayout extends StatefulWidget {
  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    CameraScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  int currentTab;
  List<IconData> icons;
  AppLayout({Key key}) : super(key: key) {
    this.currentTab = 0;
    this.icons = getIcons(selected: this.currentTab);
  }

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: widget.bucket,
      child: Scaffold(
        backgroundColor: mineShaft,
        body: widget.pages[widget.currentTab],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 35,
          selectedItemColor: bourbon,
          unselectedItemColor: bourbon,
          currentIndex: widget.currentTab,
          onTap: (curretIndex) {
            setState(() {
              widget.currentTab = curretIndex;
              widget.icons = getIcons(selected: widget.currentTab);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(widget.icons[0]),
              // ignore: deprecated_member_use
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(widget.icons[1]),
              // ignore: deprecated_member_use
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(widget.icons[2]),
              // ignore: deprecated_member_use
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(widget.icons[3]),
              // ignore: deprecated_member_use
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(widget.icons[4]),
              // ignore: deprecated_member_use
              title: SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
