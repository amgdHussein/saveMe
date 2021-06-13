import 'dart:convert';

import 'package:flutter/cupertino.dart';

class PostLocation {
  final String city;
  final String governorate;

  PostLocation({
    @required this.city,
    @required this.governorate,
  });

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'governorate': governorate,
    };
  }

  factory PostLocation.fromMap(Map<String, dynamic> map) {
    return PostLocation(
      city: map['city'],
      governorate: map['governorate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostLocation.fromJson(String source) =>
      PostLocation.fromMap(json.decode(source));
}
