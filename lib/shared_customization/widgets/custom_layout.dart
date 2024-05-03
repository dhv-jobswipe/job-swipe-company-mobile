// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/widgets/buttons/custom_icon_button.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/shared_customization/widgets/buttons/custom_button.dart';
import '/shared_customization/widgets/custom_container.dart';

class CustomLayout extends StatefulWidget {
  final bool useSafeArea;
  final Widget body;
  final String? title;
  final Widget? titleWidget;
  final bool showAppBar;
  final double elevation;
  final bool resizeToAvoidBottomInset;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? appbarShadowColor;
  final Color? appBarColor;
  final Color? statusBarColor;
  final Color? titleColor;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Future<bool> Function()? onWillPop;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final double? leadingWidth;

  const CustomLayout({
    super.key,
    required this.body,
    this.useSafeArea = true,
    this.title,
    this.titleWidget,
    this.showAppBar = true,
    this.elevation = 0,
    this.resizeToAvoidBottomInset = true,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.appbarShadowColor,
    this.appBarColor,
    this.statusBarColor,
    this.titleColor,
    this.bottomNavigationBar,
    this.drawer,
    this.onWillPop,
    this.floatingActionButton,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.leadingWidth,
  });

  CustomLayout.scrollableView({
    super.key,
    this.title,
    this.titleWidget,
    this.showAppBar = true,
    this.elevation = 0,
    this.resizeToAvoidBottomInset = true,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.appbarShadowColor,
    this.appBarColor,
    this.statusBarColor,
    this.titleColor,
    this.bottomNavigationBar,
    this.drawer,
    this.onWillPop,
    this.floatingActionButton,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.leadingWidth,
    required Widget child,
    EdgeInsetsGeometry paddingAll = const EdgeInsets.all(16),
  })  : useSafeArea = true,
        body = LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: CustomContainer(
                padding: paddingAll,
                constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth),
                child: child,
              ),
            );
          },
        );

  CustomLayout.buttonNextPage({
    super.key,
    this.title,
    this.titleWidget,
    this.showAppBar = true,
    this.elevation = 0,
    this.resizeToAvoidBottomInset = true,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.appbarShadowColor,
    this.appBarColor,
    this.statusBarColor,
    this.titleColor,
    this.bottomNavigationBar,
    this.drawer,
    this.onWillPop,
    this.floatingActionButton,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.leadingWidth,
    required Widget child,
    required VoidCallback onButtonTap,
    String? buttonLabel,
    EdgeInsetsGeometry paddingAll = const EdgeInsets.all(16),
  })  : useSafeArea = true,
        body = LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: CustomContainer(
                padding: paddingAll,
                constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    child,
                    CustomButton(
                        label: buttonLabel,
                        onPressed: onButtonTap,
                        width: constraints.maxWidth,
                        margin: const EdgeInsets.only(top: 16))
                  ],
                ),
              ),
            );
          },
        );

  @override
  State<CustomLayout> createState() => _CustomLayoutState();
}

class _CustomLayoutState extends State<CustomLayout> {
  late AppThemeData theme;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: widget.backgroundColor ?? theme.layout_bg,
        systemNavigationBarDividerColor:
            widget.backgroundColor ?? theme.layout_bg,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: widget.statusBarColor ?? theme.layout_status_bar,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: true,
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = context.appTheme.appThemeData;
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? theme.layout_bg,
      drawer: widget.drawer,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: !widget.showAppBar
          ? null
          : AppBar(
              toolbarHeight: widget.showAppBar ? null : 0,
              shadowColor: widget.appbarShadowColor ?? theme.transparent,
              elevation: widget.elevation,
              backgroundColor: widget.appBarColor ?? theme.layout_app_bar,
              systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor:
                    widget.backgroundColor ?? theme.layout_bg,
                systemNavigationBarDividerColor:
                    widget.backgroundColor ?? theme.layout_bg,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarColor:
                    widget.statusBarColor ?? theme.layout_status_bar,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark,
                systemStatusBarContrastEnforced: true,
              ),
              leadingWidth: widget.leadingWidth,
              leading: Builder(
                builder: (context) {
                  Widget widgetBuilder = const SizedBox.shrink();
                  if (widget.leading != null) {
                    widgetBuilder = widget.leading!;
                  } else if (widget.drawer != null) {
                    widgetBuilder = CustomIconButton(
                      onPressed: context.openDrawer,
                      icon: Icons.menu_rounded,
                      size: 23,
                      color: [
                        theme.primary_color,
                        theme.primary_dark_color,
                        theme.primary_light_color
                      ].contains(widget.appBarColor ?? theme.layout_app_bar)
                          ? theme.white
                          : theme.icon_primary,
                    );
                  } else {
                    widgetBuilder = CustomIconButton(
                      onPressed: () {
                        widget.onWillPop?.call().then((value) {
                          if (value != false) {
                            Navigator.of(context).pop();
                          }
                        });
                      },
                      size: 23,
                      color: [
                        theme.primary_color,
                        theme.primary_dark_color,
                        theme.primary_light_color
                      ].contains(widget.appBarColor ?? theme.layout_app_bar)
                          ? theme.white
                          : theme.icon_primary,
                      icon: Icons.arrow_back_ios,
                    );
                  }
                  return widgetBuilder;
                },
              ),
              titleSpacing: 0,
              centerTitle: true,
              title: widget.titleWidget ??
                  CustomText(
                    widget.title ?? "",
                    textAlign: TextAlign.center,
                    size: 18,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    color: widget.titleColor ??
                        ([
                          theme.primary_color,
                          theme.primary_dark_color,
                          theme.primary_light_color
                        ].contains(widget.appBarColor ?? theme.layout_app_bar)
                            ? theme.white
                            : theme.primary_color),
                  ),
              actions: widget.actions,
            ),
      body: SafeArea(
        top: widget.useSafeArea,
        bottom: widget.useSafeArea,
        child: widget.body,
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}
