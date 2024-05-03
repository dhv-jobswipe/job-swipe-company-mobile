import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension DateTimeExt on DateTime? {
  String get toHourAndMinute =>
      this == null ? '' : DateFormat("HH:mm").format(this!);

  String get toMonthDayHourMinute =>
      this == null ? '' : DateFormat("MM/dd HH:mm").format(this!);

  String get monthYear =>
      this == null ? '' : DateFormat('MM/yyyy').format(this!);

  String toDayMonthYear({Locale? locale}) {
    if (this == null) return '';

    return DateFormat('dd-MM-yyyy').format(this!);
  }

  String toCustomFormat(String format) =>
      this == null ? '' : DateFormat(format).format(this!);

  int convertDateToTimestamp(String date) {
    DateTime parsedDate = DateTime.parse(date);
    int timestamp = parsedDate.millisecondsSinceEpoch ~/ 1000;
    return timestamp;
  }
}
