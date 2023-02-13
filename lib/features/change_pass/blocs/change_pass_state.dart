part of 'change_pass_cubit.dart';

@immutable
abstract class ChangePassState {}

class ChangePassInitial extends ChangePassState {}
class ChangePassLoading extends ChangePassState {}
class ChangePassSuccess extends ChangePassState {}
class ChangePassFailure extends ChangePassState {
  final Failure failure;

  ChangePassFailure(this.failure);
}
