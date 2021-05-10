import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_conditional_rendering/conditional.dart';
import '../../modules/save_me/repositories/user_repository.dart';
import '../auth/sign_in/sign_in.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../config/themes/colors.dart';

class OnboardingScreen extends StatefulWidget {
  final UserRepository _userRepository;
  OnboardingScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

const List<List<String>> sentences = [
  [
    "What happens when a child is ",
    "frightened ",
    "and ",
    "alone?",
  ],
  [
    "Would you ",
    "care?",
  ],
  [
    "More than 50,000 children need care and protection.",
  ],
  [
    "They need a ",
    "foster carer.",
  ],
  [
    "save",
    "Me",
  ],
];

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController boarderController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Conditional.single(
                context: context,
                conditionBuilder: (context) => isLastPage,
                widgetBuilder: (context) => Container(),
                fallbackBuilder: (context) => GestureDetector(
                  child: Text(
                    "skip".toUpperCase(),
                    style: Theme.of(context).textTheme.button,
                  ),
                  onTap: () {
                    setState(() {
                      boarderController.jumpToPage(sentences.length - 1);
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: PageView.builder(
                controller: boarderController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int currentPage) => Center(
                  child: RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.headline2,
                        children: [
                          for (int i = 0;
                              i < sentences[currentPage].length;
                              i++)
                            TextSpan(
                              text: sentences[currentPage][i],
                              style: TextStyle(
                                color: i % 2 == 0 ? GRAY_CHATEAU : ABBEY,
                              ),
                            ),
                        ]),
                  ),
                ),
                itemCount: sentences.length,
                onPageChanged: (int currentPage) {
                  setState(() {
                    isLastPage = currentPage == sentences.length - 1;
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Conditional.single(
                context: context,
                conditionBuilder: (context) => isLastPage,
                widgetBuilder: (context) => Center(
                  child: GestureDetector(
                    child: Text(
                      "let's go!".toUpperCase(),
                      style: Theme.of(context).textTheme.button,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(
                            userRepository: widget._userRepository,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                fallbackBuilder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: boarderController,
                      count: sentences.length,
                      effect: ExpandingDotsEffect(
                        dotColor: GRAY_CHATEAU,
                        activeDotColor: Theme.of(context).primaryColor,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        boarderController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      },
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
