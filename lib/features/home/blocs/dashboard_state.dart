part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {
}
class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState {}
class DashboardSuccess extends DashboardState {
  final List<OutletEntity> outlets;
  final bool isLoadMoreFailure;

  DashboardSuccess( this.outlets,  this.isLoadMoreFailure);
}
class LoadOutletSuccess extends DashboardState {
  final OutletEntity outlet;

  LoadOutletSuccess( this.outlet);
}
class DashboardFailure extends DashboardState {
  final Failure failure;

  DashboardFailure(this.failure);
}


