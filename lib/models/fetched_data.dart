import 'package:netflix_clone_app/services/database.dart';

class FetchedData {
  List movies = [];
  List series = [];
  List user_uid = [];


  fetchAll() async {
    var callback = DatabaseHelper.instance.getAllSeries();
    await callback.then((value) {
      series = value.toList();
    });

    callback = DatabaseHelper.instance.getAllMovies();
    await callback.then((value) {
      movies = value.toList();
    });

  }

  getUid(String email_adress) async {
    var callback = DatabaseHelper.instance.getUidFromEmail(email_adress);
    await callback.then((value) {
      user_uid = value.toList();
    });

    return user_uid[0]["user_uid"].toString();
  }

}
