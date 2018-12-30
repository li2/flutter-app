import 'package:flutter/material.dart';

class HelloFlutterScreen extends StatefulWidget {
  final String greetings;

  HelloFlutterScreen({Key key, this.greetings}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HelloFlutterSate();
}

class _HelloFlutterSate extends State<HelloFlutterScreen> {
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter'),
      ),
      body: Center(
        child: Text(widget.greetings),
      )
    );
}
