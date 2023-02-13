import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../core/entity/user.dart';
import '../../../core/usecase/login_usecase.dart';
import '../../../core/usecase/logout_usecase.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/my_dialog.dart';
import 'authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase login;
  final LogoutUseCase logout;
  final AuthenticationBloc authenticationBloc;
  LoginBloc({
    required this.login,
    required this.logout,
    required this.authenticationBloc,
  }) : super(LoginInitial()) {
    on<Login>((event, emit) async {
      emit(LoginLoading());
      showLoading();
      final execute = await login(LoginParams(
          username: event.userName,
          password: event.password,
          deviceId: event.deviceId));
      emit(execute.fold((failure) {
        displayError(failure);
        return LoginFailure(message: failure.message);
      }, (user) {
        authenticationBloc.add(LoggedIn(user: user));
        return LoginSuccess(user: user);
      }));
      closeLoading();
    });
    on<Logout>((event, emit) async {
      emit(LogoutLoading());
      final execute = await logout(NoParams());
      emit(execute.fold((failure) {
        displayError(failure);
        return LogoutFailure(message: failure.message);
      }, (success) {
        authenticationBloc.add(LoggedOut());
        return LogoutSuccess();
      }));
    });
    on<UseCameraX>((event, emit) async {
      authenticationBloc.add(UseXCamera(event.value));
    });
    on<SaveImage>((event, emit) async {
      authenticationBloc.add(SaveToGallery(event.value));
    });
  }
}
