import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}