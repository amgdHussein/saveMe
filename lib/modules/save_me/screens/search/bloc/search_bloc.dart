import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState.initial());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchChange)
      yield* _mapSeachChangeToState(search: event.search);
    else if (event is FilterMissingChange)
      yield* _mapFilterMissingChangeToState(isMissing: event.isMissing);
    else if (event is FilterFindingChange)
      yield* _mapFilterFindingChangeToState(isFinding: event.isFinding);
    else if (event is FilterFemaleChange)
      yield* _mapFilterFemaleChangeToState(isFemale: event.isFemale);
    else if (event is FilterMaleChange)
      yield* _mapFilterMaleChangeToState(isMale: event.isMale);
    else if (event is FilterToddlerChange)
      yield* _mapFilterToddlerChangeToState(isToddler: event.isToddler);
    else if (event is FilterChildChange)
      yield* _mapFilterChildChangeToState(isChild: event.isChild);
    else if (event is FilterTeenagerChange)
      yield* _mapFilterTeenagerChangeToState(isTeenager: event.isTeenager);
    else if (event is FilterAdultChange)
      yield* _mapFilterAdultChangeToState(isAdult: event.isAdult);
    else if (event is FilterElderlyChange)
      yield* _mapFilterElderlyChangeToState(isElderly: event.isElderly);
    else if (event is FilterImageChange)
      yield* _mapFilterImageChangeToState(
        image: event.image,
        isGallery: event.isGallery,
      );
  }

  Stream<SearchState> _mapSeachChangeToState({String search}) async* {
    yield state.update(search: search);
  }

  Stream<SearchState> _mapFilterMissingChangeToState({bool isMissing}) async* {
    yield state.update(isMissing: isMissing);
  }

  Stream<SearchState> _mapFilterFindingChangeToState({bool isFinding}) async* {
    yield state.update(isFinding: isFinding);
  }

  Stream<SearchState> _mapFilterFemaleChangeToState({bool isFemale}) async* {
    yield state.update(isFemale: isFemale);
  }

  Stream<SearchState> _mapFilterMaleChangeToState({bool isMale}) async* {
    yield state.update(isMale: isMale);
  }

  Stream<SearchState> _mapFilterToddlerChangeToState({bool isToddler}) async* {
    yield state.update(isToddler: isToddler);
  }

  Stream<SearchState> _mapFilterChildChangeToState({bool isChild}) async* {
    yield state.update(isChild: isChild);
  }

  Stream<SearchState> _mapFilterTeenagerChangeToState(
      {bool isTeenager}) async* {
    yield state.update(isTeenager: isTeenager);
  }

  Stream<SearchState> _mapFilterAdultChangeToState({bool isAdult}) async* {
    yield state.update(isAdult: isAdult);
  }

  Stream<SearchState> _mapFilterElderlyChangeToState({bool isElderly}) async* {
    yield state.update(isElderly: isElderly);
  }

  Stream<SearchState> _mapFilterImageChangeToState(
      {String image, bool isGallery}) async* {
    yield state.update(image: image, isGallery: isGallery);
  }
}
