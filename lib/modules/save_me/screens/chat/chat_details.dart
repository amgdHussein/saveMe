import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/firestore_user.dart';
import '../../models/message.dart';
import '../../repositories/chat_repository.dart';
import '../../../../widgets/chat/conversation.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({Key key, this.user}) : super(key: key);

  final FirestoreUser user;
  final ConversationRepository _conversationRepository =
      ConversationRepository();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(user.name),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _conversationRepository.messages(user.uid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else {
                List<Message> messages = snapshot.data.docs
                    .map((e) => Message.fromMap(e.data()))
                    .toList();
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Conversation(user: user, messages: messages),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _messageController,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'type your message here ...',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.solidPaperPlane,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    if (_messageController.text.isNotEmpty) {
                                      _conversationRepository
                                          .addMessage(Message(
                                        content: _messageController.text,
                                        date: DateTime.now(),
                                        rid: user.uid,
                                        sid: FirebaseAuth
                                            .instance.currentUser.uid,
                                      ));
                                      _messageController.text = '';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
