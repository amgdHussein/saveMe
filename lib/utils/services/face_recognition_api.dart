import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/api_path.dart';

class FaceRecognitionDio {
  static final FaceRecognitionDio instance = FaceRecognitionDio._instance();
  FaceRecognitionDio._instance();
  static Dio _dio;

  Dio get dio {
    if (_dio == null) _dio = _initialDio();
    return _dio;
  }

  Dio _initialDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: faceRecognitionUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    return dio;
  }

  // add, update imagec
  Future<Response> uploadImage(
      {@required String pid, @required String imagePath}) async {
    Dio dio = this.dio;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imagePath),
    });

    Response response = await dio.post(
      "/api/filesys/add/image/",
      data: formData,
      queryParameters: {
        "pid": pid,
      },
    );

    return response;
  }

  // delete image
  Future<Response> deleteImage({@required String pid}) async {
    Dio dio = this.dio;
    var response = await dio.delete("/api/filesys/delete/image/$pid");
    return response;
  }

  // searching
  Future<Response> recognizeImage({@required String imagePath}) async {
    Dio dio = this.dio;

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imagePath),
    });

    Response response = await dio.post(
      "/api/recognize/image/",
      data: formData,
    );

    return response;
  }

  // validate an image
  Future<Response> isValidImage({@required String imagePath}) async {
    Dio dio = this.dio;

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imagePath),
    });

    Response response = await dio.post(
      "/api/recognize/is_valid/image/",
      data: formData,
    );

    return response;
  }
}
