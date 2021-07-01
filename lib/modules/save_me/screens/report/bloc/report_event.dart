part of 'report_bloc.dart';

@immutable
abstract class ReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ReportGenderChange extends ReportEvent {
  final String gender;

  ReportGenderChange({this.gender});

  @override
  String toString() => 'ReportGenderChange(gender: $gender)';
}

class ReportNameChange extends ReportEvent {
  final String name;

  ReportNameChange({this.name});

  @override
  String toString() => 'ReportNameChange(name: $name)';
}

class ReportTypeChange extends ReportEvent {
  final String type;

  ReportTypeChange({this.type});

  @override
  String toString() => 'ReportTypeChange(type: $type)';
}

class ReportDescriptionChange extends ReportEvent {
  final String description;

  ReportDescriptionChange({this.description});

  @override
  String toString() => 'ReportDescriptionChange(description: $description)';
}

class ReportAgeChange extends ReportEvent {
  final int age;

  ReportAgeChange({this.age});

  @override
  String toString() => 'ReportAgeChange(age: $age)';
}

class ReportDateChange extends ReportEvent {
  final DateTime date;

  ReportDateChange({this.date});

  @override
  String toString() => 'ReportDateChange(date: $date)';
}

class ReportImageChange extends ReportEvent {
  final String image;

  ReportImageChange({this.image});

  @override
  String toString() => 'ReportImageChange(image: $image)';
}

class ReportGovernorateChange extends ReportEvent {
  final String governorate;

  ReportGovernorateChange({this.governorate});

  @override
  String toString() => 'ReportGovernorateChange(governorate: $governorate)';
}

class ReportCityChange extends ReportEvent {
  final String city;

  ReportCityChange({this.city});

  @override
  List<Object> get props => [city];

  @override
  String toString() => 'ReportCityChange(city: $city)';
}

class ReportPickerChange extends ReportEvent {
  final String picker;

  ReportPickerChange({this.picker});

  @override
  String toString() => 'ReportCityChange(picker: $picker)';
}

class ReportPageChange extends ReportEvent {
  final int page;

  ReportPageChange({this.page});

  @override
  String toString() => 'ReportCityChange(page: $page)';
}

class ReportError extends ReportEvent {
  final String error;

  ReportError({this.error});

  @override
  String toString() => 'ReportError(error: $error)';
}

class ReportSubmitted extends ReportEvent {
  final String name;
  final String type;
  final int age;
  final String gender;
  final DateTime date;
  final String image;
  final String description;
  final String governorate;
  final String city;

  ReportSubmitted({
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

  @override
  List<Object> get props =>
      [name, type, age, gender, date, image, description, governorate, city];

  @override
  String toString() =>
      'ReportSubmitted(name: $name, type: $type, age: $age, gender: $gender, date: $date, image: $image, description: $description, governorate: $governorate, city: $city)';
}
