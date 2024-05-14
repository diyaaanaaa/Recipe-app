import 'package:flutter/material.dart';
import 'package:recipe_app/homepage.dart';
import 'package:recipe_app/welcomepage.dart';

void main() {
  runApp(MyApp());
}

class RouteNames {
  static const String welcomepage = '/welcomepage';
  static const String homepage = 'homepage';
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteNames.welcomepage,
      routes: {
        RouteNames.welcomepage: (context) => WelcomePage(),
        RouteNames.homepage: (context) => HomeScreen(),
      },
    );
  }
}
