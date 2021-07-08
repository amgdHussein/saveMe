import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../repositories/chat_repository.dart';
import '../../repositories/user_repository.dart';
import 'bloc/chat_search_bloc.dart';
import '../../../../widgets/chat/chat_list_tile.dart';
import '../../../../widgets/user_list_tile.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ConversationRepository _conversationRepository =
      ConversationRepository();
  final UserRepository _userRepository = UserRepository();
  final TextEditingController _searchController = TextEditingController();
  ChatSearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<ChatSearchBloc>(context);
    _searchController.addListener(_onSearchChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatSearchBloc, ChatSearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Conversations",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
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
                top: MediaQuery.of(context).size.height * 0.02 + 60,
                left: 0,
                right: 0,
                bottom: 0,
                child: Conditional.single(
                  context: context,
                  conditionBuilder: (context) => _searchController.text.isEmpty,
                  widgetBuilder: (context) {
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: _conversationRepository.conversations,
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
                              return ChatListTile(docs);
                            }
                        }
                      },
                    );
                  },
                  fallbackBuilder: (context) {
                    return StreamBuilder(
                      stream: _userRepository.users,
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

                              return usersChatListTile(
                                docs: docs.where(
                                  (user) {
                                    Map<String, dynamic> map = user.data();
                                    return map['name']
                                            .contains(_searchController.text) &&
                                        FirebaseAuth.instance.currentUser.uid !=
                                            map['uid'];
                                  },
                                ).toList(),
                              );
                            }
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSearchChange() {
    _searchBloc.add(SearchChange(search: _searchController.text));
  }
}
