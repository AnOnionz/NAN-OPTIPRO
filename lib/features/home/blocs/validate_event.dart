part of 'validate_bloc.dart';

@immutable
abstract class ValidateEvent {}

class Validated extends ValidateEvent {
  final String name;
  final String phone;
  final String otp;
  final List<Uint8List> images;

  Validated(
      {required this.name,
      required this.phone,
      required this.otp,
      required this.images});
}
class ResetForm extends ValidateEvent {

}