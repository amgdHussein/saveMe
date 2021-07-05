import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_me/modules/save_me/models/firestore_user.dart';
import 'package:save_me/modules/save_me/models/message.dart';
import 'package:save_me/modules/save_me/repositories/chat_repository.dart';

class MessagesScreen extends StatelessWidget {
  final FirestoreUser user;
  final ConversationRepository _conversationRepository =
      ConversationRepository();
  final TextEditingController _messageController = TextEditingController();

  MessagesScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 20,
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.image),
              ),
            ),
            Text(user.name),
          ],
        ),
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
                messages.sort((a, b) => a.date.compareTo(b.date));

                return Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    ListView.builder(
                      itemCount: messages.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (messages[index].sid == user.uid
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (messages[index].rid == user.uid
                                    ? Colors.grey.shade200
                                    : Colors.blue[200]),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(
                                messages[index].content,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20,
                      ),
                      child: TextFormField(
                        controller: _messageController,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'type your message here ...',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              if (_messageController.text.isNotEmpty) {
                                _conversationRepository.addMessage(Message(
                                  content: _messageController.text,
                                  date: DateTime.now(),
                                  rid: user.uid,
                                  sid: FirebaseAuth.instance.currentUser.uid,
                                ));
                                _messageController.text = '';
                              }
                            },
                          ),
                        ),
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

      //     return Conditional.single(
      //       context: context,
      //       conditionBuilder: (context) => true,
      //       widgetBuilder: (context) {
      //         return Column(
      //           children: [
      //             ListView.separated(
      //               physics: BouncingScrollPhysics(),
      //               itemBuilder: (context, index) => ListTile(
      //                 leading: CircleAvatar(),
      //                 title: Text("Ahmed"),
      //                 subtitle: Text(
      //                   "hi ahmed, send me your resume",
      //                   overflow: TextOverflow.ellipsis,
      //                 ),
      //                 trailing:
      //                     Text(DEFAULT_DATE_FORMAT.format(DateTime.now())),
      //                 onTap: () {
      //                   // navigateTo(
      //                   //   context,
      //                   //   ChatDetailsScreen(
      //                   //     userModel: model,
      //                   //   ),
      //                   // );
      //                 },
      //               ),
      //               // buildChatItem(SocialCubit.get(context).users[index], context),
      //               separatorBuilder: (context, index) => Divider(),
      //               itemCount: 10,
      //             ),
      //           ],
      //         );
      //       },
      //       fallbackBuilder: (context) =>
      //           Center(child: CircularProgressIndicator()),
      //     );
      //   },
      // ),
