import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:save_me/constants/app_constants.dart';
import 'package:save_me/modules/save_me/models/firestore_user.dart';
import 'package:save_me/modules/save_me/repositories/chat_repository.dart';
import 'package:save_me/modules/save_me/repositories/user_repository.dart';
import 'package:save_me/modules/save_me/screens/chat/chat_details.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  final ConversationRepository _conversationRepository =
      ConversationRepository();
  final UserRepository _userRepository = UserRepository();
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _conversationRepository.conversations,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else {
                QuerySnapshot documents = snapshot.data;
                List<DocumentSnapshot> docs = documents.docs;
                return Conditional.single(
                  context: context,
                  conditionBuilder: (context) => true,
                  widgetBuilder: (context) {
                    return Stack(
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.05,
                          left: 16,
                          right: 16,
                          height: 60,
                          child: Text(
                            "Conversations",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.11,
                          left: 16,
                          right: 16,
                          height: 60,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: "Search...",
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey.shade600,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade100,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.17,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              DocumentSnapshot<Object> doc = docs[index];
                              return FutureBuilder<FirestoreUser>(
                                future: _userRepository.user(doc.id),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    default:
                                      if (snapshot.hasError)
                                        return Text(
                                          'Error: ${snapshot.error}',
                                        );
                                      else {
                                        return ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              snapshot.data.image,
                                            ),
                                          ),
                                          title: Text(snapshot.data.name),
                                          subtitle: Text(
                                            "hi ahmed, send me your resume",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          trailing: Text(DEFAULT_DATE_FORMAT
                                              .format(DateTime.now())),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return MessagesScreen(
                                                    user: FirestoreUser.fromMap(
                                                      snapshot.data.toMap(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      }
                                  }
                                },
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: docs.length,
                          ),
                        ),
                      ],
                    );
                  },
                  fallbackBuilder: (context) =>
                      Center(child: CircularProgressIndicator()),
                );
              }
          }
        },
      ),
    );
  }
}
