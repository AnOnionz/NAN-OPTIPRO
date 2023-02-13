import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nan_aptipro_sampling_2023/core/entity/filter.dart';
import 'package:nan_aptipro_sampling_2023/core/entity/outlet.dart';
import '../../core/data/local_data_source.dart';
import '../../core/data/remote_data_source.dart';
import '../../core/entity/user.dart';
import '../../core/errors/app_exceptions.dart';
import '../../core/errors/failure.dart';
import '../../core/platform/network_info.dart';
import '../../core/storage/cache_db.dart';
import '../services/dio_client.dart';

abstract class Repository {
  Future<Either<Failure, User>> login(
      {required String userName,
      required String passWord,
      required String deviceId});
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> changePassword(
      {required String oldPass, required String newPass});
  Future<Either<Failure, List<OutletEntity>>> fetchOutlets(
      {required Filter filter});
  Future<Either<Failure, OutletEntity>> fetchOutlet(
      {required int id});
  Future<Either<Failure, bool>> checkPhone(
      {required String phone});
  Future<Either<Failure, bool>> checkOTP(
      {required String otp});
  Future<Either<Failure, bool>> uploadData(
      {required int outletId, DateTime? date, required String name, required String phone, required String otp, required List<Uint8List> images});
}

class RepositoryImpl extends Repository {
  final NetworkInfo networkInfo;
  final LocalDataSource local;
  final RemoteDataSource remote;

  RepositoryImpl(
      {required this.networkInfo, required this.local, required this.remote});

