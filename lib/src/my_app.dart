import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';
import 'ui/screens/game_page.dart';
import 'ui/screens/help_page.dart';
import 'ui/screens/about_page.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: MaterialApp(
        title: 'Play Nine',
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => GamePage(),
          "/help": (context) => HelpPage(),
          "/about": (context) => AboutPage(),
        },
      ),
    );
  }
}