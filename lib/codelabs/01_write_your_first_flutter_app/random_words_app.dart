import 'package:flutter/material.dart';
import 'package:flutter_app/codelabs/01_write_your_first_flutter_app/random_words_screen.dart';

class RandomWordsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Words',
      home: RandomWordsScreen(),
    );
  }
}
