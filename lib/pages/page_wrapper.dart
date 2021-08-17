import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:netflix_clone_app/models/fetched_data.dart';
import 'package:netflix_clone_app/models/loading.dart';
import 'package:netflix_clone_app/pages/query_page.dart';
import 'package:netflix_clone_app/pages/home_page.dart';

class PageWrapper extends StatefulWidget {
  final String user_email;

  PageWrapper(this.user_email);

  @override
  _PageWrapperState createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  int activeTab = 0;
  bool isLoading = false;
  String user_uid;
  FetchedData fetchedData = FetchedData();

  waitDataToFetch() async {
    setState(() {
      isLoading = true;
    });

    await fetchedData.fetchAll();
    user_uid = await fetchedData.getUid(widget.user_email);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitDataToFetch();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: bottomNavBar(),
            body: IndexedStack(
              index: activeTab,
              children: [
                HomePage(fetchedData, user_uid, widget.user_email),
                QueryPage(),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    "Query Page",
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
