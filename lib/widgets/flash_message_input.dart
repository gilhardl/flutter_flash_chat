import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class FlashMessageInput extends StatefulWidget {
  FlashMessageInput({
    @required String currentUser,
  }) : _user = currentUser;

  final String _user;

  @override
  _FlashMessageInputState createState() => _FlashMessageInputState();
}

class _FlashMessageInputState extends State<FlashMessageInput> {
  final TextEditingController _messageInputCtrl = TextEditingController();

  String messageText;

  @override
  void dispose() {
    _messageInputCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).accentColor,
            width: 2.0,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageInputCtrl,
              onChanged: (value) {
                messageText = value;
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                hintText: 'Type your message here...',
                border: InputBorder.none,
              ),
            ),
          ),
          FlatButton(
            onPressed: () async {
              await _firestore.collection('messages').add({
                'text': messageText,
                'sender': widget._user,
                'createdAt': FieldValue.serverTimestamp()
              });
              _messageInputCtrl.clear();
            },
            child: Text(
              'Send',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
