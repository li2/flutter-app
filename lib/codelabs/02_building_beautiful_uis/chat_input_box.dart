import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/style.dart';

class ChatInputBox extends StatefulWidget {
  ChatInputBox({this.onSubmitted});

  // specific as String, otherwise: type '(String) => void' is not a subtype of type '(dynamic) => void'
  // todo weiyi kind of Function type?
  final ValueChanged<String> onSubmitted;

  @override
  State<StatefulWidget> createState() => ChatInputBoxState();
}

class ChatInputBoxState extends State<ChatInputBox> {

  final _textController = TextEditingController();

  bool _isComposing = false;
  void _setComposing(bool value) {
    setState(() {
      _isComposing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row( // to display multiple widgets in a row
        children: <Widget>[
          Flexible( // automatically use the remaining space.
            child: TextField(
              controller: _textController,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message'
              ),
              onSubmitted: _handleSubmitted,
              onChanged: (String text) => _setComposing(text.length > 0),
            ),
          ),
          Container( // use container to set the margins of button
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: isIOS(context) ?
            CupertinoButton(
              child: Text('Send'),
              onPressed: _isComposing // Make the send button context-aware
                ? () => _handleSubmitted(_textController.text)
                : null) :
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _isComposing // Make the send button context-aware
                ? () => _handleSubmitted(_textController.text)
                : null,
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _setComposing(false);
    _textController.clear();
    widget.onSubmitted(text);
  }
}
