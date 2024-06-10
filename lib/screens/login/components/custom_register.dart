import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/screens/login/components/register_form.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
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
      pageBuilder: (context, _, __) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;

        return GestureDetector(
          onTap: () {
            context.unfocus();
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Center(
              child: Container(
                height: 620.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40.r))),
                child: Scaffold(
                  backgroundColor: Colors.white,
                  resizeToAvoidBottomInset:
                      false, // avoid overflow error when keyboard shows up
                  body: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 34.sp, fontFamily: "Poppins"),
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
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: -55,
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.close, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).then(onClosed);
}
