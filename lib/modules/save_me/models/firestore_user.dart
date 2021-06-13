import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreUser extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final String image;
  final String uid;

  FirestoreUser({
    @required this.name,
    @required this.email,
    @required this.phoneNumber,
    @required this.image,
    @required this.uid,
  });

  @override
  List<Object> get props => [name, email, phoneNumber, image, uid];

  @override
  String toString() =>
      'FirestoreUser(name: $name, email: $email, phoneNumber: $phoneNumber, image: $image, uid: $uid)';

  factory FirestoreUser.fromFirebaseUser(User user) {
    return FirestoreUser(
      name: user.displayName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      image: user.photoURL,
      uid: user.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'image': image,
      'uid': uid,
    };
  }

  factory FirestoreUser.fromMap(Map<String, dynamic> map) {
    return FirestoreUser(
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      image: map['image'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FirestoreUser.fromJson(String source) =>
      FirestoreUser.fromMap(json.decode(source));
}
