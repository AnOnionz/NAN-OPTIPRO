import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'core/common/constants.dart';
import 'features/login/blocs/authentication_bloc.dart';
import 'features/login/screens/login_page.dart';



class AuthenticateWidget extends StatefulWidget {
  final Widget child;

  const AuthenticateWidget({Key? key,required this.child}) : super(key: key);

  @override
  _AuthenticateWidgetState createState() => _AuthenticateWidgetState();
}

class _AuthenticateWidgetState extends State<AuthenticateWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
    autofocus: true,
    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: Modular.get<AuthenticationBloc>()..add(AppStarted()),
      builder: (context, state) {
        if(state is AuthenticationAuthenticated){
          return widget.child;
        }
        if(state is AuthenticationUnauthenticated){
         return LoginPage(deviceId: 'null',);
        }
        return Container(
            color: Colors.white,
            child: Center(child: Image.asset('assets/images/blue_loading.gif', height: 110, width: 110,)));
      },
    ),
    );
  }
}

