import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../config/themes/colors.dart';
import '../../models/address/location.dart';
import '../../models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repositories/post_repository.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ReportScreen extends StatelessWidget {
  final PageController boarderController = PageController();
  PostRepository _postRepo = PostRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SmoothPageIndicator(
                controller: boarderController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotColor: GRAY_CHATEAU,
                  activeDotColor: Theme.of(context).primaryColor,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: PageView.builder(
                controller: boarderController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int currentPage) => Center(
                  child: Container(
                    color: Colors.redAccent,
                  ),
                ),
                itemCount: 3,
                onPageChanged: (int currentPage) {},
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      // boarderController.nextPage(
                      //   duration: Duration(milliseconds: 750),
                      //   curve: Curves.fastLinearToSlowEaseIn,
                      // );

                      Missing m = Missing(
                        uid: 'sdflk',
                        pid: null,
                        uploadDate: DateTime.now(),
                        sex: 'female',
                        image:
                            'https://images.unsplash.com/photo-1623097222667-870c6e670458?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
                        description: 'hfffhhhhh',
                        location:
                            PostLocation(city: 'cairo', governorate: 'madinty'),
                        name: 'mona',
                        age: 21,
                        missingFrom: DateTime.now(),
                      );

                      Finding f = Finding(
                        uid: 'sdflk',
                        pid: null,
                        uploadDate: DateTime.now(),
                        sex: 'female',
                        image:
                            'https://images.unsplash.com/photo-1623432532623-f8f1347d954c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
                        description: 'hfffhhhhh',
                        location:
                            PostLocation(city: 'giza', governorate: 'haram'),
                        name: 'hanaa',
                        age: 9,
                      );

                      await _postRepo.addPost(m);
                      await _postRepo.addPost(f);
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
