import 'package:dartz/dartz.dart';
import '../../core/entity/user.dart';
import '../../core/errors/failure.dart';
import '../../core/repositories/repository.dart';
import '../../core/usecase/usecase.dart';


class LoginUseCase implements UseCase<User, LoginParams>{
  final Repository repository;

  LoginUseCase({required this.repository});
  @override
  Future<Either<Failure, User>> call(LoginParams params) async  {
    return await repository.login(userName: params.username, passWord: params.password, deviceId: params.deviceId);
  }
}
class LoginParams extends Params {
  final String username;
  final String password;
  final String deviceId;

  LoginParams({required this.username,required this.password, required this.deviceId});

}