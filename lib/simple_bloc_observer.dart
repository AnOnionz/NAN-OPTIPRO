import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class MyBlocObserver extends BlocObserver {
  final _logger = Logger();
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _logger.d('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logger.d('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logger.d('onError -- ${bloc.runtimeType}, $error');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _logger.d('onClose -- ${bloc.runtimeType}');
  }
}