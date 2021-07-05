import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:save_me/constants/app_constants.dart';
import 'package:save_me/modules/save_me/models/firestore_user.dart';
import 'package:save_me/modules/save_me/models/message.dart';
import 'package:save_me/modules/save_me/repositories/chat_repository.dart';
import 'package:save_me/modules/save_me/repositories/user_repository.dart';
import 'package:save_me/modules/save_me/screens/chat/chat_details.dart';

// ignore: non_constant_identifier_names
Widget ChatListTile(List<DocumentSnapshot> docs) {
  final ConversationRepository _conversationRepository =
      ConversationRepository();
  final UserRepository _userRepository = UserRepository();

  return ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      DocumentSnapshot<Object> doc = docs[index];
      return FutureBuilder<FirestoreUser>(
        future: _userRepository.user(doc.id),
        builder: (context, userSnapshot) {
          switch (userSnapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (userSnapshot.hasError)
                return Text('Error: ${userSnapshot.error}');
              else {
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream:
                      _conversationRepository.messages(userSnapshot.data.uid),
                  builder: (context, messageSnapshot) {
                    switch (messageSnapshot.connectionState) {
                      case ConnectionState.waiting:
                        return SizedBox.shrink();
                      default:
                        if (messageSnapshot.hasError)
                          return Text(
                            'Error: ${messageSnapshot.error}',
                          );
                        else {
                          List<Message> messages = messageSnapshot.data.docs
                              .map((e) => Message.fromMap(e.data()))
                              .toList();
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userSnapshot.data.image,
                                ),
                              ),
                              title: Text(userSnapshot.data.name),
                              subtitle: Text(
                                messages.first.content,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                DEFAULT_DATE_FORMAT.format(
                                  messages.first.date,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MessagesScreen(
                                        user: FirestoreUser.fromMap(
                                          userSnapshot.data.toMap(),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'Delete',
                                color: Colors.redAccent,
                                icon: Icons.delete,
                                onTap: () async {
                                  await _conversationRepository.deleteMessage(
                                    userSnapshot.data.uid,
                                  );
                                },
                              ),
                            ],
                          );
                        }
                    }
                  },
                );
              }
          }
        },
      );
    },
    separatorBuilder: (context, index) => Divider(),
    itemCount: docs.length,
  );
}
