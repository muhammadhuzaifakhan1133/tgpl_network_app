import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/home_shell/presentation/home_shell_controller.dart';
import 'package:tgpl_network/features/login/data/auth_data_source.dart';
import 'package:tgpl_network/features/login/models/login_request_model.dart';
import 'package:tgpl_network/features/login/models/login_response_model.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

final loginControllerProvider =
    NotifierProvider.autoDispose<LoginController, LoginState>(() {
      return LoginController();
    });

class LoginState {
  bool isPasswordObscure;
  bool rememberMe;
  String? username;
  String? password;

  LoginState({
    required this.isPasswordObscure,
    required this.rememberMe,
    this.username,
    this.password,
  });

  LoginState copyWith({
    bool? isPasswordObscure,
    bool? rememberMe,
    String? username,
    String? password,
  }) {
    return LoginState(
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      rememberMe: rememberMe ?? this.rememberMe,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}

class LoginController extends Notifier<LoginState> {
  @override
  LoginState build() {
    return LoginState(isPasswordObscure: true, rememberMe: false);
  }

  void togglePasswordObscure() {
    state = state.copyWith(isPasswordObscure: !state.isPasswordObscure);
  }

  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  void setUsername(String username) {
    state = state.copyWith(username: username);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }
}

final loginAuthControllerProvider =
    AsyncNotifierProvider.autoDispose<LoginAsyncController, void>(() {
      return LoginAsyncController();
    });

class LoginAsyncController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    return null;
  }

  Future<LoginResponseModel?> login() async {
    // Validate inputs
    final loginState = ref.read(loginControllerProvider);
    if (loginState.username.isNullOrEmpty ||
        loginState.password.isNullOrEmpty) {
      state = AsyncError(
        Exception('Username and password are required'),
        StackTrace.current,
      );
      return null;
    }

    state = const AsyncLoading();

    try {
      final authDataSource = ref.read(authRemoteDataSourceProvider);
      final response = await authDataSource.login(
        LoginRequestModel(
          username: loginState.username!,
          password: loginState.password!,
        ),
      );
      ref.read(isOpenHomeFirstTimeProvider.notifier).state = true;
      state = const AsyncData(null);
      return response;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}
