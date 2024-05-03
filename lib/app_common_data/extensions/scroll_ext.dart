import 'package:flutter/material.dart';

extension ScrollExt on Object? {
  bool get isTopScroll =>
      this is ScrollEndNotification &&
      (this as ScrollEndNotification).metrics.extentAfter == 0 &&
      (this as ScrollEndNotification).metrics.minScrollExtent == 0 &&
      (this as ScrollEndNotification).metrics.pixels != 0;

  bool get isEndScroll =>
      this is ScrollEndNotification &&
      (this as ScrollEndNotification).metrics.extentBefore == 0 &&
      (this as ScrollEndNotification).metrics.minScrollExtent == 0 &&
      (this as ScrollEndNotification).metrics.pixels == 0;
}
