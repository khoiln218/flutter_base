// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'logger/logger_service_impl.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    _log("${bloc.runtimeType} -> onCreate");
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    _log("${bloc.runtimeType} -> onEvent: $event");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    _log("${bloc.runtimeType} -> onTransition: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log("${bloc.runtimeType} -> onError: $error");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    _log("${bloc.runtimeType} -> onChange: $change");
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    _log("${bloc.runtimeType} -> onClose");
    super.onClose(bloc);
  }

  void _log(String message) {
    logger.d(message, showMethod: false, showFile: false);
  }
}
