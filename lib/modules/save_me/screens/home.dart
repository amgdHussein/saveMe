import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/post.dart';
import 'profile/cubit/profile_cubit.dart';
import '../../../widgets/post/post_view.dart';
// import 'package:save_me/widgets/posts.dart';
import '../../../widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_me/modules/save_me/repositories/post_repository.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PostRepository _postRepo = PostRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context, isAppTitle: true, disableBack: true),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
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
                      posts: snapshot.data.docs.map((doc) {
                        Map<String, dynamic> postMap = doc.data();
                        if (postMap.containsKey('missingFrom'))
                          return Missing.fromMap(postMap);
                        return Finding.fromMap(postMap);
                      }).toList(),
                    );
                  }
              }
            },
          );
        },
      ),
    );
  }
}
