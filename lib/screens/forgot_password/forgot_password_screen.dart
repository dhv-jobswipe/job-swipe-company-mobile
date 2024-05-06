import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/app_text_sytle.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/routes.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/reset_password/reset_password_screen.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/validators.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_button.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_text_button.dart';
import 'package:pbl5/shared_customization/widgets/custom_layout.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_dismiss_keyboard.dart';
import 'package:pbl5/shared_customization/widgets/form_fields/custom_form.dart';
import 'package:pbl5/shared_customization/widgets/form_fields/custom_text_form_field.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:pbl5/view_models/forgot_password_view_model.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final ForgotPasswordViewModel viewModel;

  initState() {
    viewModel = getIt<ForgotPasswordViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: viewModel,
      mobileBuilder: (context) => CustomDismissKeyboard(
        child: CustomForm(
          key: Key("forgot_password_form"),
          child: (formKey) => CustomLayout.scrollableView(
            showAppBar: false,
            onWillPop: () => Future.value(true),
            paddingAll: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Forgot Password",
                  style: AppTextStyle.bigTitleText,
                  size: 25,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  "Please enter your email address. You will receive a link to create a new password via email.",
                  style: AppTextStyle.defaultStyle,
                  size: 15,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 25),
                CustomTextFormField(
                  label: "Email",
                  placeholder: "Enter your email...",
                  activeBorderColor: Colors.pink,
                  validations: [Validators.validateEmail],
                  onChanged: (value) {
                    viewModel.email = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomButton(
                  label: "Forgot password",
                  width: context.screenSize.width,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      viewModel.sendForgotPasswordRequest(
                        onSuccess: () {
                          showSuccessDialog(
                            context,
                            title: "Forgot password",
                            content:
                                "Your request has been sent successfully. Please check your email.",
                          ).whenComplete(() {
                            context.popAndPushNamed(Routes.resetPassword,
                                arguments:
                                    ResetPasswordScreenArgs(viewModel.email!));
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
                Center(
                  child: CustomTextButton(
                    text: CustomText(
                      "Back to login",
                      color: Colors.pinkAccent,
                    ),
                    onPressed: context.pop,
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
