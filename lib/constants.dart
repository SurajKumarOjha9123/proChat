import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proChat/screens/chat_screen.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

StreamBuilder<QuerySnapshot> buildStreamBuilder() {
  final _firestore = Firestore.instance;
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection('message').orderBy('time',descending: true).snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(
            child:
                CircularProgressIndicator(backgroundColor: Colors.blueAccent));
      }
      final messages = snapshot.data.documents.reversed;
      List<MessageBubble> messageWidgets = [];
      for (var message in messages) {
        final messageText = message.data['Text'];
        final messageSender = message.data['sender'];
        final messageWidget = MessageBubble(
            messageText: messageText, messageSender: messageSender);
        messageWidgets.add(messageWidget);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: messageWidgets,
      );
    },
  );
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key key,
    @required this.messageText,
    @required this.messageSender,
  }) : super(key: key);

  final messageText;
  final messageSender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: loggedInUser.email != messageSender
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Material(
            borderRadius: loggedInUser != messageSender
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    // bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))
                : BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    // bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(10),
                  ),
            // borderRadius: BorderRadius.circular(22),
            elevation: 5,
            shadowColor: Colors.grey[500],
            color: loggedInUser.email != messageSender
                ? Colors.white
                : Colors.green[500],
            child: Container(
              margin: EdgeInsets.all(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 4,
                ),
                child: Text(
                  '$messageText',
                  style: TextStyle(
                    color: loggedInUser.email != messageSender
                        ? Colors.black87
                        : Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Text(
            '$messageSender',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
