import 'package:flutter/material.dart';
import 'ui/screens/home_page.dart';
import 'ui/screens/help_page.dart';
import 'ui/screens/about_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/help": (context) => HelpPage(),
        "/about": (context) => AboutPage(),
      },
    );
  }
}