import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../config/themes/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ReportScreen extends StatelessWidget {
  final PageController _boarderController = PageController();

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
                controller: _boarderController,
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
                controller: _boarderController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int currentPage) {
                  return Image.network(
                      'http://192.168.1.6:8080/api/database/retrieve/image/9nffh30nf.jpeg');
                },
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
                      _boarderController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
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

// Missing m = Missing(
//                         uid: FirebaseAuth.instance.currentUser.uid,
//                         pid: null,
//                         uploadDate: DateTime.now(),
//                         sex: 'female',
//                         image:
//                             'https://images.unsplash.com/photo-1623097222667-870c6e670458?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
//                         description:
//                             'If you change Display Name in the runner project it will stop working. It has to be ´Runner\' Apparently, it is necessary to change the name and version data on the pubspeck.yaml file only, which is quite incovenient if android and ios apps have different versions or name localization – Dpedrinha',
//                         location: PostLocation(
//                             city: 'New-cairo', governorate: 'Madinty'),
//                         name: 'mona',
//                         age: 21,
//                         missingFrom: DateTime.now(),
//                       );

//                       Finding f = Finding(
//                         uid: FirebaseAuth.instance.currentUser.uid,
//                         pid: null,
//                         uploadDate: DateTime.now(),
//                         sex: 'female',
//                         image:
//                             'https://images.unsplash.com/photo-1623432532623-f8f1347d954c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
//                         description:
//                             'This appears to be all sorts of broken with the latest IOS updates and/or Catalina updates and/or Flutter updates. I have no idea. Changing this now breaks the deployment as it renames the <appname>.app folder from a consistent Runner.app to whatever you put in display name, and then "flutter run" breaks. Now, if you want to change it, you name the name:<value> key in the YAML file, then do global search/replace on the package name. (sigh) – ChrisH Nov 12',
//                         location:
//                             PostLocation(city: 'Giza', governorate: 'Al-Haram'),
//                         name: 'hanaa',
//                         age: 9,
//                       );

//                       await _postRepo.addPost(m);
//                       await _postRepo.addPost(f);
