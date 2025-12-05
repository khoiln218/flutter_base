// Dart imports:
import 'dart:async';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_profile_use_case.dart';
import '../../../domain/usecases/logout_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetProfile getProfileUseCase;
  final Logout logoutUseCase;

  AuthBloc(this.getProfileUseCase, this.logoutUseCase) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<AuthenticatedEvent>(_onAuthenticated);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final result = await getProfileUseCase();
    result.fold(
      (fail) => emit(Unauthenticated()),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onAuthenticated(
    AuthenticatedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(Authenticated(event.user));
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    logoutUseCase();
    emit(Unauthenticated());
  }
}
