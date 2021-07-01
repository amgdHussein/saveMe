import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Governorate {
  final String id;
  final String governorateNameArabic;
  final String governorateNameEnglish;

  Governorate({
    @required this.id,
    @required this.governorateNameArabic,
    @required this.governorateNameEnglish,
  });

  @override
  String toString() => governorateNameEnglish;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'governorate_ar': governorateNameArabic,
      'governorate_en': governorateNameEnglish,
    };
  }

  factory Governorate.fromMap(Map<String, dynamic> map) {
    return Governorate(
      id: map['id'],
      governorateNameArabic: map['governorate_ar'],
      governorateNameEnglish: map['governorate_en'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Governorate.fromJson(String source) =>
      Governorate.fromMap(json.decode(source));

  static List<Governorate> fromJsonTable(String source) {
    Map<String, dynamic> map = json.decode(source);
    return List<Governorate>.from(
      map['data']?.map((x) => Governorate.fromMap(x)),
    );
  }
}
