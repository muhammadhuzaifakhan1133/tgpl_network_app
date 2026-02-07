import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/change_password/change_password_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/utils/extensions/screen_size_extension.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({super.key});

  @override
  ConsumerState<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(changePasswordControllerProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: ListView(
                children: [
                  SizedBox(height: context.screenHeight * 0.15),
                  // SvgPicture.asset(AppImages.tajLogoSvg, width: 50, height: 50),
                  SizedBox(height: 28.h),
                  Text(
                    "Change Password",
                    style: AppTextstyles.googleInter700black28,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Type your old and new password",
                    style: AppTextstyles.googleInter400black16,
                  ),
                  SizedBox(height: 28.h),
                  Form(
                    key: _formKey,
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
                              title: "Old Password",
                              hintText: "*******",
                              onChanged: (v) {
                                controller.setOldPassword(v);
                              },
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
                        SizedBox(height: 16.h),
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
                              onChanged: (v) {
                                controller.setNewPassword(v);
                              },
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
                        SizedBox(height: 16.h),
                        Consumer(
                          builder: (context, ref, child) {
                            final isPasswordObscure = ref.watch(
                              changePasswordControllerProvider.select(
                                (state) => state.isNewPasswordObscure,
                              ),
                            );
                            return CustomTextFieldWithTitle(
                              title: "Confirm Password",
                              hintText: "*******",
                              onChanged: (v) {
                                controller.setPasswordConfirmation(v);
                              },
                              obscureText: isPasswordObscure,
                              validator: (v) => v.validateSameValue(
                                value:
                                    ref
                                        .read(changePasswordControllerProvider)
                                        .newPassword ??
                                    '',
                                message: "Password does not match",
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 28.h),
                        Consumer(
                          builder: (context, ref, child) {
                            final changePasswordAsync = ref.watch(
                              changePasswordAsyncControllerProvider,
                            );
                            return CustomButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(
                                        changePasswordAsyncControllerProvider
                                            .notifier,
                                      )
                                      .changePassword();
                                }
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
            left: 20.w,
            top: 40.h,
            child: Consumer(
              builder: (context, ref, child) {
                return InkWell(
                  onTap: () {
                    ref.read(goRouterProvider).pop();
                  },
                  child: Container(
                    width: 35.w,
                    height: 35.h,
                    color: AppColors.actionContainerColor,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 16.w,
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
