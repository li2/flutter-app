import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/hello/hello_flutter_screen.dart';
import 'package:flutter_app/codelabs/01_write_your_first_flutter_app/random_words_screen.dart';
import 'package:flutter_app/codelabs/02_building_beautiful_uis/chat_screen.dart';
import 'package:flutter_app/style.dart';

void main() => runApp(MyApp());

const String userName = "Weiyi";

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTargetPlatform == TargetPlatform.iOS
        ? kIOSTheme
        : kDefaultTheme,
      //home: HelloFlutterScreen(greetings: "Hello Flutter, I'am Weiyi"),
      //home: RandomWordsScreen(),
      home: ChatScreen(),
    );
  }
}
