import 'dart:convert';

import 'package:flutter/cupertino.dart';

class City {
  final String id;
  final String governorateId;
  final String cityNameArabic;
  final String cityNameEnglish;

  City({
    @required this.id,
    @required this.governorateId,
    @required this.cityNameArabic,
    @required this.cityNameEnglish,
  });

  @override
  String toString() => cityNameEnglish;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'governorate_id': governorateId,
      'city_ar': cityNameArabic,
      'city_en': cityNameEnglish,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'],
      governorateId: map['governorate_id'],
      cityNameArabic: map['city_ar'],
      cityNameEnglish: map['city_en'],
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source));

  static List<City> fromJsonTable(String source) {
    Map<String, dynamic> map = json.decode(source);
    return List<City>.from(
      map['data']?.map((x) => City.fromMap(x)),
    );
  }
}
