import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../../core/repositories/repository.dart';
import '../../core/usecase/usecase.dart';

class UploadDataUseCase implements UseCase<bool, UploadDataParams> {
  final Repository repository;

  UploadDataUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(UploadDataParams params) async {
    return await repository.uploadData(outletId: params.outletId, date: params.date, name: params.name, phone: params.phone, otp: params.otp, images: params.images);
  }
}

class UploadDataParams extends Params {
  final DateTime? date;
  final String phone;
  final String name;
  final int outletId;
  final String otp;
  final List<Uint8List> images;

  UploadDataParams({required this.date, required this.phone, required this.name, required this.outletId, required this.otp, required this.images});
}