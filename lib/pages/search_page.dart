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
    print(" search user uid ====> ${widget.user_uid}");
    var callback = DatabaseHelper.instance.searchSerie(prefix);
    await callback.then((value) {
      //print(value);
      series = value.toList();
      //print(series[0]["serie_name"]);
    });

    callback = DatabaseHelper.instance.searchMovie(prefix);
    await callback.then((value) {
      //print(value);
      movies = value.toList();
      //print(movies[0]["movie_name"]);
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
                          print(allList[index]["movie_name"].toString()),
                          print(allList[index]["serie_name"].toString()),
                          // ignore: unrelated_type_equality_checks
                          if (allList[index]["serie_name"] != null)
                            {
                              print("serie"),
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
                              print("movieee ----------"),
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
                                        user_email: widget.user_email
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
                                  image: NetworkImage(
                                      allList[index]["poster_url"].toString()),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    })),
                    /*Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://occ-0-3466-778.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABRkvz8B2_8xI63wOWDZ4nSqONl6jdrTARKvwHDGk7UX7K6HfdGVOsMrtAi_14omqTow7uYiifwTv7QDk_MUDd-JQzkA.webp?r=452"),
                                            fit: BoxFit.fill)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  "Friends",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                              child: Center(
                                  child: Icon(Icons.play_arrow,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://occ-0-3466-778.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABd_EQmxmSHXah7AoF6dY4eaQPwfAEzgSSKeSKX0rTqPsgQfbV_uUXEm8ynPp6C3NX9mIz8R22DYDU4TfcvIPpxO0bzXmTQXQ058M-UZc9H_574o815hgaTIXIyXc.jpg?r=a5e"),
                                            fit: BoxFit.fill)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  "Designated Survivor",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                              child: Center(
                                  child: Icon(Icons.play_arrow,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://occ-0-3466-778.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABWR1ANgH8wtkL9pgCklNdAXcNwOzA18jzu3CuKGLJlUu6AzxYUDBDXrpVeez_SpnTvdR8X8SocvoizM3fUw1xjU9yjMfFYMlhOOd2R7UHfcxvgaEw9h4LFWdTZKA.jpg?r=069"),
                                            fit: BoxFit.fill)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  "Queens Gambit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                              child: Center(
                                  child: Icon(Icons.play_arrow,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://occ-0-3466-778.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABRguhQJELyKecdIId26MED1-I71KSsnFHUIm5MdKBfCRnCGFDV5SqKNUc8wRTwFA2_cFGDgMYoEyL4Z7_cJwb3NKqlM.webp?r=f0a"),
                                            fit: BoxFit.fill)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  "Stajyer",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                              child: Center(
                                  child: Icon(Icons.play_arrow,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://occ-0-3466-778.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABeCN5fz5_9XkE90XtUk2tSW8ibDa_zcCw_8rsli0cXs6beVa5cTqRkdzF8r0gEeD1O00bHpZcvTJBccpPFcrsCsUzLIcU8BcDcPiUdoywjz4L-NIZ0ty6pYTcppvyUCds3fFMdEwx3v0hDCeFDD-vrSdagaBy_eCPW9jwD94FGqQTS0iX0rIPZV7_uU1ThKmqPR6rJYxcqXcvkI5y5fOzbb-.jpg?r=c53"),
                                            fit: BoxFit.fill)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  "Lupin",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                              child: Center(
                                  child: Icon(Icons.play_arrow,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )*/
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
                    builder: (context) =>
                        PageWrapper(widget.user_email)));
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
                print(controller.text);
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
