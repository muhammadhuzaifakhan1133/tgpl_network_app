import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/change_password/change_password_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/utils/screen_size_extension.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class ChangePasswordView extends ConsumerWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(changePasswordControllerProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: ListView(
                children: [
                  SizedBox(height: context.screenHeight * 0.15),
                  // SvgPicture.asset(AppImages.tajLogoSvg, width: 50, height: 50),
                  const SizedBox(height: 28),
                  Text(
                    "Change Password",
                    style: AppTextstyles.googleInter700black28,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Type your old and new password",
                    style: AppTextstyles.googleInter400black16,
                  ),
                  const SizedBox(height: 28),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final isPasswordObscure = ref.watch(
                              changePasswordControllerProvider.select(
                                (state) => state.isPasswordObscure,
                              ),
                            );
                            return CustomTextFieldWithTitle(
                              title: "Old Passwrod",
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
                        Consumer(
                          builder: (context, ref, child) {
                            final isPasswordObscure = ref.watch(
                              changePasswordControllerProvider.select(
                                (state) => state.isNewPasswordObscure,
                              ),
                            );
                            return CustomTextFieldWithTitle(
                              title: "New Passwrod",
                              hintText: "*******",
                              controller: controller.newPasswordController,
                              obscureText: isPasswordObscure,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.toggleNewPasswordObscure();
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
                        Consumer(
                          builder: (context, ref, child) {
                            final isPasswordObscure = ref.watch(
                              changePasswordControllerProvider.select(
                                (state) => state.isNewPasswordObscure,
                              ),
                            );
                            return CustomTextFieldWithTitle(
                              title: "Confirm Passwrod",
                              hintText: "*******",
                              controller:
                                  controller.passwordConfirmationController,
                              obscureText: isPasswordObscure,
                              validator: (v) => v.validateSameValue(
                                value: controller.newPasswordController.text,
                                message: "Password does not match",
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 28),
                        Consumer(
                          builder: (context, ref, child) {
                            final changePasswordAsync = ref.watch(
                              changePasswordAsyncControllerProvider,
                            );
                            return CustomButton(
                              onPressed: () {
                                ref
                                    .read(
                                      changePasswordAsyncControllerProvider
                                          .notifier,
                                    )
                                    .changePassword();
                              },
                              text: "Confirm Change",
                              child: changePasswordAsync.isLoading
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
          Positioned(
            left: 20,
            top: 40,
            child: Consumer(
              builder: (context, ref, child) {
                return InkWell(
                  onTap: () {
                    ref.read(goRouterProvider).pop();
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    color: AppColors.actionContainerColor,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
