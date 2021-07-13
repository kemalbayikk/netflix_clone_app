import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              SizedBox(width: 15,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("Friends"
                                ,style: TextStyle(color: Colors.white, fontSize: 15),),
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
                                border: Border.all(width: 2, color: Colors.white)),
                                child: Center(
                                  child: Icon(Icons.play_arrow, color: Colors.white)
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Divider(color: Colors.black, height: 5,),
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
                              SizedBox(width: 15,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("Designated Survivor"
                                ,style: TextStyle(color: Colors.white, fontSize: 15),),
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
                                border: Border.all(width: 2, color: Colors.white)),
                                child: Center(
                                  child: Icon(Icons.play_arrow, color: Colors.white)
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Divider(color: Colors.black, height: 5,),
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
                              SizedBox(width: 15,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("Queens Gambit"
                                ,style: TextStyle(color: Colors.white, fontSize: 15),),
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
                                border: Border.all(width: 2, color: Colors.white)),
                                child: Center(
                                  child: Icon(Icons.play_arrow, color: Colors.white)
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Divider(color: Colors.black, height: 5,),
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
                              SizedBox(width: 15,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("Stajyer"
                                ,style: TextStyle(color: Colors.white, fontSize: 15),),
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
                                border: Border.all(width: 2, color: Colors.white)),
                                child: Center(
                                  child: Icon(Icons.play_arrow, color: Colors.white)
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Divider(color: Colors.black, height: 5,),
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
                              SizedBox(width: 15,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("Lupin"
                                ,style: TextStyle(color: Colors.white, fontSize: 15),),
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
                                border: Border.all(width: 2, color: Colors.white)),
                                child: Center(
                                  child: Icon(Icons.play_arrow, color: Colors.white)
                                ),
                              ),
                            ),
                          ),
                        
                      ],
                    ),
                    
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Container(
        height: 35,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(5)),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search some movies and series",
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white.withOpacity(0.5),
              )),
        ),
      ),
    );
  }
}
