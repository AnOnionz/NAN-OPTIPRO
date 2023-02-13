import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../../core/repositories/repository.dart';
import '../../core/usecase/usecase.dart';



class LogoutUseCase implements UseCase<bool, NoParams>{
  final Repository repository;

  LogoutUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(NoParams noParams) async  {
    return await repository.logout();
  }
}