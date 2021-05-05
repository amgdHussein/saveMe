import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:save_me/shared/constants/onboarding_page_sentences.dart';
import 'package:save_me/shared/styles/colors.dart';

import 'package:save_me/layout/app_layout.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController boarderController = PageController();
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
                widgetBuilder: (context) => Text(
                  "done".toUpperCase(),
                  style: Theme.of(context).textTheme.button.copyWith(color: GRAY_CHATEAU),
                ),
                fallbackBuilder: (context) => GestureDetector(
                  child: Text("skip".toUpperCase(), style: Theme.of(context).textTheme.button,),
                  onTap: () {
                    setState(() {
                      boarderController.jumpToPage(pageSentences.length - 1);
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
                      style: Theme.of(context).textTheme.headline1,
                      children: [
                        for (
                          int currentSentence = 0; 
                          currentSentence < pageSentences[currentPage].sentences.length; 
                          currentSentence++
                        ) TextSpan(
                            text: pageSentences[currentPage].sentences[currentSentence],
                            style: TextStyle(color: pageSentences[currentPage].colors[currentSentence]),
                          ),
                      ],
                    ),
                  ),                  
                ),
                itemCount: pageSentences.length,
                onPageChanged: (int currentPage) {
                  setState(() {
                    isLastPage = currentPage == pageSentences.length - 1;
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppLayout()));
                    },
                  ),
                ),
                fallbackBuilder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: boarderController,
                      count: pageSentences.length,
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
