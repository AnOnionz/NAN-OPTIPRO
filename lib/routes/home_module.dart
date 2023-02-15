import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nan_aptipro_sampling_2023/authen_widget.dart';
import 'package:nan_aptipro_sampling_2023/features/home/screens/dashboard_page.dart';
import 'package:nan_aptipro_sampling_2023/features/home/screens/home_page.dart';
import 'package:nan_aptipro_sampling_2023/features/setting/screens/setting_page.dart';
import '../core/data/local_data_source.dart';
import '../core/platform/camera_page.dart';
import '../core/platform/network_info.dart';
import '../core/repositories/repository.dart';
import '../core/usecase/change_password_usecase.dart';
import '../core/usecase/check_otp_usecase.dart';
import '../core/usecase/check_phone_usecase.dart';
import '../core/usecase/fetch_outlet_usecase.dart';
import '../core/usecase/fetch_outlets_usecase.dart';
import '../core/usecase/login_usecase.dart';
import '../core/usecase/logout_usecase.dart';
import '../core/usecase/upload_data_usecase.dart';
import '../features/change_pass/blocs/change_pass_cubit.dart';
import '../features/home/blocs/dashboard_cubit.dart';
import '../features/home/blocs/form_cubit.dart';
import '../features/home/blocs/reload_cubit.dart';
import '../features/home/blocs/tab_bloc.dart';
import '../features/home/blocs/validate_bloc.dart';
import '../features/login/blocs/authentication_bloc.dart';
import '../features/login/blocs/login_bloc.dart';
import '../application.dart';

class HomeModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginBloc(
      login: i.get<LoginUseCase>(),
      logout: i.get<LogoutUseCase>(),
      authenticationBloc: i.get<AuthenticationBloc>(),
    )),
    Bind.lazySingleton((i) => LoginUseCase(repository: i.get<Repository>())),
    Bind.lazySingleton((i) => LogoutUseCase(repository: i.get<Repository>())),
    //HOME
    Bind.lazySingleton((i) => TabBloc()),
    Bind.factory((i) => DashboardCubit(fetchOutlets: i.get<FetchOutletsUseCase>(), fetchOutlet: i.get<FetchOutletUseCase>())),
    Bind.lazySingleton(
            (i) => FetchOutletsUseCase(repository: i.get<Repository>())),
    Bind.lazySingleton(
            (i) => FetchOutletUseCase(repository: i.get<Repository>())),
    Bind.factory((i) => ReloadCubit()),
    //CHANGE PASSWORD
    Bind.factory(
        (i) => ChangePassCubit(change: i.get<ChangePasswordUseCase>())),
    Bind.lazySingleton(
        (i) => ChangePasswordUseCase(repository: i.get<Repository>())),
    //FORM
    Bind.factory(
            (i) => FormCubit(uploadData: i.get<UploadDataUseCase>())),
    Bind.factory(
            (i) => ValidateBloc(checkPhone: i.get<CheckPhoneUseCase>(), checkOTP: i.get<CheckOTPUseCase>())),
    Bind.lazySingleton(
            (i) => UploadDataUseCase(repository: i.get<Repository>())),
    Bind.lazySingleton(
            (i) => CheckPhoneUseCase(repository: i.get<Repository>())),
    Bind.lazySingleton(
            (i) => CheckOTPUseCase(repository: i.get<Repository>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AuthenticateWidget(child: DashboardPage())),
    ChildRoute('/:id/form', child: (_, args) => AuthenticateWidget(child: HomePage(isEdit: false, outletId: args.params['id']))),
    ChildRoute('/edit', child: (_, args) => AuthenticateWidget(child: DashboardPage())),
    ChildRoute('/edit/:id/form', child: (_, args) => AuthenticateWidget(child: HomePage(isEdit: true,outletId: args.params['id']))),
    ChildRoute('/setting', child: (_, args) => AuthenticateWidget(child: SettingPage())),
    ChildRoute('/image', child: (_, args) => const CameraPage()),
  ];
}
