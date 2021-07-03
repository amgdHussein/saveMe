import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'address/location.dart';

// enum PostType {missing, finding}

class Post {
  // basic info
  final String uid; // missing:*, found:*
  final String pid; // missing:*, found:*
  final DateTime uploadDate; // missing:*, found:*

  // personal info
  final String sex; // missing:*, found:*
  final String image; // missing:*, found:*
  final String description; // missing:*, found:*

  // missingin, foundin
  final PostLocation location;

  Post({
    @required this.uid,
    @required this.pid,
    @required this.uploadDate,
    @required this.sex,
    @required this.image,
    @required this.description,
    @required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'pid': pid,
      'uploadDate': uploadDate.millisecondsSinceEpoch,
      'sex': sex,
      'image': image,
      'description': description,
      'location': location.toMap(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      uid: map['uid'],
      pid: map['pid'],
      uploadDate: DateTime.fromMillisecondsSinceEpoch(map['uploadDate']),
      sex: map['sex'],
      image: map['image'],
      description: map['description'],
      location: PostLocation.fromMap(map['location']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}

class Missing extends Post {
  final String name;
  final int age;
  final DateTime missingFrom;
  Missing({
    @required String uid,
    @required String pid,
    @required DateTime uploadDate,
    @required String sex,
    @required String image,
    @required String description,
    @required PostLocation location,
    @required this.name,
    @required this.age,
    @required this.missingFrom,
  }) : super(
          uid: uid,
          pid: pid,
          uploadDate: uploadDate,
          sex: sex,
          image: image,
          description: description,
          location: location,
        );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'pid': pid,
      'uploadDate': uploadDate.millisecondsSinceEpoch,
      'name': name,
      'age': age,
      'sex': sex,
      'image': image,
      'description': description,
      'location': location.toMap(),
      'missingFrom': missingFrom.millisecondsSinceEpoch,
    };
  }

  factory Missing.fromMap(Map<String, dynamic> map) {
    return Missing(
      uid: map['uid'],
      pid: map['pid'],
      uploadDate: DateTime.fromMillisecondsSinceEpoch(map['uploadDate']),
      name: map['name'],
      age: map['age'],
      sex: map['sex'],
      image: map['image'],
      description: map['description'],
      location: PostLocation.fromMap(map['location']),
      missingFrom: DateTime.fromMillisecondsSinceEpoch(map['missingFrom']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Missing.fromJson(String source) =>
      Missing.fromMap(json.decode(source));
}

class Finding extends Post {
  String name;
  int age;
  Finding({
    @required String uid,
    @required String pid,
    @required DateTime uploadDate,
    @required String sex,
    @required String image,
    @required String description,
    @required PostLocation location,
    this.name,
    this.age,
  }) : super(
          uid: uid,
          pid: pid,
          uploadDate: uploadDate,
          sex: sex,
          image: image,
          description: description,
          location: location,
        );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'pid': pid,
      'uploadDate': uploadDate.millisecondsSinceEpoch,
      'name': name,
      'age': age,
      'sex': sex,
      'image': image,
      'description': description,
      'location': location.toMap(),
    };
  }

  factory Finding.fromMap(Map<String, dynamic> map) {
    return Finding(
      uid: map['uid'],
      pid: map['pid'],
      uploadDate: DateTime.fromMillisecondsSinceEpoch(map['uploadDate']),
      name: map['name'],
      age: map['age'],
      sex: map['sex'],
      image: map['image'],
      description: map['description'],
      location: PostLocation.fromMap(map['location']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Finding.fromJson(String source) => Finding.fromMap(json.decode(source));
}
