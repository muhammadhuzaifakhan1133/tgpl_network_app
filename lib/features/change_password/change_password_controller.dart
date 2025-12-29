import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/routes/app_router.dart';

final changePasswordControllerProvider =
    NotifierProvider.autoDispose<ChangePasswordController, ChangePasswordState>(
      () {
        return ChangePasswordController();
      },
    );

class ChangePasswordState {
  bool isPasswordObscure;
  bool isNewPasswordObscure;

  ChangePasswordState({
    required this.isPasswordObscure,
    required this.isNewPasswordObscure,
  });

  ChangePasswordState copyWith({
    bool? isPasswordObscure,
    bool? isNewPasswordObscure,
  }) {
    return ChangePasswordState(
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isNewPasswordObscure: isNewPasswordObscure ?? this.isNewPasswordObscure,
    );
  }
}

class ChangePasswordController extends Notifier<ChangePasswordState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  ChangePasswordState build() {
    ref.onDispose(dispose);
    return ChangePasswordState(
      isPasswordObscure: true,
      isNewPasswordObscure: true,
    );
  }

  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    passwordConfirmationController.dispose();
  }

  void togglePasswordObscure() {
    state = state.copyWith(isPasswordObscure: !state.isPasswordObscure);
  }

  void toggleNewPasswordObscure() {
    state = state.copyWith(isNewPasswordObscure: !state.isNewPasswordObscure);
  }
}

final changePasswordAsyncControllerProvider =
    AsyncNotifierProvider.autoDispose<ChangePasswordAsyncController, void>(() {
      return ChangePasswordAsyncController();
    });

class ChangePasswordAsyncController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<void> changePassword() async {
    if (!ref
        .read(changePasswordControllerProvider.notifier)
        .formKey
        .currentState!
        .validate()) {
      return;
    }
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      // await ref.read(changePasswordRepository).changePassword();
      await Future.delayed(Duration(seconds: 2));
      ref.read(goRouterProvider).pop();
    });
  }
}
