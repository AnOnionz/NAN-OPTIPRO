import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../core/common/keys.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/entity/user.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/storage/hive_db.dart' as hive;


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FlutterSecureStorage storage;
  static User? loginEntity;
  static bool useXCamera = false;
  static bool saveImage = true;
  AuthenticationBloc({required this.storage}) : super(AuthenticationInitial()) {
    on<AppStarted>((event, emit) async {
      try {
        String? loginEntity = await storage.read(key: user);
        String? useCamera = await storage.read(key: 'camera');
        String? saveToGallery = await storage.read(key: 'saveImage');
        if (useCamera != null) {
          AuthenticationBloc.useXCamera = true;
        }
        if (saveToGallery !=null) {
          AuthenticationBloc.saveImage = false;
        }
        if (loginEntity != null) {
          add(LoggedIn(user: User.fromJson(jsonDecode(loginEntity))));
        } else {
          emit(AuthenticationUnauthenticated());
        }
      } catch (e) {
        debugPrint("can't read user in storage");
        emit(AuthenticationUnauthenticated());
      }
    });
    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoading());
      loginEntity = event.user;
      await storage.write(key: user, value: jsonEncode(loginEntity!.toJson()));
      Modular.get<DioClient>().setBearerAuth(token: loginEntity!.token);
      emit(AuthenticationAuthenticated(user: event.user));
    });
    on<LoggedOut>((event, emit) async {
      await storage.delete(key: user);
      loginEntity = null;
      Modular.to.pushNamedAndRemoveUntil('/', (p0) => false);
      emit(AuthenticationUnauthenticated());
    });
    on<UseXCamera>((event, emit) async {
      AuthenticationBloc.useXCamera = event.value;
      await storage.write(key: 'camera', value: event.value ? 'yes' : null);
    });
    on<SaveToGallery>((event, emit) async {
      AuthenticationBloc.saveImage = event.value;
      await storage.write(key: 'saveImage', value: event.value ? null : 'no');
    });
  }
}
