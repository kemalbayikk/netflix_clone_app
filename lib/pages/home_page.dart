import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:netflix_clone_app/models/fetched_data.dart';
import 'package:netflix_clone_app/models/loading.dart';
import 'package:netflix_clone_app/pages/detail_page.dart';
import 'package:netflix_clone_app/pages/search_page.dart';
import 'package:netflix_clone_app/services/database.dart';

class HomePage extends StatefulWidget {
  final FetchedData fetchedData;
  final String user_uid;
  final String user_email;

  HomePage(this.fetchedData, this.user_uid, this.user_email);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List movies = [];
  List series = [];
  List allContent = [];
  List myListMovies = [];
  List myListSeries = [];
  List allList = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    movies = widget.fetchedData.movies;
    series = widget.fetchedData.series;
    allContent = new List.from(movies)..addAll(series);
    print("moviees");
    print(movies);
     print("seriees");
    print(series);
    print("ALL CONTENT ${allContent[5]}");
    fetchList();
    allList = new List.from(myListMovies)..addAll(myListSeries);
    print("ALL LİST $allList");

    print("user id ====> ${widget.user_uid}");
  }

  fetchList() async {

    setState(() {
        isLoading = true;
      });
    
    var callback = DatabaseHelper.instance.getMoviesList(widget.user_uid);
    await callback.then((value) {
      //print(value);
      myListMovies = value.toList();
      print("LİSTED MOVİES -------------");
      //print(myListMovies[0]["movie_name"]);

    });

    callback = DatabaseHelper.instance.getSeriesList(widget.user_uid);
    await callback.then((value) {
      //print(value);
      myListSeries = value.toList();
      print("LİSTED SERİES -------------");
      //print(myListSeries[0]["serie_uid"]);

      allList = new List.from(myListMovies)..addAll(myListSeries);
    });

    setState(() {
        isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return isLoading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: height - 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 500,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      movies[0]["poster_url"].toString()),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          height: 500,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("Play button");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 10, top: 4, bottom: 4),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Play",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "My List",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                         SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                                children:
                                    List.generate(allList.length, (index) {
                              return GestureDetector(
                                onTap: () => {
                                  print(allList[index]["movie_name"]
                                      .toString()),
                                  print(allList[index]["serie_name"]
                                      .toString()),
                                  // ignore: unrelated_type_equality_checks
                                  if (allList[index]["serie_name"] != null)
                                    {
                                      print("index ${allList[index]["serie_name"].toString()}"),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoDetailPage(
                                                  videoUrl: allList[index]
                                                          ["trailer_url"]
                                                      .toString(),
                                                  uid: allList[index]
                                                          ["serie_uid"]
                                                      .toString(),
                                                  movieOrSerie: "Serie",
                                                  about: allList[index]
                                                          ["about_serie"]
                                                      .toString(),
                                                  director: allList[index]
                                                          ["director"]
                                                      .toString(),
                                                  name: allList[index]
                                                          ["serie_name"]
                                                      .toString(),
                                                  user_uid: widget.user_uid,
                                                  fetchedData: widget.fetchedData,
                                                  user_email:widget.user_email
                                                )),
                                      )
                                    }
                                  else
                                    {
                                      print("movieee ----------"),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoDetailPage(
                                                  videoUrl: allList[index]
                                                          ["trailer_url"]
                                                      .toString(),
                                                  uid: allList[index]
                                                          ["movie_uid"]
                                                      .toString(),
                                                  movieOrSerie: "Movie",
                                                  about: allList[index]
                                                          ["about_movie"]
                                                      .toString(),
                                                  director: allList[index]
                                                          ["director"]
                                                      .toString(),
                                                  name: allList[index]
                                                          ["movie_name"]
                                                      .toString(),
                                                  user_uid: widget.user_uid,
                                                  fetchedData: widget.fetchedData,
                                                  user_email:widget.user_email
                                                )),
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
                                          image: NetworkImage(allList[index]
                                                  ["poster_url"]
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                              );
                            })),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Popular On Netflix",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                                children:
                                    List.generate(allContent.length, (index) {
                              return GestureDetector(
                                onTap: () => {
                                  print(allContent[index]["movie_name"]
                                      .toString()),
                                  print(allContent[index]["serie_name"]
                                      .toString()),
                                  // ignore: unrelated_type_equality_checks
                                  if (index >= 4)
                                    {
                                      print("serie"),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoDetailPage(
                                                  videoUrl: allContent[index]
                                                          ["trailer_url"]
                                                      .toString(),
                                                  uid: allContent[index]
                                                          ["serie_uid"]
                                                      .toString(),
                                                  movieOrSerie: "Serie",
                                                  about: allContent[index]
                                                          ["about_serie"]
                                                      .toString(),
                                                  director: allContent[index]
                                                          ["director"]
                                                      .toString(),
                                                  name: allContent[index]
                                                          ["serie_name"]
                                                      .toString(),
                                                  user_uid: widget.user_uid,
                                                  fetchedData: widget.fetchedData,
                                                  user_email:widget.user_email
                                                )),
                                      )
                                    }
                                  else
                                    {
                                      print("movieee ----------"),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoDetailPage(
                                                  videoUrl: allContent[index]
                                                          ["trailer_url"]
                                                      .toString(),
                                                  uid: allContent[index]
                                                          ["movie_uid"]
                                                      .toString(),
                                                  movieOrSerie: "Movie",
                                                  about: allContent[index]
                                                          ["about_movie"]
                                                      .toString(),
                                                  director: allContent[index]
                                                          ["director"]
                                                      .toString(),
                                                  name: allContent[index]
                                                          ["movie_name"]
                                                      .toString(),
                                                  user_uid: widget.user_uid,
                                                  fetchedData: widget.fetchedData,
                                                  user_email:widget.user_email
                                                )),
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
                                          image: NetworkImage(allContent[index]
                                                  ["poster_url"]
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                              );
                            })),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Trending Now",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                                children: List.generate(4, (index) {
                              return GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  width: 110,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://m.media-amazon.com/images/M/MV5BNjg1MDQ5MjQ2N15BMl5BanBnXkFtZTYwNjI5NjA3._V1_.jpgmedia-amazon.com/images/M/MV5BMDNkOTE4NDQtMTNmYi00MWE0LWE4ZTktYTc0NzhhNWIzNzJiXkEyXkFqcGdeQXVyMzQ2MDI5NjU@._V1_.jpg"),
                                          fit: BoxFit.cover)),
                                ),
                              );
                            })
                                /*Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 110,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://m.media-amazon.com/images/M/MV5BMDNkOTE4NDQtMTNmYi00MWE0LWE4ZTktYTc0NzhhNWIzNzJiXkEyXkFqcGdeQXVyMzQ2MDI5NjU@._V1_.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 110,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://m.media-amazon.com/images/M/MV5BNjg1MDQ5MjQ2N15BMl5BanBnXkFtZTYwNjI5NjA3._V1_.jpgmedia-amazon.com/images/M/MV5BMDNkOTE4NDQtMTNmYi00MWE0LWE4ZTktYTc0NzhhNWIzNzJiXkEyXkFqcGdeQXVyMzQ2MDI5NjU@._V1_.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 110,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://m.media-amazon.com/images/M/MV5BNzVkYWY4NzYtMWFlZi00YzkwLThhZDItZjcxYTU4ZTMzMDZmXkEyXkFqcGdeQXVyODUxOTU0OTg@._V1_.jpg"),
                                        fit: BoxFit.cover)),
                              ),*/
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Netflix Originals",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                                children: List.generate(4, (index) {
                              return GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  width: 165,
                                  height: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://m.media-amazon.com/images/M/MV5BODM3NTZkZTUtYzEyYS00NjEyLTg2NjEtNDhlMjYwY2ZkNGUzXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg"),
                                          fit: BoxFit.cover)),
                                ),
                              );
                            })
                                /* Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 165,
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://m.media-amazon.com/images/M/MV5BODM3NTZkZTUtYzEyYS00NjEyLTg2NjEtNDhlMjYwY2ZkNGUzXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 165,
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://m.media-amazon.com/images/M/MV5BODM1MDU2NjY5NF5BMl5BanBnXkFtZTgwMDkxNTcwNjM@._V1_.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 165,
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://m.media-amazon.com/images/M/MV5BZjdjOWIxMDgtYTgwNS00MjE4LTliZWYtZGI1NDhhZmIyYjM1XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg"),
                                        fit: BoxFit.cover)),
                              ),*/
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Dramas",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                                children: List.generate(4, (index) {
                              return GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  width: 110,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://m.media-amazon.com/images/M/MV5BODM3NTZkZTUtYzEyYS00NjEyLTg2NjEtNDhlMjYwY2ZkNGUzXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg"),
                                          fit: BoxFit.cover)),
                                ),
                              );
                            })
                                /*Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 110,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://m.media-amazon.com/images/M/MV5BODM3NTZkZTUtYzEyYS00NjEyLTg2NjEtNDhlMjYwY2ZkNGUzXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 110,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://m.media-amazon.com/images/M/MV5BODM1MDU2NjY5NF5BMl5BanBnXkFtZTgwMDkxNTcwNjM@._V1_.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 110,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://m.media-amazon.com/images/M/MV5BZjdjOWIxMDgtYTgwNS00MjE4LTliZWYtZGI1NDhhZmIyYjM1XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg"),
                                        fit: BoxFit.cover)),
                              ),*/
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          children: [
                            Image.asset("assets/logo.ico",
                                width: 35, fit: BoxFit.cover),
                            SizedBox(width: width / 1.5),
                            IconButton(
                              icon: Icon(Icons.search, color: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchPage(user_uid: widget.user_uid, fetchedData: widget.fetchedData, user_email:widget.user_email)),
                                );
                              },
                            ),
                            Image.asset("assets/Netflix-avatar.png",
                                width: 25, fit: BoxFit.cover)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                child: Text(
                              "TV Shows",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                            GestureDetector(
                                child: Text(
                              "Movies",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                            GestureDetector(
                                child: Text(
                              "My List",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
