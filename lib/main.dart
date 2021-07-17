import 'screens/landingpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   textTheme: Theme.of(context).textTheme,
      // ),
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Landing(),
    );
  }
}

