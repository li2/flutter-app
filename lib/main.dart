import 'package:flutter/material.dart';
import 'package:flutter_app/codelabs/WriteYourFirstFlutterApp/RandomWordsScreen.dart';
import 'package:flutter_app/hello/HelloFlutterScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: HelloFlutterScreen(greetings: "Hello Flutter, I'am Weiyi"),
      home: RandomWordsScreen(),
    );
  }
}
