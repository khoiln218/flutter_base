// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/login_use_case.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      final result = await loginUseCase(
        LoginParams(event.username, event.password),
      );
      result.fold(
        (fail) {
          emit(LoginFailure(fail.message));
        },
        (user) {
          emit(LoginSuccess(user));
        },
      );
    });
  }
}
