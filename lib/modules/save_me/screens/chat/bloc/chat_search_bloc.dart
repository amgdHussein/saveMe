import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_search_event.dart';
part 'chat_search_state.dart';

class ChatSearchBloc extends Bloc<ChatSearchEvent, ChatSearchState> {
  ChatSearchBloc() : super(ChatSearchState.initial());

  @override
  Stream<ChatSearchState> mapEventToState(ChatSearchEvent event) async* {
    if (event is SearchChange)
      yield* _mapSeachChangeToState(search: event.search);
  }

  Stream<ChatSearchState> _mapSeachChangeToState({String search}) async* {
    yield state.update(search: search);
  }
}
