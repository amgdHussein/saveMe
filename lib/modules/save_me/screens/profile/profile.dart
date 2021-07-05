import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:save_me/modules/save_me/models/firestore_user.dart';
import 'package:save_me/modules/save_me/models/post.dart';
import 'package:save_me/modules/save_me/repositories/post_repository.dart';
import 'package:save_me/modules/save_me/screens/chat/chat_details.dart';
import 'package:save_me/widgets/post/post_view.dart';
import '../../../../core/auth/blocs/auth_bloc.dart';

import 'cubit/profile_cubit.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  final FirestoreUser _user;
  ProfileScreen({Key key, FirestoreUser user})
      : _user = user,
        super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PostRepository _postRepo = PostRepository();

  @override
  Widget build(BuildContext context) {
    String uid = widget._user == null
        ? FirebaseAuth.instance.currentUser.uid
        : widget._user.uid;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).primaryColor,
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, bool innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                expandedHeight: 300.0,
                leading: SizedBox.shrink(),
                actions: widget._user == null
                    ? [
                        IconButton(
                          icon: Icon(FontAwesomeIcons.userEdit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => ProfileCubit(),
                                  child: ProfileEditScreen(),
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.signOutAlt),
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(AuthSignedOut());
                          },
                        ),
                      ]
                    : [
                        IconButton(
                          icon: Icon(FontAwesomeIcons.commentDots),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessagesScreen(
                                  user: widget._user,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.times),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(20),
                  title: Text(
                    widget._user == null
                        ? state.user.displayName
                        : widget._user.name,
                  ),
                  background: Image.network(
                    widget._user == null
                        ? state.user.photoURL
                        : widget._user.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            body: StreamBuilder<QuerySnapshot>(
              stream: _postRepo.posts,
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else {
                      return viewPosts(
                        context: context,
                        posts: snapshot.data.docs.where((element) {
                          Map<String, dynamic> map = element.data();
                          return map['uid'] == uid;
                        }).map(
                          (post) {
                            Map<String, dynamic> map = post.data();
                            if (map.containsKey('missingFrom'))
                              return Missing.fromMap(map);
                            else
                              return Finding.fromMap(map);
                          },
                        ).toList(),
                      );
                    }
                }
              },
            ),
          ),
        );
      },
    );
  }
}
