import 'package:flutter/material.dart';
import 'package:openrepara_app/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routesApp(),
      debugShowCheckedModeBanner: false,
      initialRoute: "login",
    );
  }
}
