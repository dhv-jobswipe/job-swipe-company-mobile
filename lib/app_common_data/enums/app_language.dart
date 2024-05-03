import 'package:flutter/material.dart';

import '/models/my_date_time/my_date_time.dart';
import '/shared_customization/extensions/string_ext.dart';
import 'package:timeago/timeago.dart' as timeago;

enum AppLanguage {
  vi, // Vietnamese
  en, // English
  ja, // Japanese
}

extension AppLanguageExt on AppLanguage {
  String get languageCode => {
        AppLanguage.vi: 'vi',
        AppLanguage.en: 'en',
        AppLanguage.ja: 'ja',
      }[this]!;

  Locale get locale => {
        AppLanguage.vi: const Locale('vi'),
        AppLanguage.en: const Locale('en'),
        AppLanguage.ja: const Locale('ja'),
      }[this]!;

  String get dateFormat => {
        AppLanguage.vi: 'dd/MM/yyyy',
        AppLanguage.en: 'MM/dd/yyyy',
        AppLanguage.ja: 'yyyy/MM/dd',
      }[this]!;

  timeago.LookupMessages lookupMessages({bool isShort = false}) => {
        AppLanguage.vi:
            isShort ? timeago.ViShortMessages() : timeago.ViMessages(),
        AppLanguage.en:
            isShort ? timeago.EnShortMessages() : timeago.EnMessages(),
        AppLanguage.ja: timeago.JaMessages(),
      }[this]!;

  MyDateTime getMyDateTime(String text) {
    var myDateTime = MyDateTime.empty;
    if (text.isEmptyOrNull || text.length != AppLanguage.vi.dateFormat.length) {
      return myDateTime;
    }
    try {
      switch (this) {
        case AppLanguage.vi:
          myDateTime = myDateTime.copyWith(
            day: int.parse(text.substring(0, 2)),
            month: int.parse(text.substring(3, 5)),
            year: int.parse(text.substring(6)),
          );
          break;
        case AppLanguage.en:
          myDateTime = myDateTime.copyWith(
            day: int.parse(text.substring(3, 5)),
            month: int.parse(text.substring(0, 2)),
            year: int.parse(text.substring(6)),
          );
          break;
        case AppLanguage.ja:
          myDateTime = myDateTime.copyWith(
            day: int.parse(text.substring(8)),
            month: int.parse(text.substring(5, 7)),
            year: int.parse(text.substring(0, 4)),
          );
          break;
      }
    } catch (err) {
      myDateTime = MyDateTime.empty;
    }
    return myDateTime;
  }
}
