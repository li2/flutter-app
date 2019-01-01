import 'package:flutter/material.dart';
import 'package:flutter_app/hello/hello_flutter_screen.dart';

class HelloApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      home: HelloFlutterScreen(greetings: "Hello Flutter, I'am Weiyi"),
    );
  }
}
