import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthUser extends Equatable {
  final String name;
  final String email;
  final bool emailVerified;
  final bool isAnonymous;
  // metadata: UserMetadata(creationTime: 2021-05-09 20:22:57.485, lastSignInTime: 2021-05-10 17:24:12.403),
  final String phoneNumber;
  // : null;
  final String pic;
  final String uid;

  AuthUser({
    @required this.name,
    @required this.email,
    @required this.emailVerified,
    @required this.isAnonymous,
    @required this.phoneNumber,
    @required this.pic,
    @required this.uid,
  });

  @override
  List<Object> get props =>
      [name, email, emailVerified, isAnonymous, phoneNumber, pic, uid];

  @override
  String toString() =>
      'AuthUser(name: $name, email: $email, emailVerified: $emailVerified, isAnonymous: $isAnonymous, phoneNumber: $phoneNumber, pic: $pic, uid: $uid)';

  factory AuthUser.fromFirebaseUser(User user) {
    return AuthUser(
      name: user.displayName,
      email: user.email,
      emailVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,
      phoneNumber: user.phoneNumber,
      pic: user.photoURL,
      uid: user.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'emailVerified': emailVerified,
      'isAnonymous': isAnonymous,
      'phoneNumber': phoneNumber,
      'pic': pic,
      'uid': uid,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      name: map['name'],
      email: map['email'],
      emailVerified: map['emailVerified'],
      isAnonymous: map['isAnonymous'],
      phoneNumber: map['phoneNumber'],
      pic: map['pic'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) =>
      AuthUser.fromMap(json.decode(source));
}
