import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/themes/colors.dart';
import '../../../widgets/app_drawer.dart';

import '../../../widgets/posts_view.dart';
import '../cubit/save_me_cubit.dart';

class HomeScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // final Size pageSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headline2,
            children: [
              TextSpan(
                text: "save",
                style: TextStyle(
                  color: GRAY_CHATEAU,
                ),
              ),
              TextSpan(
                text: "Me",
                style: TextStyle(color: ABBEY),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () => Navigator.pushNamed(context, 'search'),
          ),
        ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity > 0) {
            _scaffoldKey.currentState.openDrawer();
          }
        },
        onTap: () {
          _scaffoldKey.currentState.openDrawer();
        },
        child: PostsView(
          posts: SaveMeCubit.get(context).posts,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              color: Theme.of(context).canvasColor,
            ),
            Text(
              "Report",
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).canvasColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Icons.camera_alt_rounded,