import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_handler/permission_handler.dart';
import 'core/data/local_data_source.dart';
import 'core/widgets/custom_loading.dart';
import 'features/home/screens/dashboard_page.dart';
import 'features/login/blocs/authentication_bloc.dart';
import 'features/login/blocs/login_bloc.dart';
import 'features/login/screens/login_page.dart';

class MyApplication extends StatefulWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  _MyApplicationState createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  final AuthenticationBloc _authenticationBloc =
      Modular.get<AuthenticationBloc>()..add(AppStarted());
  final LoginBloc _loginBloc = Modular.get<LoginBloc>();
  final LocalDataSource local = Modular.get<LocalDataSource>();
  final globalKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _handlePermission();
  }

  Future<void> _handlePermission() async {
    await Permission.camera.request();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: (_) => _authenticationBloc),
        BlocProvider<LoginBloc>(create: (_) => _loginBloc),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnauthenticated) {
            return const LoginPage(
              deviceId: 'null',
            );
          }
          if (state is AuthenticationAuthenticated) {
            return DashboardPage();
          }
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: const Center(child: CustomLoading()),
              ),
            ),
          );
        },
      ),
    );
  }
}
