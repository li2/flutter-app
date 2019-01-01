import 'package:flutter/material.dart';
import 'package:flutter_app/codelabs/03_firebase_for_flutter/votes_screen.dart';

class VotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Name Votes',
      home: VotesScreen(),
    );
  }
}
