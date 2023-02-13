import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/errors/failure.dart';

abstract class UseCase<Type, Params>{
  Future<Either<Failure, Type>> call(Params params);
}
class Params extends Equatable{
  @override
  List<Object> get props => [];

}
class NoParams extends Equatable{
  @override
  List<Object> get props => [];

}
class IDParams extends Params{
  final int id;

  IDParams({required this.id});
}

class ReceiptParams extends Params {
  final int id;
  final List<String> images;
  final List<int> ids;

  ReceiptParams(
      {required this.id, required this.images, required this.ids});
}
