import 'package:flutter/material.dart';

class ChatTheme {
  ChatTheme._();

  static final TextStyle heading2 = TextStyle(
    color: Color(0xff686795),
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static final TextStyle chatSenderName = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );

  static final TextStyle bodyText1 = TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 14,
    letterSpacing: 1.2,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle bodyTextMessage = TextStyle(
    fontSize: 13,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle bodyTextTime = TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
}
