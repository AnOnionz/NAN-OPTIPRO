import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flinq/flinq.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:nan_aptipro_sampling_2023/core/entity/outlet.dart';
import 'package:nan_aptipro_sampling_2023/core/errors/app_exceptions.dart';
import 'package:path/path.dart';
import '../../core/entity/user.dart';
import '../../core/services/base_api_provider.dart';
import '../../core/services/dio_client.dart';
import '../api/api_provider.dart';
import '../entity/filter.dart';

abstract class RemoteDataSource extends BaseApiProvider {
  final int projectId = 2;
  Future<String> login(
      {required String userName,
      required String passWord,
      required String deviceId});
  Future<User> getProfile({required String accessToken});
  Future<bool> logout();
  Future<bool> changePassword(
      {required String oldPass, required String newPass});
  Future<List<OutletEntity>> fetchOutlets({required Filter filter});
  Future<OutletEntity> fetchOutlet({required int id});
  Future<bool> checkPhone({required String phone});
  Future<bool> checkOTP({required String otp});
  Future<bool> uploadData(
      {required int outletId,
      DateTime? date,
      required String name,
      required String phone,
      required String otp,
      required List<Uint8List> images});
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final DioClient client;
  final successCode = 200;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<String> login(
      {required String userName,
      required String passWord,
      required String deviceId}) async {
    Map<String, dynamic> _requestBody = {
      'username': userName,
      'password': passWord,
    };
    debugPrint("Login Request: $_requestBody");
    final _resp = await client.post(path: 'auth/login', data: _requestBody);
    return _resp['accessToken'];
  }

  @override
  Future<bool> logout() async {
    // await client.post(path: 'auth/revoke');
    return true;
  }

  @override
  Future<bool> changePassword(
      {required String oldPass, required String newPass}) async {
    final _data = {'oldPassword': oldPass, 'newPassword': newPass};
    await client.post(path: 'users/change-password', data: _data);
    return true;
  }

  @override
  Future<User> getProfile({required String accessToken}) async {
    final _resp = await client.get(path: 'users/me');
    return User.fromJson(
        (_resp as Map<String, dynamic>)..addAll({'token': accessToken}));
  }

  @override
  Future<List<OutletEntity>> fetchOutlets({required Filter filter}) async {
    final _data = {
      'skip': filter.skip,
      'take': filter.take,
      'code': filter.outletCode
    };
    final resp = await client.get(path: 'outlets', data: _data);
    return (resp['entities'] as List).mapList((e) => OutletEntity.fromJson(e));
  }

  @override
  Future<bool> uploadData(
      {required int outletId,
      DateTime? date,
      required String name,
      required String phone,
      required String otp,
      required List<Uint8List> images}) async {


    // final url = ApiProvider.apiBaseUrl + 'customers';
    // final request = http.MultipartRequest('POST', Uri.parse(url));
    // request
    //   ..fields['phone'] = phone
    //   ..fields['name'] = name
    //   ..fields['otp'] = otp
    //   ..fields['outletId'] = outletId.toString();
    //
    // for (Uint8List image in images) {
    //   request.files.add(http.MultipartFile.fromBytes(
    //     'files',
    //     image,
    //     filename: outletId.toString() +
    //         (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString() +
    //         '.jpg',
    //   ));
    // }
    // print(request.files);
    // print(request.fields);
    // request.headers.addAll({'Authorization': ApiProvider.getToken()});
    // final response = await request.send();
    // final responseBody = await response.stream.bytesToString();
    // print('RESPONSE BODY: $responseBody');
    // String? message;
    // switch (response.statusCode) {
    //   case 200:
    //   case 201:
    //     return true;
    //   case 400:
    //     throw (BadRequestException(
    //       message: message ?? 'Vui lòng thử lại sau (400)',
    //     ));
    //   case 401:
    //   case 403:
    //     throw (UnAuthorizedException(message: ''));
    //   case 500:
    //   default:
    //     throw (InternalException(
    //       message: message ?? 'Vui lòng thử lại sau(${response.statusCode})',
    //     ));
    // }
    FormData _data = FormData.fromMap({
      'phone': phone,
      'name': name,
      'outletId': outletId,
      'otp': otp,
      'files': images.mapList(
        (image) => MultipartFile.fromBytes(
          image,
          contentType: MediaType('image', 'JPG'),
          filename: outletId.toString() +
              (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString() +'.JPG'
        ),
      ),
    });

    // for (Uint8List image in images) {
    //   final MultipartFile file = MultipartFile.fromBytes(image,
    //       filename: outletId.toString() +
    //           (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString());
    //   MapEntry<String, MultipartFile> imageEntry =
    //       MapEntry("files[${images.indexOf(image)}]", file);
    //   _data.files.add(imageEntry);
    // }

    print(_data.files);
    print(_data.fields);

    await client.post(path: 'customers', data: _data);
    return true;
  }

  @override
  Future<OutletEntity> fetchOutlet({required int id}) async {
    final resp = await client.get(path: 'outlets/$id');
    return OutletEntity.fromJson(resp);
  }

  @override
  Future<bool> checkOTP({required String otp}) async {
    await client.post(path: 'customers/check-otp', data: {'otp': otp});
    return true;
  }

  @override
  Future<bool> checkPhone({required String phone}) async {
    await client.post(path: 'customers/check-phone', data: {'phone': phone});
    return true;
  }
}
