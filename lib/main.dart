import 'package:flutter/material.dart';
import 'package:netflix_clone_app/pages/login_page.dart';
import 'package:netflix_clone_app/pages/page_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

