import 'package:chat_app_template/services/route_helper.dart';
import 'package:chat_app_template/views/base/custom_appbar.dart';
import 'package:chat_app_template/views/base/shimmer.dart';
import 'package:chat_app_template/views/screens/chat_screens/audio_call.dart';
import 'package:chat_app_template/views/screens/chat_screens/video_call.dart';
import 'package:chat_app_template/views/screens/chat_screens/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;
  User? loggeduser;

  final TextEditingController sendMsgControlller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggeduser = user;
        print(loggeduser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Chat Screen",
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, getCustomRoute(child: const AudioCall()));
            },
            icon: const Icon(Icons.call_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, getCustomRoute(child: const VideoCall()));
            },
            icon: const Icon(Icons.video_call_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  _firestore.collection('msg').orderBy('Timestamp').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CustomShimmer(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) => Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return MessageBubble(
                                message: data['txt'],
                                itsMe: loggeduser!.email == data['sender'],
                                sender: data['sender'],
                              );
                            })
                            .toList()
                            .reversed
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: sendMsgControlller,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                hintText: "Send Message",
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () async {
                              await _firestore.collection('msg').add({
                                'txt': sendMsgControlller.text,
                                'sender': loggeduser!.email,
                                'Timestamp': FieldValue.serverTimestamp(),
                              });
                              sendMsgControlller.clear();
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
