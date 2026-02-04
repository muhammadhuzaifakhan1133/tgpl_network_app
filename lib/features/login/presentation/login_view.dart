import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/login/models/login_response_model.dart';
import 'package:tgpl_network/features/login/presentation/login_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/extensions/screen_size_extension.dart';
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                SizedBox(height: context.screenHeight * 0.15),
                SvgPicture.asset(AppImages.tajLogoSvg, width: 50, height: 50),
                const SizedBox(height: 28),
                Text(
                  "Welcome to TGPL",
                  textAlign: TextAlign.center,
                  style: AppTextstyles.googleInter700black28,
                ),
                const SizedBox(height: 10),
                Text(
                  "Please choose how you want to continue",
                  textAlign: TextAlign.center,
                  style: AppTextstyles.googleInter400black16,
                ),
                const SizedBox(height: 28),
                Form(
                  key: _formKey,
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
                      const SizedBox(height: 16),
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
                              ),
                            ),
                            validator: (v) => v.validate(),
                            onChanged: (v) {
                              controller.setPassword(v);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
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
                                padding: const EdgeInsets.all(3.96),
                                child: SizedBox(
                                  width: 11.8,
                                  height: 11.8,
                                  child: Checkbox(
                                    activeColor: WidgetStateColor.resolveWith(
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
                          const SizedBox(width: 5),
                          Text(
                            "Remember me",
                            style: AppTextstyles.googleInter500LabelColor14,
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Consumer(
                        builder: (context, ref, child) {
                          final loginAuth = ref.watch(
                            loginAuthControllerProvider,
                          );
                          return CustomButton(
                            onPressed: loginAuth.isLoading ? null : () async {
                              if (_formKey.currentState!.validate()) {
                                final LoginResponseModel? response = await ref
                                    .read(loginAuthControllerProvider.notifier)
                                    .login();
                                if (response != null) {
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
    );
  }
}
