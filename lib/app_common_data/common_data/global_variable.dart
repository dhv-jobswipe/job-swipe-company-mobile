// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/generated/translations.g.dart';

///
///
///
const double BORDER_RADIUS_VALUE = 6;
final String CURRENCY = tr(LocaleKeys.CommonData_Currency);
const int PASSWORD_MAX_LENGTH = 32;
const int PASSWORD_MIN_LENGTH = 8;

///
/// Screen variable
///
double MAX_WIDTH_SCREEN = 0;
double MAX_HEIGHT_SCREEN = 0;
double PADDING_TOP = 0;
double PADDING_BOTTOM = 0;

///
///
///
const EMPTY_WIDGET = SizedBox.shrink();
final DEFAUT_BOX_SHADOWN = BoxShadow(
  color: Colors.black.withOpacity(0.4),
  blurRadius: 5.0,
  spreadRadius: 3.0,
  offset: const Offset(4, 3),
);
