import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:save_me/shared/components/posts_view.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_me/shared/cubit/lost_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LostCubit, LostState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {

        return DefaultTabController(
          length: 2,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: TabBarView(
                  children: [
                    PostsView(posts: LostCubit.get(context).getMissingPostData()),
                    PostsView(posts: LostCubit.get(context).getFindingPostData()),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black54, Colors.transparent],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Save Me".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 32,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: TabBar(
                                labelColor: Colors.white,
                                indicatorColor: Colors.white,
                                unselectedLabelColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 2.0,
                                  fontSize: 16,
                                ),

                                tabs: [
                                  Tab(text: "Missing"),
                                  Tab(text: "Finding"),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              height: 1.0,
                              child: Container(color: Colors.white30),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
