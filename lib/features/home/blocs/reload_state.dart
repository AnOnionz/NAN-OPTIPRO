part of 'reload_cubit.dart';

@immutable
abstract class ReloadState {}

class ReloadInitial extends ReloadState {}
class ReloadLoading<T> extends ReloadState {}
class ReloadFailure<T> extends ReloadState {}
class ReloadSuccess<T> extends ReloadState {}
