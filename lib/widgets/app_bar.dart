import 'package:flutter/material.dart';
import 'app_logo.dart';

AppBar appBar(
  context, {
  @required bool isAppTitle,
  bool disableBack = false,
  String title,
}) =>
    AppBar(
      automaticallyImplyLeading: !disableBack,
      leadingWidth: 30,
      title: isAppTitle
          ? logoRichText(
              textStyle1: Theme.of(context).appBarTheme.textTheme.headline1,
              textStyle2: Theme.of(context).appBarTheme.textTheme.headline2,
            )
          : Text(title),
    );

// icon: Icon(Icons.search_rounded),