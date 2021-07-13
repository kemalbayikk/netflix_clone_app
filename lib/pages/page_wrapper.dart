import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:netflix_clone_app/pages/coming_soon_page.dart';
import 'package:netflix_clone_app/pages/home_page.dart';

class PageWrapper extends StatefulWidget {
  @override
  _PageWrapperState createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: bottomNavBar(),
      body: IndexedStack(
        index: activeTab,
        children: [
          HomePage(),
          ComingSoonPage(),
          Center(
            child: Text("DOWNLOADS", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  activeTab = 0;
                });
              },
              child: Column(
                children: [
                  Icon(AntDesign.home, color: Colors.white),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  activeTab = 1;
                });
              },
              child: Column(
                children: [
                  Icon(AntDesign.playcircleo, color: Colors.white),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Coming Soon",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  activeTab = 2;
                });
              },
              child: Column(
                children: [
                  Icon(AntDesign.download, color: Colors.white),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Downloads",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
