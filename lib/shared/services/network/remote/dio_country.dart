import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioCountryHelper {
  static final DioCountryHelper instance = DioCountryHelper._instance();
  DioCountryHelper._instance();
  static Dio _dio;

  Dio get dio {
    if (_dio == null) _dio = _initialDio();
    return _dio;
  }

  Dio _initialDio() {
    Dio dio = Dio(BaseOptions(
        baseUrl: 'https://restcountries.eu/',
        receiveDataWhenStatusError: true));
    return dio;
  }

  Future<Response> getData({@required String url, Map<String, dynamic> query}) async {
    Dio dio = this.dio;
    return await dio.get(
      url,
      queryParameters:query,
    ).catchError((error) {
      print(error.toString());
    });
  }
}

// DioCountryHelper.instance.getData(url: 'api/missing_kids/').then((value) {
//                       print(value.data);
//                     });
