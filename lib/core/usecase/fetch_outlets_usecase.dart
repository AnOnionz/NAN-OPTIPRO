import 'package:dartz/dartz.dart';
import 'package:nan_aptipro_sampling_2023/core/entity/outlet.dart';
import '../../core/usecase/usecase.dart';
import '../entity/filter.dart';
import '../errors/failure.dart';
import '../repositories/repository.dart';

class FetchOutletsUseCase
    implements UseCase<List<OutletEntity>, FetchOutletsParams> {
  final Repository repository;

  FetchOutletsUseCase({required this.repository});
  @override
  Future<Either<Failure, List<OutletEntity>>> call(
      FetchOutletsParams params) async {
    return repository.fetchOutlets(filter: params.filter);
  }
}

class FetchOutletsParams extends Params {
  final Filter filter;

  FetchOutletsParams({required this.filter});
}
