import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/login/presentation/login_controller.dart';
import 'package:tgpl_network/utils/screen_size_extension.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(loginControllerProvider.notifier);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: false,
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final loginAuth = ref.watch(loginAuthControllerProvider);
          return CustomButton(
            onPressed: () {
              ref.read(loginAuthControllerProvider.notifier).login();
            },
            text: "Login",
            child: loginAuth.isLoading
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  )
                : null,
          );
        },
      ),
      backgroundColor: AppColors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: context.screenHeight * 0.15),
                SvgPicture.asset(AppImages.tajLogoSvg, width: 50, height: 50),
                const SizedBox(height: 28),
                Text(
                  "Welcome to TGPL",
                  style: AppTextstyles.googleInter700black28,
                ),
                const SizedBox(height: 10),
                Text(
                  "Please choose how you want to continue",
                  style: AppTextstyles.googleInter400black16,
                ),
                const SizedBox(height: 28),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CustomTextFieldWithTitle(
                        title: "Email",
                        hintText: "muhammadhuzaifakhan1133@gmail.com",
                        controller: controller.emailController,
                        validator: (v) => v.validateEmail(),
                        keyboardType: TextInputType.emailAddress,
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
                            title: "Passwrod",
                            hintText: "*******",
                            controller: controller.passwordController,
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
