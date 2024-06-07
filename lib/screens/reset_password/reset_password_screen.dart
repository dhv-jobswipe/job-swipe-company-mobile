import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/app_text_sytle.dart';
import 'package:pbl5/app_common_data/common_data/global_variable.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/routes.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/shared_customization/enums/keyboard_type.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/banner_helper.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/validators.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_button.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_text_button.dart';
import 'package:pbl5/shared_customization/widgets/custom_layout.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_dismiss_keyboard.dart';
import 'package:pbl5/shared_customization/widgets/form_fields/custom_form.dart';
import 'package:pbl5/shared_customization/widgets/form_fields/custom_text_form_field.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:pbl5/view_models/reset_password_view_model.dart';

class ResetPasswordScreenArgs {
  final String email;

  ResetPasswordScreenArgs(this.email);
}

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.args});
  final ResetPasswordScreenArgs args;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final ResetPasswordViewModel viewModel;

  @override
  void initState() {
    viewModel = getIt.get<ResetPasswordViewModel>();
    viewModel.init(widget.args.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: viewModel,
      mobileBuilder: (context) => CustomDismissKeyboard(
        canPop: false,
        child: CustomLayout.scrollableView(
          backgroundColor: Colors.white,
          onWillPop: () => Future.value(false),
          showAppBar: false,
          leading: EMPTY_WIDGET,
          child: CustomForm(
            child: (formKey) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Reset Password",
                  style: AppTextStyle.bigTitleText,
                  size: 25,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  "Please enter reset password code from your email and new password. If you don't receive the email, please check your spam folder or resend the email",
                  style: AppTextStyle.defaultStyle,
                  size: 15,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 25),
                CustomTextFormField(
                  label: "Reset password code",
                  placeholder: "Enter your reset password code...",
                  activeBorderColor: Colors.pink,
                  keyboardType: KeyboardType.int,
                  validations: [
                    (data) => data.isEmptyOrNull
                        ? "Reset password code is required"
                        : null,
                    (data) => RegExp(r"^(\d{6})$").hasMatch(data ?? '')
                        ? null
                        : "Reset password code must be a number with 6 digits"
                  ],
                  onChanged: (value) {
                    viewModel.resetPwdCode = value;
                    viewModel.updateUI();
                  },
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  label: "New password",
                  placeholder: "Enter your new password...",
                  activeBorderColor: Colors.pink,
                  validations: [
                    (data) => Validators.validatePassword(data, isNew: true),
                  ],
                  obscureText: true,
                  onChanged: (value) {
                    viewModel.newPwd = value;
                    viewModel.updateUI();
                  },
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  label: "Confirm password",
                  placeholder: "Enter your confirm password...",
                  activeBorderColor: Colors.pink,
                  validations: [
                    (data) => Validators.validateConfirmPassword(
                        viewModel.newPwd, data,
                        isNewConfirmPwd: true)
                  ],
                  obscureText: true,
                  onChanged: (value) {
                    viewModel.confirmPwd = value;
                    viewModel.updateUI();
                  },
                ),
                const SizedBox(height: 25),
                CustomButton(
                  label: "Reset password",
                  width: context.screenSize.width,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      viewModel.resetPassword(
                        onSuccess: () {
                          showSuccessDialog(
                            context,
                            title: "Reset password",
                            content: "Reset password successfully",
                          ).whenComplete(() {
                            context.popAndPushNamed(Routes.integratedAuth);
                          });
                        },
                        onFail: (error) {
                          showErrorDialog(context, content: error);
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 12),
                CustomButton.resend(
                  label: "Resend reset password code",
                  width: context.screenSize.width,
                  countDownText: (currentMilliseconds) =>
                      "Resend in ${currentMilliseconds ~/ 1000} seconds",
                  duration: const Duration(minutes: 3),
                  periodicDuration: const Duration(seconds: 1),
                  onPressed: () {
                    viewModel.resendForgotPasswordRequest(
                      onSuccess: () => showSuccessBanner(
                          content: "Resend email successfully"),
                      onFail: (error) =>
                          showErrorDialog(context, content: error),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Center(
                  child: CustomTextButton(
                    text: CustomText(
                      "Back to login",
                      color: Colors.pinkAccent,
                    ),
                    onPressed: () => context.pushNamed(Routes.integratedAuth),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
