import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../../core/repositories/repository.dart';
import '../../core/usecase/usecase.dart';

class ChangePasswordUseCase implements UseCase<bool, ChangePasswordParams> {
  final Repository repository;

  ChangePasswordUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(ChangePasswordParams params) async {
    return await repository.changePassword(
        oldPass: params.oldPass, newPass: params.newPass);
  }
}

class ChangePasswordParams extends Params {
  final String oldPass;
  final String newPass;

  ChangePasswordParams({required this.oldPass, required this.newPass});
}
