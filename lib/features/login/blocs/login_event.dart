part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}
class Login extends LoginEvent {
  final String userName;
  final String password;
  final String deviceId;

  const Login({required this.userName,required this.password, required this.deviceId});
}
class Logout extends LoginEvent {}
class UseCameraX extends LoginEvent {
  final bool value;

  const UseCameraX(this.value);
}
class SaveImage extends LoginEvent {
  final bool value;

  const SaveImage(this.value);
}
