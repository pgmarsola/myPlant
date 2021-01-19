import 'package:flutter/material.dart';
import 'package:my_plant/screens/home.dart';
import 'package:my_plant/utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            centerTitle: true,
          ),
          primaryIconTheme: IconThemeData(color: verde)),
      home: Home(),
    );
  }
}
