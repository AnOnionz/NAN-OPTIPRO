import 'package:dartz/dartz.dart';
import 'package:nan_aptipro_sampling_2023/core/errors/failure.dart';
import 'package:nan_aptipro_sampling_2023/core/repositories/repository.dart';
import 'package:nan_aptipro_sampling_2023/core/usecase/usecase.dart';

class CheckOTPUseCase extends UseCase<bool, CheckOTPParams> {
  final Repository repository;

  CheckOTPUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(CheckOTPParams params) {
    return repository.checkOTP(otp: params.otp);
  }
}

class CheckOTPParams extends Params {
  final String otp;

  CheckOTPParams({required this.otp});
}
