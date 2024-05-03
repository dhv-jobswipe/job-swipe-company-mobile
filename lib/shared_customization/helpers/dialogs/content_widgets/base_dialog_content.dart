import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/widgets/custom_container.dart';

class BaseDialogContent extends StatelessWidget {
  final Widget Function(BuildContext context) builder;
  const BaseDialogContent({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return CustomContainer(
      color: theme.white,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      width: MediaQuery.of(context).size.width,
      child: builder.call(context),
    );
  }
}
