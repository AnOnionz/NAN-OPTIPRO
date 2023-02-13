part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();

}
class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final User user;

  LoggedIn({required this.user});

  @override
  String toString() => 'LoggedIn { user: $user}';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}

class UseXCamera extends AuthenticationEvent {
  final bool value;

  UseXCamera(this.value);

}
class SaveToGallery extends AuthenticationEvent {
  final bool value;

  SaveToGallery(this.value);

}