import 'package:dartz/dartz.dart';
import 'package:nan_aptipro_sampling_2023/core/entity/outlet.dart';
import '../../core/usecase/usecase.dart';
import '../entity/filter.dart';
import '../errors/failure.dart';
import '../repositories/repository.dart';

class FetchOutletUseCase
    implements UseCase<OutletEntity, FetchOutletParams> {
  final Repository repository;

  FetchOutletUseCase({required this.repository});
  @override
  Future<Either<Failure, OutletEntity>> call(
      FetchOutletParams params) async {
    return repository.fetchOutlet(id: params.id);
  }
}

class FetchOutletParams extends Params {
  final int id;

  FetchOutletParams({required this.id});
}
