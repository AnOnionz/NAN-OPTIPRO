import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase/change_password_usecase.dart';

part 'change_pass_state.dart';

class ChangePassCubit extends Cubit<ChangePassState> {
  final ChangePasswordUseCase change;
  ChangePassCubit({required this.change}) : super(ChangePassInitial());

  void changePass({required String oldPass, required String newPass}) async {
    emit(ChangePassLoading());
    final execute =
        await change(ChangePasswordParams(oldPass: oldPass, newPass: newPass));
    emit(execute.fold((l) => ChangePassFailure(l), (r) => ChangePassSuccess()));
  }
}
