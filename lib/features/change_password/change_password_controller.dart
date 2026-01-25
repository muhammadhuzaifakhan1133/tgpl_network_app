import 'dart:async';
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
  String? password;
  String? newPassword;
  String? passwordConfirmation;

  ChangePasswordState({
    required this.isPasswordObscure,
    required this.isNewPasswordObscure,
    this.password,
    this.newPassword,
    this.passwordConfirmation,
  });

  ChangePasswordState copyWith({
    bool? isPasswordObscure,
    bool? isNewPasswordObscure,
    String? password,
    String? newPassword,
    String? passwordConfirmation,
  }) {
    return ChangePasswordState(
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isNewPasswordObscure: isNewPasswordObscure ?? this.isNewPasswordObscure,
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }
}

class ChangePasswordController extends Notifier<ChangePasswordState> {
  // GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  ChangePasswordState build() {
    return ChangePasswordState(
      isPasswordObscure: true,
      isNewPasswordObscure: true,
    );
  }

  void togglePasswordObscure() {
    state = state.copyWith(isPasswordObscure: !state.isPasswordObscure);
  }

  void toggleNewPasswordObscure() {
    state = state.copyWith(isNewPasswordObscure: !state.isNewPasswordObscure);
  }

  void setOldPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setNewPassword(String newPassword) {
    state = state.copyWith(newPassword: newPassword);
  }

  void setPasswordConfirmation(String passwordConfirmation) {
    state = state.copyWith(passwordConfirmation: passwordConfirmation);
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
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      // await ref.read(changePasswordRepository).changePassword();
      await Future.delayed(Duration(seconds: 2));
      ref.read(goRouterProvider).pop();
    });
  }
}
