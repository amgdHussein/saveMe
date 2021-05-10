import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../modules/save_me/models/post.dart';

Widget post({@required Post post}) => Stack(
      children: [
        Image.network(post.imagePath),
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
    );


Widget viewPosts({@required List<Post> posts}) => ListView.separated(
      itemBuilder: (context, index) => post(
        post: posts[index],
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: 2,
      ),
      itemCount: posts.length,
    );
