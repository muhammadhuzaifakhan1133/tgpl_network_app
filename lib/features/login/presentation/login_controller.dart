import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginControllerProvider = AsyncNotifierProvider<LoginController, LoginState>(() {
  return LoginController();
});

class LoginState {
  bool isPasswordObscure;
  bool rememberMe;

  LoginState({required this.isPasswordObscure, required this.rememberMe});

  LoginState copyWith({bool? isPasswordObscure, bool? rememberMe}) {
    return LoginState(isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure, rememberMe: rememberMe ?? this.rememberMe);
  }
}

class LoginController extends AsyncNotifier<LoginState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  FutureOr<LoginState> build() async {
    ref.onDispose(dispose);
    return LoginState(isPasswordObscure: true, rememberMe: false);
  }  

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void togglePasswordObscure() {
    state = AsyncData(state.requireValue.copyWith(isPasswordObscure: !state.requireValue.isPasswordObscure));
  }

  void toggleRememberMe() {
    state = AsyncData(state.requireValue.copyWith(rememberMe: !state.requireValue.rememberMe));
  }

  Future<void> login() async {
    // state = AsyncLoading();
    // state = await AsyncValue.guard<LoginState>(ref.read(loginRepositoryProvider).login);
  }
}