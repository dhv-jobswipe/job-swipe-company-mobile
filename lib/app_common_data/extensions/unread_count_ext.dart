import 'package:flutter/material.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:pbl5/view_models/base_view_model.dart';

extension UnreadCountExt on Widget {
  Widget withUnreadCount<T extends BaseViewModel>(
    int count, {
    double? right = 0,
    double? top = 0,
    double? left,
    double? bottom,
    Color bgColor = Colors.red,
    Color textColor = Colors.white,
  }) {
    return Stack(
      children: [
        this,
        if (count > 0)
          Positioned(
            right: right,
            top: top,
            left: left,
            bottom: bottom,
            child: Builder(builder: (context) {
              String countStr = count > 9 ? '9+' : count.toString();
              return CircleAvatar(
                minRadius: 5,
                maxRadius: countStr.length == 2 ? 10 : 9,
                backgroundColor: bgColor,
                child: Center(
                  child: CustomText(
                    countStr,
                    color: textColor,
                    size: 10,
                  ),
                ),
              );
            }),
          ),
      ],
    );
  }
}
