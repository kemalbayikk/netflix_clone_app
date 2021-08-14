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

  getDepartments(String companyUid) async {
    _connection = await instance.connection;
    return _connection.query(""" SELECT * FROM Departments WHERE company = $companyUid""");
  }

  printUsers() async {
    _connection = await instance.connection;
    _connection.query("select * from Users").then((value) => {print(value)});
  }
}
