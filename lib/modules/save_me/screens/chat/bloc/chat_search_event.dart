part of 'chat_search_bloc.dart';

abstract class ChatSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchChange extends ChatSearchEvent {
  final String search;

  SearchChange({this.search});

  @override
  List<Object> get props => [search];

  @override
  String toString() => 'SearchChange(search: $search)';
}
