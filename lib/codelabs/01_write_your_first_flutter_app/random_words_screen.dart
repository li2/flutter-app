import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/codelabs/01_write_your_first_flutter_app/saved_words_screen.dart';
import 'package:flutter_app/style.dart';

/*
https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1/
https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2/
 */
class RandomWordsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordsScreenState();
}

class RandomWordsScreenState extends State<RandomWordsScreen> {
  final _suggestions = List<WordPair>();
  final _saved = Set<WordPair>();
  ScrollController _controller;

  @override
  void initState() {
    _suggestions.addAll(generateWordPairs().take(10));
    /*
     ScrollController refer https://stackoverflow.com/a/49509349/2722270
     The .. syntax in the preceding code is called a cascade. With cascades,
     you can perform multiple operations on the members of a single object.
     */
    _controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSavedWordsScreen),
        ],
      ),
      body: _buildSuggestionsList());

  void _scrollListener() {
    // reach to bottom
    if (_controller.offset >= _controller.position.maxScrollExtent
      && !_controller.position.outOfRange) {
      setState(() {
        _suggestions.addAll(generateWordPairs().take(10));
      });
    }
  }

  /*
   AlwaysScrollableScrollPhysics: Scroll physics that always lets the user scroll, to avoid list unscrollable issue when list is short.
   */
  Widget _buildSuggestionsList() =>
    ListView.separated(
      padding: LIST_PADDING,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _controller,
      itemCount: _suggestions.length,
      itemBuilder: (BuildContext _context, int index) => _buildRow(_suggestions[index]),
    );
  
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: BIGGER_FONT,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // todo weiyi click listener only for the icon?
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  /*
   Navigate and pass data to the Detail Screen
   refer https://flutter.io/docs/cookbook/navigation/passing-data
   */
  void _pushSavedWordsScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SavedWordsScreen(savedWords: _saved.toList())));
  }
}
