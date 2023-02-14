import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../core/entity/filter.dart';
import '../../../core/entity/outlet.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/fetch_outlet_usecase.dart';
import '../../../core/usecase/fetch_outlets_usecase.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/my_dialog.dart';
import '../../../core/utils/toats.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final FetchOutletsUseCase fetchOutlets;
  final FetchOutletUseCase fetchOutlet;
  DashboardCubit({required this.fetchOutlets, required this.fetchOutlet}) : super(DashboardSuccess([], false));

    void getOutlets({required Filter filter, bool loadMore = false}) async {
      if (!loadMore) {
        emit(DashboardLoading());
      }
      final execute = await fetchOutlets(FetchOutletsParams(filter: filter));
      emit(execute.fold((l) {
        if (!loadMore) {
          return DashboardFailure(l);
        } else {
          showToast(
              message: 'lấy dữ liệu thất bại', color: Colors.black38);
          return DashboardSuccess([], true);
        }
      }, (r) {
        return DashboardSuccess(r, false);
      }));
    }
  void getOutlet({required int id}) async {
    emit(DashboardLoading());
    final execute = await fetchOutlet(FetchOutletParams(id: id));
    emit(execute.fold((l) {
      return DashboardFailure(l);
    }, (r) {
      return LoadOutletSuccess(r);
    }));
  }
  }
