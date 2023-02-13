import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reload_state.dart';

class ReloadCubit extends Cubit<ReloadState> {

  ReloadCubit()
      : super(ReloadInitial());
}
