// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/app_common_data/app_text_sytle.dart';
import '/shared_customization/data/basic_types.dart';
import '/shared_customization/extensions/list_ext.dart';
import '/shared_customization/widgets/custom_container.dart';
import '/shared_customization/widgets/texts/custom_text.dart';

class ListWheelDelegateModel<T> {
  String label;
  T value;
  ListWheelDelegateModel({required this.label, required this.value});
}

class CustomListWheelDelegate<T> extends StatefulWidget {
  final double itemExtent;
  final List<ListWheelDelegateModel<T>> items;
  final ValueChanged<T> onChanged;
  final IdentifyCallBack<T> identify;
  final bool loop;
  final ListWheelDelegateModel<T>? initialItem;
  final ItemRenderCallBack<T>? itemBuilder;
  final ItemRenderCallBack<T>? selectedItemBuilder;
  final UpdateStyleCallBack? onlabelStyleUpdate;
  final UpdateStyleCallBack? onSelectedLabelStyleUpdate;
  final OnItemTap<T>? onItemTap;

  const CustomListWheelDelegate({
    super.key,
    this.itemExtent = 50,
    required this.items,
    required this.onChanged,
    required this.identify,
    this.loop = false,
    this.initialItem,
    this.itemBuilder,
    this.selectedItemBuilder,
    this.onlabelStyleUpdate,
    this.onSelectedLabelStyleUpdate,
    this.onItemTap,
  });

  @override
  State<CustomListWheelDelegate<T>> createState() =>
      _CustomListWheelDelegateState<T>();
}

class _CustomListWheelDelegateState<T>
    extends State<CustomListWheelDelegate<T>> {
  late List<ListWheelDelegateModel<T>> items;
  late double itemExtent;
  late FixedExtentScrollController _controller;
  ListWheelDelegateModel<T>? currentSelectedItem;
  int? currentSelectedIndex;
  late AppThemeData theme;

  @override
  void initState() {
    super.initState();
    items = widget.items;
    itemExtent = widget.itemExtent;
    _controller = FixedExtentScrollController();

    if (widget.initialItem != null) {
      widget.onChanged.call(widget.initialItem!.value);
      currentSelectedItem = widget.initialItem;
      int index = items.indexWhere((element) =>
          widget.identify(element.value) ==
          widget.identify(widget.initialItem!.value));
      if (index >= 0) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _animateScroll(index);
        });
      }
    } else if (items.isNotEmptyOrNull) {
      widget.onChanged.call(items.first.value);
      currentSelectedItem = items.first;
    }
  }

  _animateScroll(int index) async {
    if (index == _controller.selectedItem &&
        index * itemExtent == _controller.offset) return;
    debugPrint("CustomListWheelDelegate scroll to index: $index".debug);
    await _controller.animateTo(index * itemExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    theme = context.appTheme.appThemeData;
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          CustomContainer(
            color: theme.transparent,
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            ),
          ),
          Positioned.fill(
              child: Center(
            child: CustomContainer(
              color: theme.black.withOpacity(0.2),
              child: SizedBox(
                width: constraints.maxWidth,
                height: itemExtent,
              ),
            ),
          )),
          Positioned.fill(
            child: ListWheelScrollView.useDelegate(
                itemExtent: itemExtent,
                controller: _controller,
                onSelectedItemChanged: (value) {
                  setState(() {
                    var selectedItem = items.elementAt(value);
                    currentSelectedItem = selectedItem;
                    currentSelectedIndex = value;
                    widget.onChanged.call(selectedItem.value);
                  });
                },
                childDelegate: widget.loop
                    ? ListWheelChildLoopingListDelegate(
                        children: widget.items
                            .asMap()
                            .entries
                            .map((itemMap) => _buildLabelWidget(
                                itemMap.value, itemMap.key, constraints))
                            .toList(),
                      )
                    : ListWheelChildListDelegate(
                        children: widget.items
                            .asMap()
                            .entries
                            .map((itemMap) => _buildLabelWidget(
                                itemMap.value, itemMap.key, constraints))
                            .toList(),
                      )),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelWidget(
      ListWheelDelegateModel<T> item, int index, BoxConstraints constraints) {
    var isCurrentSelectedItem = widget.identify(item.value) ==
        widget.identify(currentSelectedItem?.value);

    return GestureDetector(
      onTap: () {
        _animateScroll(index);
        widget.onItemTap?.call(item.value);
      },
      child: CustomContainer(
        color: theme.transparent,
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Builder(builder: (context) {
          ///
          /// Widget builder
          ///
          if (widget.itemBuilder != null && !isCurrentSelectedItem) {
            return widget.itemBuilder!.call(item.value);
          } else if (widget.selectedItemBuilder != null &&
              isCurrentSelectedItem) {
            return widget.selectedItemBuilder!.call(item.value);
          }

          ///
          /// Default widget builder
          ///
          TextStyle textStyle = AppTextStyle.defaultStyle;

          if (widget.onlabelStyleUpdate != null && !isCurrentSelectedItem) {
            textStyle = widget.onlabelStyleUpdate!.call(textStyle);
          } else if (widget.onSelectedLabelStyleUpdate != null &&
              isCurrentSelectedItem) {
            textStyle = widget.onSelectedLabelStyleUpdate!.call(textStyle);
          } else {
            textStyle = textStyle.copyWith(
              fontSize: isCurrentSelectedItem ? 19.0 : 16.0,
              fontWeight:
                  isCurrentSelectedItem ? FontWeight.bold : FontWeight.w600,
              color: isCurrentSelectedItem ? theme.black : theme.text_title,
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomText(
                  item.label,
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
