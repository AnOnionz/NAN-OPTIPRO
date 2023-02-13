import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nan_aptipro_sampling_2023/core/errors/failure.dart';

import '../../../core/usecase/upload_data_usecase.dart';
import '../../../core/utils/my_dialog.dart';

part 'form_state.dart';

class FormCubit extends Cubit<UploadFormState> {
  final UploadDataUseCase uploadData;
  FormCubit({required this.uploadData}) : super(FormInitial());

  void sendForm(
      {required int outletId,
      DateTime? date,
      required String name,
      required String phone,
      required String otp,
      required List<Uint8List> images}) async {
    emit(FormLoading());
    showLoading();
    final execute = await uploadData(UploadDataParams(
        phone: phone,
        name: name,
        images: images,
        otp: otp,
        outletId: outletId));
    emit(execute.fold((l) {
      return FormFailure(l);
    }, (r) {
      return FormSuccess();
    }));
    closeLoading();
  }
}
