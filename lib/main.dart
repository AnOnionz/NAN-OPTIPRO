import 'dart:async';
import 'dart:io';
import 'package:asuka/asuka.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nan_aptipro_sampling_2023/simple_bloc_observer.dart';
import 'package:url_strategy/url_strategy.dart';
import 'routes/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'core/common/constants.dart';


/*      |\ |\
        \ \| |
         \ | |
       .--''/
      /o     \
      \      /
       {>o<}='         */



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    Bloc.observer = MyBlocObserver();
    runApp(ModularApp(module: AppModule(), child: const App()));
  });

}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static final navKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: navKey,
      debugShowCheckedModeBanner: false,
      title: "NAN OPTIPRO SAMPLING",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('vi', ''),
      ],
      theme: ThemeData(
        fontFamily: 'FuturaMd',
        highlightColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: kBlueColor,
                textStyle: kStyleWhite16Regular)),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            fontSize: 18.0,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      builder: FlutterSmartDialog.init(builder: Asuka.builder),
    );
  }
}
