import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/login/presentation/login_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

class RefreshTokenLoginDialogContent extends ConsumerWidget {
  const RefreshTokenLoginDialogContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final loginStateCtr = ref.read(loginControllerProvider.notifier);
    ref.listen(loginAuthControllerProvider, (prev, next) {
      next.when(
        data: (_) {},
        loading: () {},
        error: (error, stackTrace) {
          showSnackBar(context, error.toString());
        },
      );
    });
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        title: Text(
          'Session Expired',
          style: AppTextstyles.googleInter700black28.copyWith(fontSize: 20.sp),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please re-enter your credentials to continue.',
              style: AppTextstyles.googleInter400black16,
            ),
            SizedBox(height: 16.h),
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFieldWithTitle(
                    title: "Username",
                    hintText: "muhammadhuzaifakhan",
                    showClearButton: true,
                    validator: (v) => v.validate(),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: loginStateCtr.setUsername,
                  ),
                  SizedBox(height: 16.h),
                  Consumer(
                    builder: (context, ref, child) {
                      final isPasswordObscure = ref.watch(
                        loginControllerProvider.select(
                          (s) => s.isPasswordObscure,
                        ),
                      );
                      return CustomTextFieldWithTitle(
                        title: "Password",
                        hintText: "*******",
                        obscureText: isPasswordObscure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            loginStateCtr.togglePasswordObscure();
                          },
                          icon: Icon(
                            isPasswordObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        validator: (v) => v.validate(),
                        onChanged: loginStateCtr.setPassword,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final loginAuth = ref.watch(loginAuthControllerProvider);
              return TextButton(
                onPressed: loginAuth.isLoading
                    ? null
                    : () async {
                        if (formKey.currentState != null &&
                            formKey.currentState!.validate()) {
                          final response = await ref
                              .read(loginAuthControllerProvider.notifier)
                              .login();
                          if (response != null && context.mounted) {
                            ref.read(goRouterProvider).pop(true);
                          }
                        }
                      },
                child: Text(
                  loginAuth.isLoading ? 'Logging in...' : 'Login',
                  style: AppTextstyles.googleInter700black28.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Future<dynamic> refreshTokenLoginDialog(Ref ref) {
  return showDialog(
    context: ref
        .read(goRouterProvider)
        .routerDelegate
        .navigatorKey
        .currentContext!,
    barrierDismissible: false,
    builder: (ctx) {
      return const RefreshTokenLoginDialogContent();
    },
  );
}
