part of 'form_cubit.dart';

@immutable
abstract class UploadFormState {}

class FormInitial extends UploadFormState {}
class FormLoading extends UploadFormState {}
class FormSuccess extends UploadFormState {}
class FormFailure extends UploadFormState {
  final Failure failure;

  FormFailure(this.failure);
}
