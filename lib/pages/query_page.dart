import 'package:flutter/material.dart';
import 'package:netflix_clone_app/models/loading.dart';
import 'package:netflix_clone_app/pages/search_page.dart';
import 'package:netflix_clone_app/services/database.dart';
import 'package:video_player/video_player.dart';

class QueryPage extends StatefulWidget {
  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  String queryResult;
  List resultList = [];
  bool isLoading = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    queryResult = "";
  }

  runQuery(String query) async {
    setState(() {
      isLoading = true;
    });
    var callback;
    try {
      callback = DatabaseHelper.instance.runQuery(query);
      await callback.then((value) {
        resultList = value.toList();
        if (resultList.isNotEmpty) {
          setState(() {
            queryResult = resultList.toString();
            isLoading = false;
          });
        } else {
          setState(() {
            queryResult = " NO RESULT ";
            isLoading = false;
          });
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        queryResult = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              children: [
                                Text("Query Page",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: width / 1.5),
                                Image.asset("assets/Netflix-avatar.png",
                                    width: 25, fit: BoxFit.cover)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: controller,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ),
                  ),
                  RaisedButton(
                      child: Text("Run The Query"),
                      onPressed: () {
                        runQuery(controller.text);
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "QUERY OUTPUT",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                            child: Text(queryResult,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
