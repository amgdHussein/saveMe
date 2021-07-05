part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchChange extends SearchEvent {
  final String search;

  SearchChange({this.search});

  @override
  List<Object> get props => [search];

  @override
  String toString() => 'SearchChange(search: $search)';
}

class FilterMissingChange extends SearchEvent {
  final bool isMissing;

  FilterMissingChange({this.isMissing});

  @override
  List<Object> get props => [isMissing];

  @override
  String toString() => 'FilterMissingChange(isMissing: $isMissing)';
}

class FilterFindingChange extends SearchEvent {
  final bool isFinding;

  FilterFindingChange({this.isFinding});

  @override
  List<Object> get props => [isFinding];

  @override
  String toString() => 'FilterFindingChange(isFinding: $isFinding)';
}

class FilterFemaleChange extends SearchEvent {
  final bool isFemale;

  FilterFemaleChange({this.isFemale});

  @override
  List<Object> get props => [isFemale];

  @override
  String toString() => 'FilterFemaleChange(isFemale: $isFemale)';
}

class FilterMaleChange extends SearchEvent {
  final bool isMale;

  FilterMaleChange({this.isMale});

  @override
  List<Object> get props => [isMale];

  @override
  String toString() => 'FilterMaleChange(isMale: $isMale)';
}

class FilterToddlerChange extends SearchEvent {
  final bool isToddler;

  FilterToddlerChange({this.isToddler});

  @override
  List<Object> get props => [isToddler];

  @override
  String toString() => 'FilterToddlerChange(isToddler: $isToddler)';
}

class FilterChildChange extends SearchEvent {
  final bool isChild;

  FilterChildChange({this.isChild});

  @override
  List<Object> get props => [isChild];

  @override
  String toString() => 'FilterChildChange(isChild: $isChild)';
}

class FilterTeenagerChange extends SearchEvent {
  final bool isTeenager;

  FilterTeenagerChange({this.isTeenager});

  @override
  List<Object> get props => [isTeenager];

  @override
  String toString() => 'FilterTeenagerChange(isTeenager: $isTeenager)';
}

class FilterAdultChange extends SearchEvent {
  final bool isAdult;

  FilterAdultChange({this.isAdult});

  @override
  List<Object> get props => [isAdult];

  @override
  String toString() => 'FilterAdultChange(isAdult: $isAdult)';
}

class FilterElderlyChange extends SearchEvent {
  final bool isElderly;

  FilterElderlyChange({this.isElderly});

  @override
  List<Object> get props => [isElderly];

  @override
  String toString() => 'FilterElderlyChange(isElderly: $isElderly)';
}
