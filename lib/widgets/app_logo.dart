import 'package:flutter/material.dart';

Widget logoRichText({
  @required TextStyle textStyle1,
  @required TextStyle textStyle2,
}) =>
    RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "save",
            style: textStyle1,
          ),
          TextSpan(
            text: "Me",
            style: textStyle2,
          ),
        ],
      ),
    );
