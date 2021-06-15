import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../utils/services/face_recognition_api.dart';

class FaceRecognitionRepository {
  final FaceRecognitionDio _faceRecogInstance = FaceRecognitionDio.instance;

  Future<String> addImage(
      {@required String pid, @required String imagePath}) async {
    Response response = await _faceRecogInstance.uploadImage(
      pid: pid,
      imagePath: imagePath,
    );

    if (response.data.containsKey('error')) return response.data['error'];
    return response.data['link'];
  }

  Future<String> deleteImage({@required String pid}) async {
    Response response = await _faceRecogInstance.deleteImage(pid: pid);
    if (response.data.containsKey('error')) return response.data['error'];
    return response.data['deleted'];
  }

  Future<String> updateImage(
      {@required String pid, @required String imagePath}) async {
    return addImage(pid: pid, imagePath: imagePath);
  }

  Future<dynamic> recognizeImage({@required File imageFile}) async {
    Response response =
        await _faceRecogInstance.recognizeImage(imagePath: imageFile.path);

    if (response.data.containsKey('error')) return response.data['error'];
    return response.data['pids'];
  }
}
