import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/screens/login/components/register_form.dart';

import 'package:pbl5/view_models/register_view_model.dart';

Future<Object?> customRegisterDialog(
  BuildContext context, {
  required ValueChanged onClosed,
  required RegisterViewModel viewModel,
  required String systemRoleId,
}) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Register",
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) => Center(
            child: Container(
              height: 620,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(40))),
              child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset:
                    false, // avoid overflow error when keyboard shows up
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Expanded(
                          child: RegisterForm(
                            viewModel: viewModel,
                            systemRoleId: systemRoleId,
                          ),
                        ),
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
