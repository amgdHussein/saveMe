part of 'search_bloc.dart';

class SearchState {
  final String search;
  final bool isMissing;
  final bool isFinding;
  final bool isFemale;
  final bool isMale;
  final bool isToddler;
  final bool isChild;
  final bool isTeenager;
  final bool isAdult;
  final bool isElderly;

  SearchState({
    @required this.search,
    @required this.isMissing,
    @required this.isFinding,
    @required this.isFemale,
    @required this.isMale,
    @required this.isToddler,
    @required this.isChild,
    @required this.isTeenager,
    @required this.isAdult,
    @required this.isElderly,
  });

  bool get isPopulated =>
      this.isMissing ||
      this.isFinding ||
      this.isFemale ||
      this.isMale ||
      this.isToddler ||
      this.isChild ||
      this.isTeenager ||
      this.isAdult ||
      this.isElderly;

  factory SearchState.initial() {
    return SearchState(
      search: '',
      isMissing: true,
      isFinding: false,
      isFemale: false,
      isMale: true,
      isToddler: false,
      isChild: false,
      isTeenager: false,
      isAdult: false,
      isElderly: false,
    );
  }

  factory SearchState.change(
    String search,
    bool isMissing,
    bool isFinding,
    bool isFemale,
    bool isMale,
    bool isToddler,
    bool isChild,
    bool isTeenager,
    bool isAdult,
    bool isElderly,
  ) {
    return SearchState(
      search: search,
      isMissing: isMissing,
      isFinding: isFinding,
      isFemale: isFemale,
      isMale: isMale,
      isToddler: isToddler,
      isChild: isChild,
      isTeenager: isTeenager,
      isAdult: isAdult,
      isElderly: isElderly,
    );
  }
  SearchState update({
    String search,
    bool isMissing,
    bool isFinding,
    bool isFemale,
    bool isMale,
    bool isToddler,
    bool isChild,
    bool isTeenager,
    bool isAdult,
    bool isElderly,
  }) {
    return copyWith(
      search: search,
      isMissing: isMissing,
      isFinding: isFinding,
      isFemale: isFemale,
      isMale: isMale,
      isToddler: isToddler,
      isChild: isChild,
      isTeenager: isTeenager,
      isAdult: isAdult,
      isElderly: isElderly,
    );
  }

  SearchState copyWith({
    String search,
    bool isMissing,
    bool isFinding,
    bool isFemale,
    bool isMale,
    bool isToddler,
    bool isChild,
    bool isTeenager,
    bool isAdult,
    bool isElderly,
  }) {
    return SearchState(
      search: search ?? this.search,
      isMissing: isMissing ?? this.isMissing,
      isFinding: isFinding ?? this.isFinding,
      isFemale: isFemale ?? this.isFemale,
      isMale: isMale ?? this.isMale,
      isToddler: isToddler ?? this.isToddler,
      isChild: isChild ?? this.isChild,
      isTeenager: isTeenager ?? this.isTeenager,
      isAdult: isAdult ?? this.isAdult,
      isElderly: isElderly ?? this.isElderly,
    );
  }

  @override
  String toString() {
    return 'SearchState(search: $search, isMissing: $isMissing, isFinding: $isFinding, isFemale: $isFemale, isMale: $isMale, isToddler: $isToddler, isChild: $isChild, isTeenager: $isTeenager, isAdult: $isAdult, isElderly: $isElderly)';
  }
}
