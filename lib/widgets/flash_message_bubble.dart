import 'package:flutter/material.dart';

class FlashMessageBubble extends StatelessWidget {
  FlashMessageBubble(
      {@required this.sender,
      @required this.message,
      @required String currentUser})
      : _user = currentUser;

  final String sender;
  final String message;
  final String _user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment:
            _user == sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            color: _user == sender
                ? Theme.of(context).accentColor
                : Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[600]
                    : Colors.grey[300],
            elevation: 4.0,
            borderRadius: BorderRadius.circular(18.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Text(message),
            ),
          ),
          Text(
            sender,
            style: TextStyle(fontSize: 11.0),
          ),
        ],
      ),
    );
  }
}
