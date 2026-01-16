import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

final loginControllerProvider =
    NotifierProvider.autoDispose<LoginController, LoginState>(() {
      return LoginController();
    });

class LoginState {
  bool isPasswordObscure;
  bool rememberMe;
  String? username;
  String? password;

  LoginState({required this.isPasswordObscure, required this.rememberMe, this.username, this.password});

  LoginState copyWith({bool? isPasswordObscure, bool? rememberMe, String? username, String? password}) {
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
  FutureOr<void> build() async {}

  Future<void> login() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      // await ref.read(loginRepositoryProvider).login();
      await Future.delayed(Duration(seconds: 2));
      ref.read(goRouterProvider).go(AppRoutes.dashboard);
    });
  }
}
