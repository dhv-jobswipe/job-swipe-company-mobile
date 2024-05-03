import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pbl5/screens/login/components/custom_register.dart';
import 'package:pbl5/screens/login/components/sign_in_form.dart';
import 'package:pbl5/view_models/log_in_view_model.dart';
import 'package:pbl5/view_models/register_view_model.dart';

Future<Object?> customSigninDialog(
  BuildContext context, {
  required ValueChanged onClosed,
  required LogInViewModel logInViewModel,
  required RegisterViewModel registerViewModel,
  required String systemRoleId,
  required VoidCallback setBackgroundUp,
}) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Sign up",
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (ctx, _, __) => Center(
            child: Container(
              height: 620,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(40))),
              child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: false,
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        SignInForm(
                          viewModel: logInViewModel,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "OR",
                                style: TextStyle(color: Colors.black26),
                              ),
                            ),
                            Expanded(
                              child: Divider(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Text("Sign up with Email",
                              style: TextStyle(color: Colors.black54)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                Navigator.pop(ctx);
                                Future.delayed(Duration(milliseconds: 500), () {
                                  setBackgroundUp();
                                  customRegisterDialog(
                                    context,
                                    onClosed: onClosed,
                                    viewModel: registerViewModel,
                                    systemRoleId: systemRoleId,
                                  );
                                });
                              },
                              icon: SvgPicture.asset(
                                "assets/icons/email_box.svg",
                                height: 64,
                                width: 64,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Positioned(
                      left: 0,
                      right: 0,
                      bottom: -55,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.close, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )).then(onClosed);
}
