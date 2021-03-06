
import 'package:epsi_tchat/page/home_page.dart';
import 'package:epsi_tchat/page/login_page.dart';
import 'package:epsi_tchat/page/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: const RegisterPage(),
      routes: <String, WidgetBuilder> {
        '/register':(BuildContext context) => const RegisterPage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/home_page': (BuildContext context) => const HomePage()
      },
    );
  }
}