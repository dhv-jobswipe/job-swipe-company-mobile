// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/widgets/custom_container.dart';

class ExpansionPanelModel {
  Widget header;
  Widget body;
  Color? backgroundColor;
  bool isExpanded;
  Widget Function(BuildContext context, bool isExpanded)? headerBuilder;

  ExpansionPanelModel({
    required this.header,
    required this.body,
    this.backgroundColor,
    this.isExpanded = true,
    this.headerBuilder,
  });

  ExpansionPanelModel copyWith({
    Widget? header,
    Widget? body,
    Color? backgroundColor,
    bool? isExpanded,
    Widget Function(BuildContext context, bool isExpanded)? headerBuilder,
  }) =>
      ExpansionPanelModel(
          header: header ?? this.header,
          body: body ?? this.body,
          backgroundColor: backgroundColor ?? this.backgroundColor,
          isExpanded: isExpanded ?? this.isExpanded,
          headerBuilder: headerBuilder ?? this.headerBuilder);
}

class CustomExpansionList extends StatefulWidget {
  final List<ExpansionPanelModel> items;
  final void Function(int, bool)? onExpanded;
  final double elevation;
  final double materialGapSize;
  final Duration? animationDuration;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final Color? dividerColor;
  final Color? iconColor;
  final EdgeInsets headerPadding;
  final Alignment mainAlignment;
  final Alignment? headerAlignment;
  final Alignment? bodyAlignment;
  final bool isRadioMode;

  const CustomExpansionList({
    super.key,
    required this.items,
    this.onExpanded,
    this.elevation = 0,
    this.materialGapSize = 0,
    this.animationDuration,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
    this.dividerColor,
    this.iconColor,
    this.headerPadding = EdgeInsets.zero,
    this.mainAlignment = Alignment.centerLeft,
    this.headerAlignment,
    this.bodyAlignment,
    this.isRadioMode = false,
  });

  @override
  State<CustomExpansionList> createState() => _CustomExpansionListState();
}

class _CustomExpansionListState extends State<CustomExpansionList> {
  late List<ExpansionPanelModel> items;

  @override
  void initState() {
    items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    return CustomContainer(
      padding: widget.padding,
      color: widget.backgroundColor ?? theme.transparent,
      child: widget.isRadioMode
          ? ExpansionPanelList.radio(
              animationDuration:
                  widget.animationDuration ?? const Duration(milliseconds: 300),
              elevation: widget.elevation,
              materialGapSize: widget.materialGapSize,
              dividerColor: widget.dividerColor ?? theme.divider_primary,
              expandIconColor: widget.iconColor ?? theme.icon_primary,
              expandedHeaderPadding: widget.headerPadding,
              expansionCallback: widget.onExpanded,
              children: widget.items
                  .map((item) => ExpansionPanelRadio(
                        headerBuilder: (context, isExpanded) => Align(
                          alignment:
                              widget.headerAlignment ?? widget.mainAlignment,
                          child:
                              item.headerBuilder?.call(context, isExpanded) ??
                                  item.header,
                        ),
                        canTapOnHeader: true,
                        body: Align(
                            alignment:
                                widget.bodyAlignment ?? widget.mainAlignment,
                            child: item.body),
                        backgroundColor: item.backgroundColor,
                        value: item,
                      ))
                  .toList(),
            )
          : ExpansionPanelList(
              animationDuration:
                  widget.animationDuration ?? const Duration(milliseconds: 300),
              elevation: widget.elevation,
              materialGapSize: widget.materialGapSize,
              dividerColor: widget.dividerColor ?? theme.divider_primary,
              expandIconColor: widget.iconColor ?? theme.icon_primary,
              expandedHeaderPadding: widget.headerPadding,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  items[panelIndex].isExpanded = isExpanded;
                });
                widget.onExpanded?.call(panelIndex, isExpanded);
              },
              children: widget.items
                  .map((item) => ExpansionPanel(
                        headerBuilder: (context, isExpanded) => Align(
                          alignment:
                              widget.headerAlignment ?? widget.mainAlignment,
                          child:
                              item.headerBuilder?.call(context, isExpanded) ??
                                  item.header,
                        ),
                        canTapOnHeader: true,
                        body: Align(
                            alignment:
                                widget.bodyAlignment ?? widget.mainAlignment,
                            child: item.body),
                        backgroundColor:
                            item.backgroundColor ?? theme.transparent,
                        isExpanded: item.isExpanded,
                      ))
                  .toList(),
            ),
    );
  }
}
