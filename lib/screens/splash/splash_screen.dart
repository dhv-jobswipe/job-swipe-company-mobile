import 'package:flutter/material.dart';
import 'package:pbl5/generated/assets.gen.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/screens/login/integrated_auth_screen.dart';
import 'package:pbl5/screens/main/main_screen.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/storages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      /// Get user
      var sp = getIt.get<CustomSharedPreferences>();
      User? user;
      if (sp.accessToken.isNotEmptyOrNull) {
        try {
          user =
              (await getIt.get<AuthenticationRepositoty>().getAccount()).data;
        } catch (e) {
          user = null;
        }
      }
      debugPrint("Starting app with user: ${user?.toJson()}".debug);
      context.pushRoute(
          (context) => user != null ? MainScreen() : IntegratedAuthScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Assets.images.logoDash.image(),
      ),
    );
  }
}
