import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './app/locator/locator.dart';
import './ui/screens/main_screen/main_screen.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        title: 'Flutter Demo',
        // theme: CupertinoThemeData(
        //   // primarySwatch: Colors.blue,
        //   brightness: Brightness.light,
        // ),
        home: MainScreen());
  }
}
