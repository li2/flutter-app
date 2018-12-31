import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  ChatMessageWidget({ this.name, this.message });
  final String name;
  final String message;

  @override
  Widget build(BuildContext context) {
    Widget _wAvator = CircleAvatar(child: Text(name[0]));

    // add an Expanded widget to make sure long text wraps correctly.
    Widget _wNameAndMessage = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: Theme.of(context).textTheme.subhead),
          const SizedBox(height: 5.0),
          Text(message),
        ],
      ),
    );

    Widget _wRoot = Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _wAvator,
          const SizedBox(width: 16),
          _wNameAndMessage,
        ],
      ),
    );

    return _wRoot;
  }
}
