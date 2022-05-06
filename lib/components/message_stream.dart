import 'package:flutter/material.dart';
import 'message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

User loggedUser;
final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class MessageStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var msg in messages) {
          final msgText = msg.get('text');
          final msgSender = msg.get('sender');
          final user = _auth.currentUser;
          String currentUser;
          if (user != null) {
            loggedUser = user;
            currentUser = loggedUser.email;
          }
          final msgWidget = MessageBubble(
            text: msgText,
            sender: msgSender,
            isMe: currentUser == msgSender,
          );
          messageBubbles.add(msgWidget);
        }
        return Expanded(
          child: ListView(
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
