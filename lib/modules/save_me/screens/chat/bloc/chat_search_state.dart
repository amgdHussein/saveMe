part of 'chat_search_bloc.dart';

class ChatSearchState {
  final String search;
  ChatSearchState({@required this.search});

  factory ChatSearchState.initial() {
    return ChatSearchState(search: '');
  }

  factory ChatSearchState.change(String search) {
    return ChatSearchState(search: search);
  }
  ChatSearchState update({String search}) {
    return copyWith(search: search);
  }

  ChatSearchState copyWith({String search}) {
    return ChatSearchState(search: search ?? this.search);
  }

  @override
  String toString() => 'ChatSearchState(search: $search)';
}
