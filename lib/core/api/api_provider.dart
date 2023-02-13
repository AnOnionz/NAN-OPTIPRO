import 'dart:io';

import 'package:dio/dio.dart';
import '../../core/platform/package_info.dart';

abstract class ApiProvider {

  //static const String apiBaseUrl = 'https://vc.imark.vn/';
  static const String apiBaseUrl = 'https://api-nan.imark.vn/';
  // static const String apiBaseUrl = 'https://3bc9-118-69-69-94.ngrok.io/';

  // static const String apiBaseUrl = 'https://gotit.imark.vn/';
  static const String apiPath = '';

  static final _dio = Dio(

    BaseOptions(
      baseUrl: '$apiBaseUrl$apiPath',
      connectTimeout: 60000,
      receiveTimeout: 60000,
      responseType: ResponseType.json,
      validateStatus: (status) => true,
      receiveDataWhenStatusError: true,
    )..headers.addAll({'device-type': 'app', 'x-package-version' : MyPackageInfo.version, 'x-package-platform': 'web'}),
  );

  static String getToken (){
    return _dio.options.headers['Authorization'];

  }

  void setBearerAuth({required String token}) {
    _dio.options.contentType = 'application/x-www-form-urlencoded';
    _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
  }

  static void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  static void setValidateStatus(ValidateStatus validateStatus) {
    _dio.options.validateStatus = validateStatus;
  }

  static void setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  static void setFormData() {
    _dio.options.contentType = Headers.formUrlEncodedContentType;
  }

  final Dio httpClient;

  ApiProvider() : httpClient = _dio {
    if (_dio.interceptors.isEmpty) {
      _dio.interceptors.add(
          LogInterceptor(error: true, requestBody: true, responseBody: true));
    }
  }
}
