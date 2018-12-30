import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/style.dart';

class SavedWordsScreen extends StatefulWidget {
  final screenTitle = 'Saved Suggestions';
  final List<WordPair> savedWords;

  SavedWordsScreen({Key key, @required this.savedWords}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SavedWordsScreenState();
}

class _SavedWordsScreenState extends State<SavedWordsScreen> {
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(title: Text(widget.screenTitle)),
      body: _buildList()
    );

  Widget _buildList() =>
    ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (BuildContext context, int index) => Divider(),
      // access data stored in StatefulWidget by widget
      itemCount: widget.savedWords.length,
      itemBuilder: (BuildContext context, int index) =>
        _buildRow(widget.savedWords[index]),
    );

  Widget _buildRow(WordPair pair) =>
    ListTile(
      title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18))
    );
}
