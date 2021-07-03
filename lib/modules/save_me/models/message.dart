import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Message {
  final String content;
  final DateTime date;
  final String image;
  final bool isLast;
  final String reciverId;
  final String senderId;
  final String mid;

  Message({
    @required this.content,
    @required this.date,
    @required this.image,
    @required this.isLast,
    @required this.reciverId,
    @required this.senderId,
    this.mid,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'date': date.millisecondsSinceEpoch,
      'image': image,
      'isLast': isLast,
      'reciverId': reciverId,
      'senderId': senderId,
      'mid': mid,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['content'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      image: map['image'],
      isLast: map['isLast'],
      reciverId: map['reciverId'],
      senderId: map['senderId'],
      mid: map['mid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
