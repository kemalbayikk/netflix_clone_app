import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  static MySqlConnection _connection;
  static bool isEmpty = false;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<MySqlConnection> get connection async {
    if (_connection != null) return _connection;

    _connection = await _initiateConnection();
    return _connection;
  }

  _initiateConnection() async {
    final settings = ConnectionSettings(
        host: 'bil372.crozn0rpwkqf.eu-central-1.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Netflix',
        password: 'kebohso1');
    return await MySqlConnection.connect(settings);
  }

  registerCheck(
      String email, String password, String name, String surname) async {
    _connection = await instance.connection;
    return _connection.query("SELECT * FROM Users WHERE email_adress='$email'");
  }

  insertToUsers(
      String email, String password, String name, String surname) async {
    _connection = await instance.connection;

    return _connection.query(
        """INSERT INTO Users (email_adress,password,name,surname) VALUES ('$email','$password','$name','$surname')""");
  }

  loginCheck(String email, String password) async {
    _connection = await instance.connection;
    return _connection.query(
        """SELECT * FROM Users WHERE email_adress='$email' AND password='$password'""");
  }

  getAllMovies() async {
    _connection = await instance.connection;
    return _connection.query(""" SELECT * FROM Movies """);
  }

  getAllSeries() async {
    _connection = await instance.connection;
    return _connection.query(""" SELECT * FROM Series """);
  }

  getMoviesList(String user_uid) async {
    _connection = await instance.connection;
    return _connection.query(
        """ SELECT * FROM Watch_Later_Movies w JOIN Movies m WHERE w.movie_uid = m.movie_uid AND w.user_uid = $user_uid""");
  }


   getSeriesList(String user_uid) async {
    _connection = await instance.connection;
    return _connection.query(
        """ SELECT * FROM Watch_Later_Series w JOIN Series m WHERE w.serie_uid = m.serie_uid AND w.user_uid = $user_uid""");
  }

  addToMoviesList(String user_uid, String movie_uid) async {
     _connection = await instance.connection;
    return _connection.query(
        """ INSERT INTO Watch_Later_Movies(user_uid,movie_uid) VALUES ('$user_uid','$movie_uid')""");
  }

  getMovieActors(String movie_uid) async {
    _connection = await instance.connection;
    return _connection
        .query(""" SELECT a.name, a.surname FROM Movie_Actors m JOIN Actors a ON m.actor_uid = a.actor_uid WHERE movie_uid = $movie_uid""");
  }

  getMovieGenres(String movie_uid) async {
     _connection = await instance.connection;
    return _connection
        .query(""" SELECT g.genre FROM Movies m JOIN Movie_Genres g ON m.movie_uid = g.movie_uid WHERE m.movie_uid = $movie_uid""");
  }

  checkMovieInList(String user_uid,String movie_uid) async {
    _connection = await instance.connection;
    return _connection.query(
        """ SELECT * FROM Watch_Later_Movies WHERE user_uid = $user_uid AND movie_uid = $movie_uid""");
  }

  deleteMoviesFromList(String user_uid,String movie_uid) async {
    _connection = await instance.connection;
    return _connection.query(
        """ DELETE FROM Watch_Later_Movies WHERE user_uid = $user_uid AND movie_uid = $movie_uid""");
  }

  searchMovie(String prefix) async {
    _connection = await instance.connection;
    return _connection.query(
        """SELECT * FROM Movies WHERE movie_name LIKE '$prefix%'""");
  }

  getEpisodes(String serie_uid) async {
     _connection = await instance.connection;
    return _connection
        .query(""" SELECT e.episode_name,e.episode_uid FROM Series s JOIN Serie_Seasons a ON s.serie_uid = a.serie_uid 
                    JOIN Episodes e ON a.season_uid = e.season_uid WHERE a.season_number = 1 AND a.serie_uid = $serie_uid""");
  }

  getSerieActors(String serie_uid) async {
    _connection = await instance.connection;
    return _connection
        .query(""" SELECT a.name, a.surname FROM Serie_Actors m JOIN Actors a ON m.actor_uid = a.actor_uid WHERE serie_uid = $serie_uid""");
  }

  getEpisodeActors(String episode_uid) async {
    _connection = await instance.connection;
    return _connection
        .query(""" SELECT a.name, a.surname FROM Serie_Episode_Actors m JOIN Actors a ON m.actor_uid = a.actor_uid WHERE m.episode_uid = $episode_uid""");
  }

  getSerieGenres(String serie_uid) async {
     _connection = await instance.connection;
    return _connection
        .query(""" SELECT g.genre FROM Series m JOIN Serie_Genres g ON m.serie_uid = g.serie_uid WHERE m.serie_uid = $serie_uid""");
  }

  addToSeriesList(String user_uid, String serie_uid) async {
     _connection = await instance.connection;
    return _connection.query(
        """ INSERT INTO Watch_Later_Series(user_uid,serie_uid) VALUES ('$user_uid','$serie_uid')""");
  }

  checkSerieInList(String user_uid,String serie_uid) async {
    _connection = await instance.connection;
    return _connection.query(
        """ SELECT * FROM Watch_Later_Series WHERE user_uid = $user_uid AND serie_uid = $serie_uid""");
  }

  deleteSeriesFromList(String user_uid,String serie_uid) async {
    _connection = await instance.connection;
    return _connection.query(
        """ DELETE FROM Watch_Later_Series WHERE user_uid = $user_uid AND serie_uid = $serie_uid""");
  }

  searchSerie(String prefix) async {
    _connection = await instance.connection;
    return _connection.query(
        """SELECT * FROM Series WHERE serie_name LIKE '$prefix%'""");
  }

  getUidFromEmail(String email) async {
    _connection = await instance.connection;
    return _connection
        .query(""" SELECT user_uid FROM Users WHERE email_adress = '$email'""");
  }

  printUsers() async {
    _connection = await instance.connection;
    _connection.query("select * from Users").then((value) => {print(value)});
  }
}
