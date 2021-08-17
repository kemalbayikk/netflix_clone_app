import 'package:flutter/material.dart';
import 'package:netflix_clone_app/models/fetched_data.dart';
import 'package:netflix_clone_app/models/loading.dart';
import 'package:netflix_clone_app/pages/detail_page.dart';
import 'package:netflix_clone_app/pages/home_page.dart';
import 'package:netflix_clone_app/pages/page_wrapper.dart';
import 'package:netflix_clone_app/services/database.dart';

class SearchPage extends StatefulWidget {
  final String user_uid;
  final FetchedData fetchedData;
  final String user_email;

  const SearchPage({Key key, this.user_uid, this.fetchedData, this.user_email})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List movies = [];
  List series = [];
  List allList = [];
  bool isLoading = false;
  TextEditingController controller = TextEditingController();

  searchAll(String prefix) async {
    allList = [];

    var callback = DatabaseHelper.instance.searchSerie(prefix);
    await callback.then((value) {
      series = value.toList();
    });

    callback = DatabaseHelper.instance.searchMovie(prefix);
    await callback.then((value) {
      movies = value.toList();

      allList = new List.from(movies)..addAll(series);
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: appBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top Searches", //Databasedeki tüm dizi ve filmleri koy
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Column(
                        children: List.generate(allList.length, (index) {
                      return GestureDetector(
                        onTap: () => {
                          // ignore: unrelated_type_equality_checks
                          if (allList[index]["serie_name"] != null)
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoDetailPage(
                                        videoUrl: allList[index]["trailer_url"]
                                            .toString(),
                                        uid: allList[index]["serie_uid"]
                                            .toString(),
                                        movieOrSerie: "Serie",
                                        about: allList[index]["about_serie"]
                                            .toString(),
                                        director: allList[index]["director"]
                                            .toString(),
                                        name: allList[index]["serie_name"]
                                            .toString(),
                                        user_uid: widget.user_uid,
                                        fetchedData: widget.fetchedData,
                                        user_email: widget.user_email)),
                              )
                            }
                          else
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoDetailPage(
                                        videoUrl: allList[index]["trailer_url"]
                                            .toString(),
                                        uid: allList[index]["movie_uid"]
                                            .toString(),
                                        movieOrSerie: "Movie",
                                        about: allList[index]["about_movie"]
                                            .toString(),
                                        director: allList[index]["director"]
                                            .toString(),
                                        name: allList[index]["movie_name"]
                                            .toString(),
                                        user_uid: widget.user_uid,
                                        fetchedData: widget.fetchedData,
                                        user_email: widget.user_email)),
                              )
                            }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 8),
                          width: 110,
                          height: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      allList[index]["poster_url"].toString()),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    })),
                  ],
                ),
              ),
            ));
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PageWrapper(widget.user_email)));
          },
          child: Icon(Icons.arrow_back_ios)),
      title: Container(
        height: 35,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Container(
                width: 270,
                child: TextField(
                  controller: controller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search some movies and series",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isLoading = true;
                });

                searchAll(controller.text);
              },
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
