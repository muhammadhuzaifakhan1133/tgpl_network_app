import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/user_provider.dart';
import 'package:tgpl_network/features/change_password/data/change_password_data_source.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

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
  bool autoValidate;

  ChangePasswordState({
    required this.isPasswordObscure,
    required this.isNewPasswordObscure,
    this.password,
    this.newPassword,
    this.passwordConfirmation,
    this.autoValidate = false,
  });

  ChangePasswordState copyWith({
    bool? isPasswordObscure,
    bool? isNewPasswordObscure,
    String? password,
    String? newPassword,
    String? passwordConfirmation,
    bool? autoValidate,
  }) {
    return ChangePasswordState(
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isNewPasswordObscure: isNewPasswordObscure ?? this.isNewPasswordObscure,
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      autoValidate: autoValidate ?? this.autoValidate,
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

  void setAutoValidate(bool autoValidate) {
    state = state.copyWith(autoValidate: autoValidate);
  }
}

final changePasswordAsyncControllerProvider =
    AsyncNotifierProvider.autoDispose<ChangePasswordAsyncController, void>(() {
      return ChangePasswordAsyncController();
    });

class ChangePasswordAsyncController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<bool> changePassword() async {
    final fieldsState = ref.read(changePasswordControllerProvider);
    if (fieldsState.password.isNullOrEmpty ||
        fieldsState.newPassword.isNullOrEmpty ||
        fieldsState.passwordConfirmation.isNullOrEmpty) {
      state = AsyncError("All fields are required", StackTrace.current);
      return false;
    }
    final changePwdDataSource = ref.read(changePasswordDataSourceProvider);
    state = AsyncLoading();
    try {
      final userId = ref.read(userProvider).value?.userId;
      final response = await changePwdDataSource.changePassword(
        userId: userId.toString(),
        currentPassword: fieldsState.password!,
        newPassword: fieldsState.newPassword!,
        confirmPassword: fieldsState.passwordConfirmation!,
      );
      if (response.success) {
        state = AsyncData(null);
        return true;
      } else {
        state = AsyncError(response.message, StackTrace.current);
        return false;
      }
    } catch (e, s) {
      state = AsyncError(e, s);
      return false;
    }
  }
}
