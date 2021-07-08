import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../modules/save_me/models/firestore_user.dart';
import '../../modules/save_me/repositories/user_repository.dart';
import 'post_bottom_sheet_info.dart';

Widget post({@required dynamic post, @required BuildContext context}) {
  return FutureBuilder(
    future: UserRepository().user(post.uid),
    builder: (BuildContext context, AsyncSnapshot<FirestoreUser> snapshot) {
      if (snapshot.hasError)
        return Text('Error: ${snapshot.error}');
      else {
        return GestureDetector(
          onTap: () {
            displayPostInfo(
              context: context,
              post: post,
              owner: snapshot.data,
            );
          },
          child: Stack(
            children: [
              Image.network(post.image),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  post.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    },
  );
}

Widget viewPosts({
  @required List<dynamic> posts,
  @required BuildContext context,
}) =>
    ListView.separated(
      itemBuilder: (context, index) => post(
        context: context,
        post: posts[index],
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: 2,
      ),
      itemCount: posts.length,
    );
