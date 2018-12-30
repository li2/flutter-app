
import 'package:flutter/material.dart';

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
  accentColor: Colors.orangeAccent[400],
  iconTheme: IconThemeData(
    color: Colors.orange,
  )
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
  iconTheme: IconThemeData(
    color: Colors.purple,
  )
);

const BIGGER_FONT = const TextStyle(fontSize: 18);

const LIST_PADDING = const EdgeInsets.all(16);

isIOS(BuildContext context) => Theme.of(context).platform == TargetPlatform.iOS;

appBarElevation(BuildContext context) => isIOS(context) ? 0.0 : 4.0;
