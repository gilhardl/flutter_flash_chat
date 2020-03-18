import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser user;
  String messageText;
  final _messageInputCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    initMessageInputCtrl();
  }

  @override
  void dispose() {
    _messageInputCtrl.dispose();
    super.dispose();
  }

  void getCurrentUser() async {
    FirebaseUser currentUser;
    try {
      currentUser = await _auth.currentUser();
      if (currentUser != null) {
        user = currentUser;
        print(user);
      }
    } catch (e) {
      print(e);
    }
  }

  void initMessageInputCtrl() {
    _messageInputCtrl.addListener(() {
      messageText = _messageInputCtrl.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageInputCtrl,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': user.email,
                      });
                      _messageInputCtrl.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
