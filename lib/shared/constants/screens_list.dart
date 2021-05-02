import 'package:flutter/cupertino.dart';

import 'package:save_me/screen/chat.dart';
import 'package:save_me/screen/home.dart';
import 'package:save_me/screen/profile.dart';
import 'package:save_me/screen/search.dart';
import 'package:save_me/screen/camera.dart';

final List<Widget> screens = [
  HomeScreen(),
  SearchScreen(),
  CameraScreen(),
  ChatScreen(),
  ProfileScreen(),
];
