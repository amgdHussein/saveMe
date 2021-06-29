part of 'report_bloc.dart';

class ReportState {
  final int page;
  final String name;
  final String type;
  final int age;
  final String gender;
  final DateTime date;
  final String image;
  final String description;
  final String governorate;
  final String city;

  bool get isPopulated =>
      type != null &&
      age != null &&
      gender != null &&
      governorate != null &&
      city != null;

  ReportState({
    @required this.page,
    @required this.name,
    @required this.type,
    @required this.age,
    @required this.gender,
    @required this.date,
    @required this.image,
    @required this.description,
    @required this.governorate,
    @required this.city,
  });

  factory ReportState.initial() {
    return ReportState(
      page: 0,
      name: null,
      type: null,
      age: null,
      gender: null,
      date: null,
      image: null,
      description: null,
      governorate: null,
      city: null,
    );
  }

  ReportState update({
    int page,
    String name,
    String type,
    int age,
    String gender,
    DateTime date,
    String image,
    String description,
    String governorate,
    String city,
  }) {
    return copyWith(
      page: page,
      name: name,
      type: type,
      age: age,
      gender: gender,
      date: date,
      image: image,
      description: description,
      governorate: governorate,
      city: city,
    );
  }

  ReportState copyWith({
    int page,
    String name,
    String type,
    int age,
    String gender,
    DateTime date,
    String image,
    String description,
    String governorate,
    String city,
  }) {
    return ReportState(
      page: page ?? this.page,
      name: name ?? this.name,
      type: type ?? this.type,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      date: date ?? this.date,
      image: image ?? this.image,
      description: description ?? this.description,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
    );
  }

  @override
  String toString() {
    return 'ReportState(page: $page, name: $name, type: $type, age: $age, gender: $gender, date: $date, image: $image, description: $description, governorate: $governorate, city: $city)';
  }
}

class ReportStateSuccess extends ReportState {}

class ReportStateLoading extends ReportState {}

class ReportStateFailure extends ReportState {
  final String error;
  ReportStateFailure({@required this.error});
}