  @override
  Future<Either<Failure, User>> login(
      {required String userName,
      required String passWord,
      required String deviceId}) async {
    try {
      final token = await remote.login(
          userName: userName, passWord: passWord, deviceId: deviceId);
      Modular.get<DioClient>().setBearerAuth(token: token);
      final user = await remote.getProfile(accessToken: token);
      return Right(user);
    } on InternetException catch (_) {
      return const Left(InternetFailure());
    } on UnAuthorizedException catch (_) {
      return const Left(UnAuthenticateFailure());
    } on UpdateRequiredException catch (_) {
      return Left(UpdateRequiredFailure(message: _.message));
    } on ApiNotRespondingException catch (_) {
      return Left(ApiNotRespondingFailure(message: _.message));
    } on InternalException catch (_) {
      return const Left(InternalFailure());
    } on BadRequestException catch (_) {
      return Left(BadRequestFailure(message: _.message));
    } on FetchDataException catch (_) {
      return Left(FetchDataFailure(message: _.message));
    } catch (e) {
      debugPrint(e.toString());
      return Left(BadRequestFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final logout = await remote.logout();
      return Right(logout);
    } on InternetException catch (_) {
      return const Left(InternetFailure());
    } on UnAuthorizedException catch (_) {
      return const Left(UnAuthenticateFailure());
    } on UpdateRequiredException catch (_) {
      return Left(UpdateRequiredFailure(message: _.message));
    } on ApiNotRespondingException catch (_) {
      return Left(ApiNotRespondingFailure(message: _.message));
    } on InternalException catch (_) {
      return const Left(InternalFailure());
    } on BadRequestException catch (_) {
      return Left(BadRequestFailure(message: _.message));
    } on FetchDataException catch (_) {
      return Left(FetchDataFailure(message: _.message));
    } catch (e) {
      debugPrint(e.toString());
      return Left(BadRequestFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword(
      {required String oldPass, required String newPass}) async {
    try {
      final success =
          await remote.changePassword(oldPass: oldPass, newPass: newPass);
      return Right(success);
    } on InternetException catch (_) {
      return const Left(InternetFailure());
    } on UnAuthorizedException catch (_) {
      return const Left(UnAuthenticateFailure());
    } on UpdateRequiredException catch (_) {
      return Left(UpdateRequiredFailure(message: _.message));
    } on ApiNotRespondingException catch (_) {
      return Left(ApiNotRespondingFailure(message: _.message));
    } on InternalException catch (_) {
      return const Left(InternalFailure());
    } on BadRequestException catch (_) {
      return Left(BadRequestFailure(message: _.message));
    } on FetchDataException catch (_) {
      return Left(FetchDataFailure(message: _.message));
    } catch (e) {
      debugPrint(e.toString());
      return Left(BadRequestFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OutletEntity>>> fetchOutlets(
      {required Filter filter}) async {
    try {
      final outlets = await remote.fetchOutlets(filter: filter);
      return Right(outlets);
    } on InternetException catch (_) {
      return const Left(InternetFailure());
    } on UnAuthorizedException catch (_) {
      return const Left(UnAuthenticateFailure());
    } on UpdateRequiredException catch (_) {
      return Left(UpdateRequiredFailure(message: _.message));
    } on ApiNotRespondingException catch (_) {
      return Left(ApiNotRespondingFailure(message: _.message));
    } on InternalException catch (_) {
      return const Left(InternalFailure());
    } on BadRequestException catch (_) {
      return Left(BadRequestFailure(message: _.message));
    } on FetchDataException catch (_) {
      return Left(FetchDataFailure(message: _.message));
    } catch (e, s) {
      debugPrint(e.toString());
      print(s);
      return Left(BadRequestFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> uploadData({required int outletId, DateTime? date, required String name, required String phone, required String otp, required List<Uint8List> images}) async {
    try {
      final success = await remote.uploadData(outletId: outletId, name: name, phone: phone, otp: otp, images: images);
      return Right(success);
    } on InternetException catch (_) {
      return const Left(InternetFailure());
    } on UnAuthorizedException catch (_) {
      return const Left(UnAuthenticateFailure());
    } on UpdateRequiredException catch (_) {
      return Left(UpdateRequiredFailure(message: _.message));
    } on ApiNotRespondingException catch (_) {
      return Left(ApiNotRespondingFailure(message: _.message));
    } on InternalException catch (_) {
      return const Left(InternalFailure());
    } on BadRequestException catch (_) {
      return Left(BadRequestFailure(message: _.message));
    } on FetchDataException catch (_) {
      return Left(FetchDataFailure(message: _.message));
    } catch (e, s) {
      debugPrint(e.toString());
      print(s);
      return Left(BadRequestFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OutletEntity>> fetchOutlet({required int id}) async {
    try {
      final outlet = await remote.fetchOutlet(id: id);
      return Right(outlet);
    } on InternetException catch (_) {
      return const Left(InternetFailure());
    } on UnAuthorizedException catch (_) {
      return const Left(UnAuthenticateFailure());
    } on UpdateRequiredException catch (_) {
      return Left(UpdateRequiredFailure(message: _.message));
    } on ApiNotRespondingException catch (_) {
      return Left(ApiNotRespondingFailure(message: _.message));
    } on InternalException catch (_) {
      return const Left(InternalFailure());
    } on BadRequestException catch (_) {
      return Left(BadRequestFailure(message: _.message));
    } on FetchDataException catch (_) {
      return Left(FetchDataFailure(message: _.message));
    } catch (e, s) {
      debugPrint(e.toString());
      print(s);
      return Left(BadRequestFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkPhone({required String phone}) async {
    try {
     await remote.checkPhone(phone: phone);
      return Right(true);
    } on InternetException catch (_) {
      return const Left(InternetFailure());
    } on UnAuthorizedException catch (_) {
      return const Left(UnAuthenticateFailure());
    } on UpdateRequiredException catch (_) {
      return Left(UpdateRequiredFailure(message: _.message));
    } on ApiNotRespondingException catch (_) {
      return Left(ApiNotRespondingFailure(message: _.message));
    } on InternalException catch (_) {
      return const Left(InternalFailure());
    } on BadRequestException catch (_) {
      return Left(BadRequestFailure(message: _.message));
    } on FetchDataException catch (_) {
      return Left(FetchDataFailure(message: _.message));
    } catch (e, s) {
      debugPrint(e.toString());
      print(s);
      return Left(BadRequestFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkOTP({required String otp}) async {
    try {
      await remote.checkOTP(otp: otp);
      return Right(true);
    } on InternetException catch (_) {
      return const Left(InternetFailure());
    } on UnAuthorizedException catch (_) {
      return const Left(UnAuthenticateFailure());
    } on UpdateRequiredException catch (_) {
      return Left(UpdateRequiredFailure(message: _.message));
    } on ApiNotRespondingException catch (_) {
      return Left(ApiNotRespondingFailure(message: _.message));
    } on InternalException catch (_) {
      return const Left(InternalFailure());
    } on BadRequestException catch (_) {
      return Left(BadRequestFailure(message: _.message));
    } on FetchDataException catch (_) {
      return Left(FetchDataFailure(message: _.message));
    } catch (e, s) {
      debugPrint(e.toString());
      print(s);
      return Left(BadRequestFailure(message: e.toString()));
    }
  }
}
