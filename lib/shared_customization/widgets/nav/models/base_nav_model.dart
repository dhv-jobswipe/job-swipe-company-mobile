import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_nav_model.freezed.dart';

@freezed
class BaseNavModel with _$BaseNavModel {
  const factory BaseNavModel({
    required String label,
    IconData? icon,
    String? svgIconUrl,
  }) = _BaseNavModel;
}
