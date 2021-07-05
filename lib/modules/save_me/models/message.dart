import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Message {
  final String content;
  final DateTime date;
  final String sid;
  final String rid;
  final String mid;

  Message({
    @required this.content,
    @required this.date,
    @required this.sid,
    @required this.rid,
    this.mid,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'date': date.millisecondsSinceEpoch,
      'mid': mid,
      'sid': sid,
      'rid': rid,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['content'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      sid: map['sid'],
      rid: map['rid'],
      mid: map['mid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  Message copyWith({
    String content,
    DateTime date,
    String sid,
    String rid,
    String mid,
  }) {
    return Message(
      content: content ?? this.content,
      date: date ?? this.date,
      sid: sid ?? this.sid,
      rid: rid ?? this.rid,
      mid: mid ?? this.mid,
    );
  }
}
