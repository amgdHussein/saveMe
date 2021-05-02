import 'package:flutter/cupertino.dart';

class Post {
  final String location;
  final String details;
  final DateTime date;
  final String imagePath;
  final String email;
  final String name;

  Post({@required this.imagePath, @required this.name, this.location, this.details, this.date, this.email});
}