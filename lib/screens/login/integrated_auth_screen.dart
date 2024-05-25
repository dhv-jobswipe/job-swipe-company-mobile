import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/login/components/animated_btn.dart';
import 'package:pbl5/screens/login/components/custom_sign_in.dart';
import 'package:pbl5/view_models/integrated_auth_view_model.dart';
import 'package:pbl5/view_models/log_in_view_model.dart';
import 'package:pbl5/view_models/register_view_model.dart';
import 'package:rive/rive.dart';

class IntegratedAuthScreen extends StatefulWidget {
  const IntegratedAuthScreen({super.key});

  @override
  State<IntegratedAuthScreen> createState() => _IntegratedAuthScreenState();
}

class _IntegratedAuthScreenState extends State<IntegratedAuthScreen> {
  late LogInViewModel logInViewModel;
  late RegisterViewModel registerViewModel;
  late IntegratedAuthViewModel integratedAuthViewModel;

  bool isSignInDialogShown = false;
  bool isDialogClosing = false;
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation("active", autoplay: false);
    logInViewModel = GetIt.instance.get<LogInViewModel>();
    registerViewModel = GetIt.instance.get<RegisterViewModel>();
    integratedAuthViewModel = GetIt.instance.get<IntegratedAuthViewModel>()
      ..getSystemRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: integratedAuthViewModel,
      mobileBuilder: (context) => Stack(
        children: [
          Positioned(
              width: MediaQuery.of(context).size.width * 1.7,
              bottom: 200,
              left: 100,
              child: Image.asset('assets/Backgrounds/Spline.png')),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
          )),
          const RiveAnimation.asset('assets/RiveAssets/shapes.riv'),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
            child: const SizedBox(),
          )),
          AnimatedPositioned(
            duration: Duration(milliseconds: 240),
            top: isSignInDialogShown ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    const SizedBox(
                      width: 260,
                      child: Column(
                        children: [
                          Text(
                            "Find your dream job",
                            style: TextStyle(
                                fontSize: 60,
                                fontFamily: "Poppins",
                                height: 1.2),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Welcome to our job finding app! Swipe to explore jobs and companies. Start your career journey with us today.",
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        if (!isSignInDialogShown && !isDialogClosing) {
                          isSignInDialogShown = true;
                          _btnAnimationController.isActive = true;
                          Future.delayed(Duration(milliseconds: 750), () {
                            customSigninDialog(context,
                                logInViewModel: logInViewModel,
                                registerViewModel: registerViewModel,
                                setBackgroundUp: () {
                                  isSignInDialogShown = true;
                                },
                                systemRoleId: integratedAuthViewModel
                                        .getCompanySystemRoleId() ??
                                    '',
                                onClosed: (_) {
                                  isDialogClosing = true;
                                  Future.delayed(Duration(milliseconds: 750),
                                      () {
                                    isSignInDialogShown = false;
                                    isDialogClosing = false;
                                  });
                                });
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 180,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
