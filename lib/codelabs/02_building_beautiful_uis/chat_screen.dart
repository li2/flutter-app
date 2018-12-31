import 'package:flutter/material.dart';
import 'package:flutter_app/codelabs/02_building_beautiful_uis/chat_input_box.dart';
import 'package:flutter_app/codelabs/02_building_beautiful_uis/chat_message_widget.dart';
import 'package:flutter_app/style.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _messages = List<ChatMessageWidget>();

  @override
  Widget build(BuildContext context) {
    Widget _appBar = AppBar(
      title: Text('Friendly Chat'),
      elevation: appBarElevation(context),
    );

    Widget _divider = Divider(height: 1);

    Widget _messageList = Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (_, int index) => _messages[index],
      )
    );

    Widget _chatBox = Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: ChatInputBox(onSubmitted: _handleSubmitted),
    );

    Decoration _upperEdgeBorder = isIOS(context)
      ? BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[200])))
      : null;

    return Scaffold(
      appBar: _appBar,
      body: Container(
        child: Column(
          children: <Widget>[
            _messageList,
            _divider,
            _chatBox,
          ],
        ),
        decoration: _upperEdgeBorder
      ),
    );
  }

  void _handleSubmitted(String text) {
    // todo weiyi use DI instead of passing user name
    final newMessage = ChatMessageWidget(name: 'Weiyi', message: text);
    // setState() to modify _messages and to let the framework know this part of
    // the widget tree has changed and it needs to rebuild the UI.
    setState(() {
      _messages.insert(0, newMessage);
    });
  }
}
