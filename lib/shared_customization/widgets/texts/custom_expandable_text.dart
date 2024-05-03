// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/enums/expandable_text_view_mode.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/generated/translations.g.dart';
import '/app_common_data/app_text_sytle.dart';

class CustomExpandableText extends StatefulWidget {
  const CustomExpandableText(
    this.text, {
    super.key,
    this.style,
    this.expandText,
    this.textDirection,
    this.textAlign,
    this.textScaleFactor,
    this.maxLines = 3,
    this.collapseText,
    this.initiallyExpanded = false,
    this.onExpandedChanged,
    this.linkColor,
    this.linkStyle,
    this.expandOnTextTap = false,
    this.collapseOnTextTap = false,
    this.animation = true,
    this.animationDuration,
    this.animationCurve,
    this.viewMoreMode = ExpandableTextViewMode.inline,
  });

  final String text;
  final TextStyle? style;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final double? textScaleFactor;
  final int maxLines;
  final String? expandText;
  final String? collapseText;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpandedChanged;
  final Color? linkColor;
  final TextStyle? linkStyle;
  final bool expandOnTextTap;
  final bool collapseOnTextTap;
  final bool animation;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final ExpandableTextViewMode viewMoreMode;

  @override
  State<CustomExpandableText> createState() => _CustomExpandableTextState();
}

class _CustomExpandableTextState extends State<CustomExpandableText> {
  bool _expanded = false;
  late TapGestureRecognizer _linkTapGestureRecognizer;

  @override
  void initState() {
    _expanded = widget.initiallyExpanded;
    _linkTapGestureRecognizer = TapGestureRecognizer()..onTap = _toggleExpanded;
    super.initState();
  }

  @override
  void dispose() {
    _linkTapGestureRecognizer.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
      widget.onExpandedChanged?.call(_expanded);
    });
  }

  void _expandText() => setState(() => _expanded = true);
  void _collapseText() => setState(() => _expanded = false);

  @override
  Widget build(BuildContext context) {
    AppThemeData theme = context.appTheme.appThemeData;
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    var effectiveTextStyle = widget.style ?? AppTextStyle.defaultStyle;
    if ((widget.style ?? AppTextStyle.defaultStyle).inherit) {
      effectiveTextStyle = defaultTextStyle.style
          .merge((widget.style ?? AppTextStyle.defaultStyle));
    }

    ///
    /// Element (link) which can expand or collapse text
    ///
    final linkText = _expanded
        ? (widget.collapseText ??
            localization.tr(LocaleKeys.CommonAction_ShowLess))
        : (widget.expandText ??
            localization.tr(LocaleKeys.CommonAction_ShowMore));
    final linkColor =
        widget.linkColor ?? widget.linkStyle?.color ?? theme.primary_color;
    final linkTextStyle = (widget.linkStyle ?? AppTextStyle.defaultStyle)
        .copyWith(color: linkColor);

    final link = TextSpan(
      children: [
        if (!_expanded)
          TextSpan(
            text: '\u2026 ',
            style: effectiveTextStyle,
          ),
        if (linkText.isNotEmptyOrNull)
          TextSpan(
            style: linkTextStyle,
            children: [
              if (_expanded) const TextSpan(text: ' '),
              TextSpan(
                text: linkText,
                style: linkTextStyle,
                recognizer: _linkTapGestureRecognizer,
              ),
            ],
          ),
      ],
    );

    ///
    /// Content text
    ///
    final content = TextSpan(text: widget.text, style: effectiveTextStyle);

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        final textAlign =
            widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.left;
        final textDirection = widget.textDirection ?? TextDirection.ltr;
        final textScaleFactor =
            widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
        final locale = Localizations.maybeLocaleOf(context);

        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.maxLines,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        textPainter.text = content;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        if (textPainter.didExceedMaxLines) {
          switch (widget.viewMoreMode) {
            case ExpandableTextViewMode.inline:
              final position = textPainter.getPositionForOffset(Offset(
                textSize.width - linkSize.width,
                textSize.height,
              ));
              final endOffset =
                  (textPainter.getOffsetBefore(position.offset) ?? 0);

              final recognizer = (_expanded
                      ? widget.collapseOnTextTap
                      : widget.expandOnTextTap)
                  ? _linkTapGestureRecognizer
                  : null;

              final text = TextSpan(
                  text: _expanded
                      ? widget.text
                      : widget.text.substring(0, max(endOffset, 0)),
                  recognizer: recognizer);

              var textSpan =
                  TextSpan(style: effectiveTextStyle, children: [text, link]);

              var richText = RichText(
                  text: textSpan,
                  softWrap: true,
                  textDirection: textDirection,
                  textAlign: textAlign,
                  textScaleFactor: textScaleFactor,
                  overflow: TextOverflow.clip);

              if (widget.animation) return _buildAnimatedSize(richText);
              return richText;
            case ExpandableTextViewMode.underline:
              var linkBuilder = !_expanded
                  ? GestureDetector(
                      onTap: _expandText,
                      child: CustomText(
                          widget.expandText ??
                              localization.tr(LocaleKeys.CommonAction_ShowMore),
                          style: linkTextStyle))
                  : GestureDetector(
                      onTap: _collapseText,
                      child: CustomText(
                          widget.collapseText ??
                              localization.tr(LocaleKeys.CommonAction_ShowLess),
                          style: linkTextStyle));
              Widget widgetBuilder = !_expanded
                  ? CustomText(
                      widget.text,
                      maxLines: widget.maxLines,
                      style: effectiveTextStyle,
                      overflow: TextOverflow.ellipsis,
                      textAlign: textAlign,
                    )
                  : CustomText(widget.text,
                      style: effectiveTextStyle, textAlign: textAlign);
              if (widget.animation) {
                widgetBuilder = _buildAnimatedSize(widgetBuilder);
              }
              if (!_expanded && widget.expandOnTextTap) {
                widgetBuilder =
                    GestureDetector(onTap: _expandText, child: widgetBuilder);
              }
              if (_expanded && widget.collapseOnTextTap) {
                widgetBuilder =
                    GestureDetector(onTap: _collapseText, child: widgetBuilder);
              }
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [widgetBuilder, linkBuilder]);
            default:
              return RichText(
                  text: TextSpan(text: widget.text, style: effectiveTextStyle),
                  softWrap: true,
                  maxLines: widget.maxLines,
                  textDirection: textDirection,
                  textAlign: textAlign,
                  textScaleFactor: textScaleFactor,
                  overflow: TextOverflow.ellipsis);
          }
        } else {
          return RichText(
            text: TextSpan(text: widget.text, style: effectiveTextStyle),
            softWrap: true,
            maxLines: widget.maxLines,
            textDirection: textDirection,
            textAlign: textAlign,
            textScaleFactor: textScaleFactor,
            overflow: TextOverflow.ellipsis,
          );
        }
      },
    );
    return result;
  }

  Widget _buildAnimatedSize(Widget child) {
    return AnimatedSize(
      duration: widget.animationDuration ?? const Duration(milliseconds: 400),
      curve: widget.animationCurve ?? Curves.fastLinearToSlowEaseIn,
      alignment: Alignment.topLeft,
      child: child,
    );
  }
}
