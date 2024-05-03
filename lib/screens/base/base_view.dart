import 'package:flutter/material.dart';
import 'package:pbl5/screens/base/responsive.dart';
import 'package:pbl5/shared_customization/extensions/list_ext.dart';
import 'package:pbl5/view_models/base_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class BaseView<VM extends BaseViewModel?> extends StatelessWidget {
  final VM? viewModel;
  final List<SingleChildWidget> providers;
  final Color? backgroundColor;
  final Widget Function(BuildContext)? bottomNavigationBuilder;
  final Widget Function(BuildContext) mobileBuilder;
  final Widget Function(BuildContext)? desktopBuilder;
  final Widget Function(BuildContext)? tabletBuilder;
  final bool resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;
  final bool canPop;

  BaseView({
    super.key,
    this.viewModel,
    this.backgroundColor,
    this.bottomNavigationBuilder,
    required this.mobileBuilder,
    this.desktopBuilder,
    this.tabletBuilder,
    this.resizeToAvoidBottomInset = false,
    this.appBar,
    this.canPop = false,
  }) : providers = [];

  BaseView.multi({
    super.key,
    required this.providers,
    this.backgroundColor,
    this.bottomNavigationBuilder,
    required this.mobileBuilder,
    this.desktopBuilder,
    this.tabletBuilder,
    this.resizeToAvoidBottomInset = false,
    this.appBar,
    this.canPop = false,
  }) : viewModel = null;

  @override
  Widget build(BuildContext context) => _buildProvider(context);

  Widget _buildProvider(BuildContext context) {
    // Single provider
    if (viewModel != null) {
      return ChangeNotifierProvider.value(
        value: viewModel!,
        builder: (ctx, _) => _buildBody(ctx),
      );
    }
    // Multi provider
    if (providers.isNotEmptyOrNull) {
      return MultiProvider(
        providers: providers,
        builder: (ctx, _) => _buildBody(ctx),
      );
    }
    // No provider
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: appBar,
        body:
            // OrientationBuilder(
            //   builder: (ctx, __) {
            //     return
            Responsive(
          mobile: mobileBuilder.call(context),
          tablet: tabletBuilder?.call(context),
        ),
        //   },
        // ),
        bottomNavigationBar: bottomNavigationBuilder?.call(context),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
