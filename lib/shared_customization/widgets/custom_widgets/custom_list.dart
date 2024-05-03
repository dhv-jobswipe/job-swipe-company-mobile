// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/generated/translations.g.dart';
import '../../../services/api_models/api_page_response/api_page_response.dart';
import '/shared_customization/animations/custom_loading_animation.dart';
import '/shared_customization/data/debouncer.dart';
import '/shared_customization/extensions/paging_ext.dart';
import '/shared_customization/extensions/scroll_controller_ext.dart';
import '/shared_customization/widgets/custom_refresh_indicator.dart';
import '/shared_customization/widgets/texts/custom_text.dart';

class CustomList<T> extends StatefulWidget {
  final ScrollController? scrollController;
  final Future<void> Function() onReload;
  final Future Function(int page)? onLoadMore;
  final Widget Function(T item) onItemRender;
  final ApiPageResponse<T>? sourceData;
  final String? errorMessage;
  final EdgeInsets padding;
  final Widget? emptyListIcon;
  final Widget? separatedWidget;
  final Widget? prefixListWidget;
  final double mainAxisSpacing;

  const CustomList({
    super.key,
    this.scrollController,
    required this.sourceData,
    required this.onItemRender,
    required this.onReload,
    this.onLoadMore,
    this.errorMessage,
    this.emptyListIcon,
    this.separatedWidget,
    this.prefixListWidget,
    this.padding = EdgeInsets.zero,
    this.mainAxisSpacing = 0,
  });

  @override
  State<CustomList<T>> createState() => _CustomListState<T>();
}

class _CustomListState<T> extends State<CustomList<T>> {
  late final ScrollController _scrollController =
      widget.scrollController ?? ScrollController();
  List<T>? get sources => widget.sourceData?.data;
  bool isLoadingMore = false;
  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 100));

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onScrollHandle);
  }

  @override
  void dispose() {
    _scrollController.removeListener(onScrollHandle);
    super.dispose();
  }

  void onScrollHandle() {
    if (widget.onLoadMore != null &&
        _scrollController.loadMorePointPassed &&
        (widget.sourceData?.paging?.canNextPage ?? false) &&
        !isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      _debouncer.call(() {
        widget.onLoadMore
            ?.call(widget.sourceData!.paging!.nextPage)
            .then((value) {
          setState(() {
            isLoadingMore = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomRefreshIndicator(
          onRefresh: widget.onReload,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  maxHeight: widget.errorMessage != null ||
                          (sources == null || sources!.isEmpty)
                      ? constraints.maxHeight
                      : double.infinity),
              width: constraints.maxWidth,
              padding: widget.padding.copyWith(
                  bottom: widget.padding.bottom +
                      MediaQuery.of(context).padding.bottom),
              child: Column(
                mainAxisAlignment: widget.errorMessage != null ||
                        (sources == null || sources!.isEmpty)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  ///
                  /// Error message
                  ///
                  if (widget.errorMessage != null) ...[
                    Center(
                      child: CustomText(
                        widget.errorMessage ?? "",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]

                  ///
                  /// Loading
                  ///
                  else if (sources == null)
                    const Center(child: CustomLoadingAnimation())

                  ///
                  /// Sources empty
                  ///
                  else if (sources != null && sources!.isEmpty) ...[
                    if (widget.emptyListIcon != null)
                      widget.emptyListIcon!
                    else
                      Center(
                        child: CustomText(
                          tr(LocaleKeys.CommonData_ListDataIsEmpty),
                          color: theme.text_placeholder,
                          fontWeight: FontWeight.w600,
                          size: 18,
                          textAlign: TextAlign.center,
                        ),
                      )
                  ]

                  ///
                  /// Render list
                  ///
                  else
                    ...List.generate(sources!.length, (index) => index)
                        .fold<List<Widget>>(
                            <Widget>[],
                            (previousValue, index) => [
                                  ...previousValue,
                                  widget.onItemRender(sources![index]),
                                  if (widget.separatedWidget != null &&
                                      index < sources!.length - 1)
                                    widget.separatedWidget!,
                                  if (widget.mainAxisSpacing > 0)
                                    SizedBox(
                                      height: widget.mainAxisSpacing,
                                    )
                                ]),

                  ///
                  /// Loading more
                  ///
                  if (isLoadingMore)
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const CustomLoadingAnimation(),
                      const SizedBox(width: 8),
                      CustomText(tr(LocaleKeys.CommonData_LoadingMore))
                    ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
