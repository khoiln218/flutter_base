part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class AuthenticatedEvent extends AuthEvent {
  final User user;

  const AuthenticatedEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class LogoutRequested extends AuthEvent {}
