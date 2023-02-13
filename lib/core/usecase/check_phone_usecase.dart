import 'package:dartz/dartz.dart';
import 'package:nan_aptipro_sampling_2023/core/errors/failure.dart';
import 'package:nan_aptipro_sampling_2023/core/repositories/repository.dart';
import 'package:nan_aptipro_sampling_2023/core/usecase/usecase.dart';

class CheckPhoneUseCase extends UseCase<bool, CheckPhoneParams> {
  final Repository repository;

  CheckPhoneUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(CheckPhoneParams params) {
    return repository.checkPhone(phone: params.phone);
  }
}

class CheckPhoneParams extends Params {
  final String phone;

  CheckPhoneParams({required this.phone});
}
