import 'package:flash_chat/widgets/flash_message_bubble.dart';
import 'package:flash_chat/widgets/flash_message_input.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  static String routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    FirebaseUser currentUser;
    try {
      currentUser = await _auth.currentUser();
      if (currentUser != null) {
        user = currentUser;
      }
    } catch (e) {
      print(e);
    }
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
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildMessagesList(),
            FlashMessageInput(
              currentUser: user?.email,
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> _buildMessagesList() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('messages').orderBy('createdAt').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              reverse: true,
              children: snapshot.data.documents.reversed.map(
                (messageDocSnapshot) {
                  final sender = messageDocSnapshot.data['sender'];
                  final message = messageDocSnapshot.data['text'];
                  return FlashMessageBubble(
                    sender: sender ?? '',
                    message: message ?? '',
                    isCurrentUser: user?.email == sender,
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
