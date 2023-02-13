import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/api/api_provider.dart';

import '../errors/app_exceptions.dart';

class DioClient extends ApiProvider {

   static const int timeOutDuration = 60;
  //GET
  Future<dynamic> get(
      {required String path, Map<String, dynamic>? data}) async {
    var uri = Uri.parse(ApiProvider.apiBaseUrl + ApiProvider.apiPath + path);
    try {
      var response = await httpClient
          .get(path, queryParameters: data)
          .timeout(const Duration(seconds: timeOutDuration));

      if (response.statusCode == null) {
        throw ApiNotRespondingException(
            message: 'Vui lòng thử lại sau', url: uri.toString());
      }
      return _processResponse(response);
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.error.runtimeType == SocketException||
          e.error.runtimeType == HttpException) {
        throw InternetException(
            message: 'Vui lòng kiểm tra kết nối mạng và thử lại',
            url: uri.toString());
      }
    } on TimeoutException{
      throw ApiNotRespondingException(
          message: 'Vui lòng thử lại sau', url: uri.toString());
    }
  }

  //GET UPDATE
  Future<dynamic> getUpdate(
      {required String path, Map<String, dynamic>? data}) async {
    var uri = Uri.parse(ApiProvider.apiBaseUrl +'/'+ path);
    try {
      var response = await httpClient
          .get(uri.toString(), queryParameters: data)
          .timeout(const Duration(seconds: timeOutDuration));

      if (response.statusCode == null) {
        throw ApiNotRespondingException(
            message: 'Vui lòng thử lại sau', url: uri.toString());
      }
      return _processResponse(response);
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.error.runtimeType == SocketException||
          e.error.runtimeType == HttpException) {
        throw InternetException(
            message: 'Vui lòng kiểm tra kết nối mạng và thử lại',
            url: uri.toString());
      }
    } on TimeoutException{
      throw ApiNotRespondingException(
          message: 'Vui lòng thử lại sau', url: uri.toString());
    }
  }

  //POST
  Future<dynamic> post(
      {required String path,
      data,
      Map<String, dynamic>? queryParameters}) async {
    var uri = Uri.parse(ApiProvider.apiBaseUrl + ApiProvider.apiPath + path);
    try {
      var response = await httpClient
          .post(path, data: data, queryParameters: queryParameters)
          .timeout(const Duration(seconds: timeOutDuration));
      if (response.statusCode == null) {
        throw ApiNotRespondingException(
            message: 'Vui lòng thử lại sau', url: uri.toString());
      }
      return _processResponse(response);
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.error.runtimeType == SocketException ||
          e.error.runtimeType == HttpException) {
        throw InternetException(
            message: 'Vui lòng kiểm tra kết nối mạng và thử lại',
            url: uri.toString());
      }
    } on TimeoutException {
      throw ApiNotRespondingException(
          message: 'Vui lòng thử lại sau', url: uri.toString());
    }
  }

  //DELETE
  //PUT
  Future<dynamic> put(
      {required String path,
      data,
      Map<String, dynamic>? queryParameters}) async {
    var uri = Uri.parse(ApiProvider.apiBaseUrl + ApiProvider.apiPath + path);
    try {
      var response = await httpClient
          .put(path, data: data, queryParameters: queryParameters)
          .timeout(const Duration(seconds: timeOutDuration));
      if (response.statusCode == null) {
        throw ApiNotRespondingException(
            message: 'Vui lòng thử lại sau', url: uri.toString());
      }
      return _processResponse(response);
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.error.runtimeType == SocketException||
          e.error.runtimeType == HttpException) {
        throw InternetException(
            message: 'Vui lòng kiểm tra kết nối mạng và thử lại',
            url: uri.toString());
      }
    } on TimeoutException {
      throw ApiNotRespondingException(
          message:'Vui lòng thử lại sau', url: uri.toString());
    }
  }

  dynamic _processResponse(Response response) {
    String? message;
    try{
      if(response.data != null && response.data is Map) {
        message = response.data['message'];
      }
    }catch(_){

    }
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        return response.data;
      case 400:
        throw BadRequestException(
          message: message ?? 'Vui lòng thử lại sau (400)',
          url: response.requestOptions.path.toString(),
        );
      case 401:
        throw UnAuthorizedException(
            message: message ?? 'Error code 401',
            url: response.requestOptions.path.toString());
      case 403:
        throw FetchDataException(
            message: message ?? 'Vui lòng thử lại sau(403)',
            url: response.requestOptions.path.toString());
      case 426:
        throw UpdateRequiredException(
            message: message ?? 'Phiên bản không còn khả dụng. Vui lòng cập nhật phiên bản mới',
            url: response.requestOptions.path.toString());
      case 500:
      default:
        throw InternalException(
            message: message ?? 'Vui lòng thử lại sau(${response.statusCode})',
            url: response.requestOptions.path.toString());
    }
  }
}
