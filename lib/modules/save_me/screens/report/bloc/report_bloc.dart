import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_me/modules/save_me/models/address/city.dart';
import 'package:save_me/modules/save_me/models/address/governorate.dart';
import 'package:save_me/modules/save_me/repositories/face_recognition_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  FaceRecognitionRepository _faceRecognitionRepository =
      FaceRecognitionRepository();
  ReportBloc() : super(ReportState.initial());

  Future<String> loadAsset(BuildContext context, String path) async {
    return await DefaultAssetBundle.of(context).loadString(path);
  }

  Future<List<Governorate>> governorates(BuildContext context) async {
    return Governorate.fromJsonTable(
      await this.loadAsset(
        context,
        'assets/egypt_gove/governorates.json',
      ),
    );
  }

  Future<List<City>> governorateCities(
      BuildContext context, String governorateId) async {
    List<City> cities = City.fromJsonTable(
      await this.loadAsset(
        context,
        'assets/egypt_gove/cities.json',
      ),
    );
    return cities
        .where((element) => element.governorateId == governorateId)
        .toList();
  }

  @override
  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    if (event is ReportPageChange)
      yield* _mapReportPageChangeToState(event.page);
    if (event is ReportTypeChange)
      yield* _mapReportTypeChangeToState(event.type);
    else if (event is ReportNameChange)
      yield* _mapReportNameChangeToState(event.name);
    else if (event is ReportAgeChange)
      yield* _mapReportAgeChangeToState(event.age);
    else if (event is ReportGenderChange)
      yield* _mapReportGenderChangeToState(event.gender);
    else if (event is ReportDateChange)
      yield* _mapReportMissingDateChangeToState(event.date);
    else if (event is ReportImageChange)
      yield* _mapReportImageChangeToState(event.image);
    else if (event is ReportDescriptionChange)
      yield* _mapReportDescriptionChangeToState(event.description);
    else if (event is ReportGovernorateChange) {
      yield* _mapReportGovernorateChangeToState(event.governorate);
    } else if (event is ReportCityChange)
      yield* _mapReportCityChangeToState(event.city);
    else if (event is ReportSubmitted)
      yield* _mapReportSubmittedToState(
        name: event.name,
        type: event.type,
        age: event.age,
        gender: event.gender,
        missingDate: event.date,
        image: event.image,
        description: event.description,
        governorate: event.governorate,
        city: event.city,
      );
  }

  Stream<ReportState> _mapReportPageChangeToState(int page) async* {
    yield state.update(page: page);
  }

  Stream<ReportState> _mapReportTypeChangeToState(String type) async* {
    yield state.update(type: type);
  }

  Stream<ReportState> _mapReportNameChangeToState(String name) async* {
    yield state.update(name: name);
  }

  Stream<ReportState> _mapReportAgeChangeToState(int age) async* {
    yield state.update(age: age);
  }

  Stream<ReportState> _mapReportGenderChangeToState(String gender) async* {
    yield state.update(gender: gender);
  }

  Stream<ReportState> _mapReportMissingDateChangeToState(DateTime date) async* {
    yield state.update(date: date);
  }

  Stream<ReportState> _mapReportImageChangeToState(String image) async* {
    yield ReportStateLoading();
    dynamic response = await _faceRecognitionRepository.isValidImage(
      imageFile: File(image),
    );
    if (response == true)
      yield state.update(image: image);
    else {
      yield ReportStateFailure(error: response);
      yield state.update(image: null);
    }
  }

  Stream<ReportState> _mapReportDescriptionChangeToState(
      String description) async* {
    yield state.update(description: description);
  }

  Stream<ReportState> _mapReportGovernorateChangeToState(
      String governorate) async* {
    yield state.update(governorate: governorate);
  }

  Stream<ReportState> _mapReportCityChangeToState(String city) async* {
    yield state.update(city: city);
  }

  Stream<ReportState> _mapReportSubmittedToState({
    @required String name,
    @required String type,
    @required int age,
    @required String gender,
    @required DateTime missingDate,
    @required String image,
    @required String description,
    @required String governorate,
    @required String city,
  }) async* {
    yield ReportStateLoading();

    try {
      // append post

      yield ReportStateSuccess();
    } catch (error) {
      yield ReportStateFailure(error: 'kj');
      print(error.toString());
    }
  }
}
