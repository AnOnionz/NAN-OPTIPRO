import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/usecase/check_otp_usecase.dart';
import '../../../core/usecase/check_phone_usecase.dart';
import '../../../core/utils/my_dialog.dart';

part 'validate_event.dart';
part 'validate_state.dart';

class ValidateBloc extends Bloc<ValidateEvent, ValidateState> {
  final CheckPhoneUseCase checkPhone;
  final CheckOTPUseCase checkOTP;
  ValidateBloc({required this.checkPhone, required this.checkOTP})
      : super(ValidateState.init()) {
    on<Validated>((event, emit) async {
      if (event.name != state.name) {
        if (event.name.isNotEmpty && event.name != '') {
          emit(state.copyWith(name: event.name, nameValidate: true));
        } else {
          emit(state.copyWith(name: event.name, nameValidate: false));
        }
      }
      if (event.images.length >= 2) {
        emit(state.copyWith(images: event.images, imagesValidate: true));
      }
      if (event.phone != state.phone) {
        if (event.phone.isNotEmpty && event.phone != '') {
          final execute =
              await checkPhone.call(CheckPhoneParams(phone: event.phone));
          emit(execute.fold((l) {
            showSaveError(message: l.message);
            return state.copyWith(phone: event.phone, phoneValidate: false);
          }, (r) => state.copyWith(phone: event.phone, phoneValidate: true)));
        } else {
          emit(state.copyWith(phone: event.phone, phoneValidate: false));
        }
        return;
      }
      if (event.otp != state.otp) {
        if (event.otp.isNotEmpty && event.otp != '') {
          final execute = await checkOTP.call(CheckOTPParams(otp: event.otp));
          emit(execute.fold((l) {
            showSaveError(message: l.message);
            return state.copyWith(otp: event.otp, otpValidate: false);
          }, (r) => state.copyWith(otp: event.otp, otpValidate: true)));
        } else {
          emit(state.copyWith(otp: event.otp, otpValidate: false));
        }
        return;
      }
    });
    on<ResetForm>((event, emit) {
      emit(ValidateState.init());
    });
  }
}
