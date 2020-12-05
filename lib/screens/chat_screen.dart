import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proChat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proChat/screens/login_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
FirebaseUser loggedInUser;
class _ChatScreenState extends State<ChatScreen> {
  FirebaseAuth _authUser = FirebaseAuth.instance;
  static final messageTextController = TextEditingController();
  String messageText;
  var time = DateTime.now().microsecondsSinceEpoch;
  final _firestore = Firestore.instance;
  void getUser() async {
    try {
      final user = await _authUser.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getSnapshotMessage() async {
    await for (var snapshots in _firestore.collection('message').snapshots()) {
      for (var snapshot in snapshots.documents) {
        print(snapshot.data);
      }
    }
  }

  @override
  initState() {
    super.initState();
    getUser();
    setState(() {
      showSpinner = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Center(child: Text('proChat_',style: TextStyle(fontSize:30),)),
        backgroundColor: Colors.green[900],
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                reverse:true,
                children: <Widget>[buildStreamBuilder()],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 25),
                      Expanded(
                        child: TextField(
                          readOnly: false,
                          controller: messageTextController,
                            enableInteractiveSelection: true,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 4,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 23,
                            ),
                            textAlign: TextAlign.left,
                            onChanged: (value) {
                              messageText = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.black87,
                              hintText: 'type ..',
                              focusColor: Colors.black87,
                              hintStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                              ),
                            ) //kMessageTextFieldDecoration,
                            ),
                      ),
                      FlatButton(
                        onPressed: () {
                          print(time);
                          messageTextController.clear();
                          _firestore.collection('message').add(
                            {'Text': messageText, 'sender': loggedInUser.email,'time':time},              
                          );
                          time=time+1;
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.green,
                          size: 35,
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
