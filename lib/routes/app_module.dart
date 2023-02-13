import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../404.dart';
import '../core/data/local_data_source.dart';
import '../core/data/remote_data_source.dart';
import '../core/repositories/repository.dart';
import '../core/services/dio_client.dart';
import '../../core/platform/network_info.dart';
import '../core/usecase/login_usecase.dart';
import '../core/usecase/logout_usecase.dart';
import '../features/login/blocs/authentication_bloc.dart';
import '../features/login/blocs/login_bloc.dart';
import 'home_module.dart';

class AppModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DioClient()),
    Bind.lazySingleton((i) => const FlutterSecureStorage(webOptions: WebOptions(dbName: 'nansampling'))),
    Bind.lazySingleton((i) => NetworkInfoImpl()),
    Bind.lazySingleton((i) => RepositoryImpl(
        networkInfo: i.get<NetworkInfo>(),
        local: i.get<LocalDataSource>(),
        remote: i.get<RemoteDataSource>())),
    Bind.lazySingleton((i) => RemoteDataSourceImpl(client: i.get<DioClient>())),
    Bind.lazySingleton((i) => const LocalDataSourceImpl()),
    //LOGIN
    Bind.lazySingleton(
            (i) => AuthenticationBloc(storage: i.get<FlutterSecureStorage>())),

  ];
  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 200)),
    WildcardRoute(child: (_, args) => ErrorPage(),
    ),
  ];

}