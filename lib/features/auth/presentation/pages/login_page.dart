// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/utils/base_validator.dart';
import '../../../../core/utils/mixin/lifecycle_logger.dart';
import '../../../../shared/widgets/app_version.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/login_bloc/login_bloc.dart';
import '../blocs/password_visibility_cubit/password_visibility_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with StatefulLifecycleLogger {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late LoginBloc loginBloc;
  late PasswordVisibilityCubit passwordCubit;

  @override
  void initState() {
    loginBloc = context.read<LoginBloc>();
    passwordCubit = context.read<PasswordVisibilityCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      loginBloc.add(LoginSubmitted(_userCtrl.text, _passCtrl.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.read<AuthBloc>().add(AuthenticatedEvent(state.user));
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;
          return Stack(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _userCtrl,
                        onChanged: (value) => _formKey.currentState?.validate(),
                        readOnly: isLoading,
                        decoration: const InputDecoration(
                          labelText: "Username",
                        ),
                        validator: (value) => BaseValidator.required(value),
                      ),
                      BlocBuilder<PasswordVisibilityCubit, bool>(
                        builder: (context, visible) {
                          return TextFormField(
                            controller: _passCtrl,
                            onChanged: (value) =>
                                _formKey.currentState?.validate(),
                            readOnly: isLoading,
                            obscureText: !visible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  visible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: passwordCubit.toggle,
                              ),
                            ),
                            validator: (value) =>
                                BaseValidator.required(value) ??
                                BaseValidator.minLength(value, 6) ??
                                BaseValidator.maxLength(value, 20),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          minimumSize: const Size(100, 40),
                        ),
                        onPressed: isLoading ? null : () => _submit(context),
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text("Login"),
                      ),
                      if (state is LoginFailure)
                        Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: AppVersion(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
