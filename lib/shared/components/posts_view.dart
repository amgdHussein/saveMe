import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:save_me/models/post.dart';
import 'package:save_me/shared/components/post_widget.dart';

class PostsView extends StatelessWidget {
  final List<Post> posts;
  PostsView({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) => PostWidget(post: posts[index]),
        separatorBuilder: (context, index) => SizedBox(
          height: 2,
        ),
        itemCount: posts.length,
      ),
    );
  }
}
