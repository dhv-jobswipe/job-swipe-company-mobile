import 'package:flutter/material.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_icon_button.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_image.dart';

extension CustomImageExt on CustomImage {
  Widget onRemove({
    required VoidCallback onRemoveTap,
    IconData icon = Icons.close,
    Color? color,
    Color? bgColor,
    double size = 18,
  }) {
    return Stack(
      children: [
        this,
        Positioned(
            top: 4,
            right: 4,
            child: CustomIconButton(
              onPressed: onRemoveTap,
              icon: icon,
              color: color ?? Colors.white,
              backgroundColor: bgColor ?? Colors.grey.shade700,
              size: size,
            ))
      ],
    );
  }

  Widget onTap({
    required VoidCallback onTap,
    VoidCallback? onLongPress,
  }) =>
      GestureDetector(onTap: onTap, onLongPress: onLongPress, child: this);
}
