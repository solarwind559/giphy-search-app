import 'package:flutter/material.dart';
import 'package:giphy_search/screens/giphy_page.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: GiphyPage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            title: 'Flutter Demo',
            home: GiphyPage(),
          )
        : MaterialApp(
            title: 'Flutter Demo',
            home: GiphyPage(),
          );
  }
}