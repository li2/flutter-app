import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/codelabs/02_building_beautiful_uis/chat_screen.dart';
import 'package:flutter_app/style.dart';

const String userName = "Weiyi";

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Demo',
      theme: defaultTargetPlatform == TargetPlatform.iOS
        ? kIOSTheme
        : kDefaultTheme,
      home: ChatScreen(),
    );
  }
}

