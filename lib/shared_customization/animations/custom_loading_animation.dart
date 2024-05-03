import 'package:flutter/material.dart';
import '/shared_customization/extensions/build_context.ext.dart';

class CustomLoadingAnimation extends StatelessWidget {
  final Color? color;
  const CustomLoadingAnimation({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? context.appTheme.appThemeData.icon_primary,
      strokeWidth: 4,
    );
  }
}
