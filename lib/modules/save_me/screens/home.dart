import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_me/widgets/app_logo.dart';
import '../models/post.dart';
import '../../../widgets/post/post_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_me/modules/save_me/repositories/post_repository.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PostRepository _postRepo = PostRepository();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leadingWidth: 30,
          title: logoRichText(
            textStyle1: Theme.of(context).appBarTheme.textTheme.headline1,
            textStyle2: Theme.of(context).appBarTheme.textTheme.headline2,
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Missing"),
              Tab(text: "Finding"),
            ],
          ),
        ),
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
                  return TabBarView(
                    children: [
                      viewPosts(
                        context: context,
                        posts: snapshot.data.docs
                            .where(
                              (post) {
                                Map<String, dynamic> map = post.data();
                                return map.containsKey('missingFrom');
                              },
                            )
                            .map((e) => Missing.fromMap(e.data()))
                            .toList(),
                      ),
                      viewPosts(
                        context: context,
                        posts: snapshot.data.docs
                            .where(
                              (post) {
                                Map<String, dynamic> map = post.data();
                                return (!map.containsKey('missingFrom'));
                              },
                            )
                            .map((e) => Finding.fromMap(e.data()))
                            .toList(),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
