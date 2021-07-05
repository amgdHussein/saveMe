import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_me/modules/save_me/models/firestore_user.dart';
import 'package:save_me/modules/save_me/screens/chat/chat_details.dart';

Widget UsersChatListTile({@required List<DocumentSnapshot> docs}) {
  List<FirestoreUser> users =
      docs.map((e) => FirestoreUser.fromMap(e.data())).toList();

  return ListView.separated(
    itemBuilder: (context, index) {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            users[index].image,
          ),
        ),
        title: Text(users[index].name),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MessagesScreen(user: users[index]);
              },
            ),
          );
        },
      );
    },
    separatorBuilder: (context, index) {
      return Divider();
    },
    itemCount: users.length,
  );
}
