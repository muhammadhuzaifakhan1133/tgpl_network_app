import 'dart:async';

import 'package:flutter/material.dart';
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

  LoginState({required this.isPasswordObscure, required this.rememberMe});

  LoginState copyWith({bool? isPasswordObscure, bool? rememberMe}) {
    return LoginState(
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}

class LoginController extends Notifier<LoginState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  LoginState build() {
    ref.onDispose(dispose);
    return LoginState(isPasswordObscure: true, rememberMe: false);
  }

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  void togglePasswordObscure() {
    state = state.copyWith(isPasswordObscure: !state.isPasswordObscure);
  }

  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
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
    if (!ref
        .read(loginControllerProvider.notifier)
        .formKey
        .currentState!
        .validate()) {
      return;
    }
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      // await ref.read(loginRepositoryProvider).login();
      await Future.delayed(Duration(seconds: 2));
      ref.read(goRouterProvider).go(AppRoutes.dashboard);
    });
  }
}
