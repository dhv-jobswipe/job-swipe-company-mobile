import 'package:flutter/material.dart';
import 'package:pbl5/app_common_data/app_text_sytle.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/routes.dart';
import 'package:pbl5/screens/base/base_view.dart';
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
import 'package:pbl5/view_models/change_password_view_model.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final ChangePasswordViewModel viewModel;

  initState() {
    viewModel = getIt<ChangePasswordViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: viewModel,
      mobileBuilder: (context) {
        return CustomDismissKeyboard(
          canPop: true,
          child: CustomForm(
            child: (formKey) => CustomLayout.scrollableView(
              backgroundColor: Colors.white,
              showAppBar: false,
              onWillPop: () => Future.value(true),
              paddingAll: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "Change Password",
                    style: AppTextStyle.bigTitleText,
                    size: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    "Please enter your current password and new password to change your password.",
                    style: AppTextStyle.defaultStyle,
                    size: 15,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    label: "Current password",
                    placeholder: "Enter your current password",
                    activeBorderColor: Colors.pink,
                    validations: [Validators.validatePassword],
                    obscureText: true,
                    onChanged: (value) {
                      viewModel.currentPwd = value;
                      viewModel.updateUI();
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    label: "New password",
                    placeholder: "Enter your new password",
                    activeBorderColor: Colors.pink,
                    obscureText: true,
                    validations: [
                      (data) => Validators.validatePassword(data, isNew: true),
                      (data) => Validators.validateNewPwdNotSameOldPwd(
                          viewModel.currentPwd, viewModel.newPwd)
                    ],
                    onChanged: (value) {
                      viewModel.newPwd = value;
                      viewModel.updateUI();
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    label: "Confirm new password",
                    placeholder: "Enter your new password again",
                    activeBorderColor: Colors.pink,
                    obscureText: true,
                    validations: [
                      (data) => Validators.validateConfirmPassword(
                          viewModel.newPwd, data,
                          isNewConfirmPwd: true)
                    ],
                    onChanged: (value) {
                      viewModel.confirmNewPwd = value;
                      viewModel.updateUI();
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    label: "Change password",
                    width: context.screenSize.width,
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        viewModel.changePassword(
                          onSuccess: () {
                            showSuccessDialog(
                              context,
                              title: "Change password successfully",
                              content:
                                  "Your password has been changed successfully. Please login again to continue.",
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
                  Center(
                    child: CustomTextButton(
                      text: CustomText(
                        "Back to previous screen",
                        color: Colors.pinkAccent,
                      ),
                      onPressed: context.pop,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
