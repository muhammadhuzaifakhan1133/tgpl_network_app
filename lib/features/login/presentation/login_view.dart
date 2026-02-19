import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/common/providers/auto_validate_form.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/home_shell/presentation/home_shell_controller.dart';
import 'package:tgpl_network/features/login/models/login_response_model.dart';
import 'package:tgpl_network/features/login/presentation/login_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _listenLoginAuth(AsyncValue<void>? previous, AsyncValue<void> next) {
    next.when(
      data: (_) {},
      loading: () {},
      error: (error, stackTrace) {
        showSnackBar(context, error.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(loginControllerProvider.notifier);
    ref.listen(loginAuthControllerProvider, _listenLoginAuth);
    final autoValidate = ref.watch(autoValidateFormModeProvider);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 56.w),
                child: Column(
                  children: [
                    SizedBox(height: 124.h),
                    SvgPicture.asset(
                      AppImages.tajLogoSvg,
                      width: 46.w,
                      height: 45.h,
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      "Get Started now",
                      textAlign: TextAlign.center,
                      style: AppTextstyles.googleInter700black28,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Sign in to continue to TGPL Field Operations",
                      textAlign: TextAlign.center,
                      style: AppTextstyles.googleInter400black16,
                    ),
                    SizedBox(height: 32.h),
                    Form(
                      key: _formKey,
                      autovalidateMode: autoValidate
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          CustomTextFieldWithTitle(
                            title: "Username",
                            hintText: "muhammadhuzaifakhan",
                            showClearButton: true,
                            validator: (v) => v.validate(),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (v) {
                              controller.setUsername(v);
                            },
                          ),
                          SizedBox(height: 16.h),
                          Consumer(
                            builder: (context, ref, child) {
                              final isPasswordObscure = ref.watch(
                                loginControllerProvider.select(
                                  (state) => state.isPasswordObscure,
                                ),
                              );
                              return CustomTextFieldWithTitle(
                                title: "Password",
                                hintText: "*******",
                                obscureText: isPasswordObscure,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.togglePasswordObscure();
                                  },
                                  icon: Icon(
                                    isPasswordObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 20,
                                  ),
                                ),
                                validator: (v) => v.validate(),
                                onChanged: (v) {
                                  controller.setPassword(v);
                                },
                              );
                            },
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Consumer(
                                builder: (context, ref, child) {
                                  final isRememberMe = ref.watch(
                                    loginControllerProvider.select(
                                      (state) => state.rememberMe,
                                    ),
                                  );
                                  return Padding(
                                    padding: EdgeInsets.all(3.96.h),
                                    child: SizedBox(
                                      width: 11.8.w,
                                      height: 11.8.h,
                                      child: Checkbox(
                                        activeColor:
                                            WidgetStateColor.resolveWith(
                                              (_) => AppColors.primary,
                                            ),
                                        value: isRememberMe,
                                        onChanged: (_) {
                                          controller.toggleRememberMe();
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Remember me",
                                style: AppTextstyles.googleInter500LabelColor14,
                              ),
                            ],
                          ),
                          SizedBox(height: 60.h),
                          Consumer(
                            builder: (context, ref, child) {
                              final loginAuth = ref.watch(
                                loginAuthControllerProvider,
                              );
                              return CustomButton(
                                onPressed: loginAuth.isLoading
                                    ? null
                                    : () async {
                                        // Turn on auto-validation after first submit attempt
                                        if (!autoValidate) {
                                          ref
                                                  .read(
                                                    autoValidateFormModeProvider
                                                        .notifier,
                                                  )
                                                  .state =
                                              true;
                                        }
                                        if (_formKey.currentState!.validate()) {
                                          final LoginResponseModel? response =
                                              await ref
                                                  .read(
                                                    loginAuthControllerProvider
                                                        .notifier,
                                                  )
                                                  .login();
                                          if (response != null) {
                                            // ignore: unused_result
                                            ref.refresh(homeShellControllerProvider);
                                            ref
                                                .read(goRouterProvider)
                                                .go(AppRoutes.dashboard);
                                          }
                                        }
                                      },
                                text: "Login",
                                child: loginAuth.isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.white,
                                        ),
                                      )
                                    : null,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 56.w,
            top: 56.h,
            child: Consumer(
              builder: (context, ref, child) {
                return actionContainer(
                  padding: 12,
                  leftMargin: 0,
                  icon: AppImages.backIconSvg,
                  onTap: () {
                    ref.read(goRouterProvider).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
