import 'package:netflix_clone_app/services/database.dart';

class FetchedData {
  List movies = [];
  List series = [];
  List user_uid = [];


  fetchAll() async {
    var callback = DatabaseHelper.instance.getAllSeries();
    await callback.then((value) {
      //print(value);
      series = value.toList();
      print(series[0]["poster_url"]);
    });

    callback = DatabaseHelper.instance.getAllMovies();
    await callback.then((value) {
      //print(value);
      movies = value.toList();
      print(movies[0]["poster_url"]);
    });

  }

  getUid(String email_adress) async {
    var callback = DatabaseHelper.instance.getUidFromEmail(email_adress);
    await callback.then((value) {
      user_uid = value.toList();
      print(user_uid[0]["user_uid"]);
    });

    return user_uid[0]["user_uid"].toString();
  }

}
