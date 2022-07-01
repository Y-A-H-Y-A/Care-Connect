// import 'package:care_connect/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:random_string/random_string.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:care_connect/services/helperfunction.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../custom_style.dart';

late final FirebaseFirestore _firestore = FirebaseFirestore.instance;

late User signedInUser;

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key, this.chatWithUsername, this.name, this.id})
      : super(key: key);
  static const String pageRout = 'chatroom';
  final String? chatWithUsername, name, id;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final messageTextController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  late final FirebaseAuth _auth = FirebaseAuth.instance;

  String? messageText; // this will give us the message

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      signedInUser = user;
    }
    try {} catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chatWithUsername as String,
          style: CustomTextStyle.style(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.primaryNormalBlue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            MessagesStreamBuilder(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: CustomColors.primaryDarkBlue,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        style: CustomTextStyle.style(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type a Message',
                          hintStyle: CustomTextStyle.style(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _firestore.collection('message').add({
                          'text': messageText,
                          'sender':
                              signedInUser.email!.replaceAll('@gmail.com', ''),
                          'time': FieldValue.serverTimestamp(),
                        });

                        messageController.clear();
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStreamBuilder extends StatelessWidget {
  const MessagesStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('message').orderBy('time').snapshots(),
        builder: ((context, snapshot) {
          List<Widget> messageWidget = [];

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final currentUser =
                signedInUser.email!.replaceAll('@gmail.com', '');

            final messageWidge = MessageLine(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );
            messageWidget.add(messageWidge);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWidget,
            ),
          );
        }));
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({Key? key, this.sender, this.text, required this.isMe})
      : super(key: key);
  final String? sender;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: CustomTextStyle.style(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black45,
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? CustomColors.primaryDarkBlue : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: CustomTextStyle.style(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
