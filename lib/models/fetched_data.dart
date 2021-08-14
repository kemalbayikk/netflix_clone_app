import 'package:netflix_clone_app/services/database.dart';

class FetchedData {
  List movies = [];
  List series = [];

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

    callback = DatabaseHelper.instance.getAllMovies();
    await callback.then((value) {
      //print(value);
      movies = value.toList();
      print(movies[0]["poster_url"]);
    });

  }
}
