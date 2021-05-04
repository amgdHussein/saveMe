import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_me/layout/app_layout.dart';
import 'package:save_me/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<RichText> text = [
    RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        children: [
          TextSpan(
            text: "What happens when a child is ",
            style: TextStyle(color: GRAY_CHATEAU),
          ),
          TextSpan(text: "frightened ", style: TextStyle(color: GHARADE)),
          TextSpan(text: "and ", style: TextStyle(color: GRAY_CHATEAU)),
          TextSpan(text: "alone?", style: TextStyle(color: GHARADE)),
        ],
      ),
    ),
    RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        children: [
          TextSpan(text: "Would you ", style: TextStyle(color: GRAY_CHATEAU)),
          TextSpan(text: "care?", style: TextStyle(color: GHARADE)),
        ],
      ),
    ),
    RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        children: [
          TextSpan(
            text: "More than 50,000 children need care and protection.",
            style: TextStyle(color: GRAY_CHATEAU),
          ),
        ],
      ),
    ),
    RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        children: [
          TextSpan(text: "They need a ", style: TextStyle(color: GRAY_CHATEAU)),
          TextSpan(text: "foster carer.", style: TextStyle(color: GHARADE)),
        ],
      ),
    ),
    RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900),
        children: [
          TextSpan(text: "save", style: TextStyle(color: GRAY_CHATEAU)),
          TextSpan(text: "Me", style: TextStyle(color: GHARADE)),
        ],
      ),
    ),
  ];
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
              child: GestureDetector(
                onTap: (){
                  isLastPage = true;
                  boarderController.jumpToPage(text.length-1);
                },
                child: Text(
                  "skip".toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: PageView.builder(
                controller: boarderController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => Center(
                  child: text[index],
                ),
                itemCount: text.length,
                onPageChanged: (int index) {
                  isLastPage = index == text.length - 1;
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: boarderController,
                    count: text.length,
                    effect: ExpandingDotsEffect(
                      dotColor: GRAY_CHATEAU,
                      activeDotColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if(isLastPage){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppLayout()));
                      } else {
                        boarderController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
