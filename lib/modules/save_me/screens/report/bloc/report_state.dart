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
  final String picker;
  final String error;

  bool get isFailure => error != null;

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
    @required this.picker,
    @required this.error,
  });

  factory ReportState.initial() {
    return ReportState(
      page: 0,
      name: null,
      type: 'finding',
      age: 5,
      gender: 'male',
      date: null,
      image: null,
      description: null,
      governorate: null,
      city: null,
      picker: null,
      error: null,
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
    String error,
    String picker,
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
      picker: picker,
      error: error,
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
    String picker,
    String error,
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
      picker: picker ?? this.picker,
      error: error,
    );
  }

  @override
  String toString() {
    return 'ReportState(page: $page, name: $name, type: $type, age: $age, gender: $gender, date: $date, picker: $picker, image: $image, description: $description, governorate: $governorate, city: $city error: $error)';
  }
}

class ReportStateSuccess extends ReportState {}

class ReportStateLoading extends ReportState {
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
  final String picker;
  final String error;

  ReportStateLoading({
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
    @required this.picker,
    @required this.error,
  });

  factory ReportStateLoading.fromReportState(ReportState state) {
    return ReportStateLoading(
      page: state.page,
      name: state.name,
      type: state.type,
      age: state.age,
      gender: state.gender,
      date: state.date,
      image: state.image,
      description: state.description,
      governorate: state.governorate,
      city: state.city,
      picker: state.picker,
      error: state.error,
    );
  }
}
