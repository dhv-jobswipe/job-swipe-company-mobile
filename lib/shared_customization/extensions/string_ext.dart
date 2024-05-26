import 'package:easy_localization/easy_localization.dart';

import '/shared_customization/data/string_file_extension.dart';

extension StringExt on String? {
  ///
  /// Check empty or null
  ///
  bool get isEmptyOrNull => this == null || (this!.trim()).isEmpty;

  bool get isNotEmptyOrNull => this != null && (this!.trim()).isNotEmpty;

  int get strLength => (this ?? "").length;

  ///
  /// Check file extension
  ///
  String get urlFileName => (this ?? '').split('/').last;

  String get fileExtension => (this ?? '').split('.').last;

  bool get isImage => IMAGE_FILE_EXTENSION
      .any((element) => urlFileName.toLowerCase().endsWith(element));

  bool get isVideo => VIDEO_FILE_EXTENSIONS
      .any((element) => urlFileName.toLowerCase().endsWith(element));

  bool get isPdf => urlFileName.toLowerCase().endsWith('.pdf');

  ///
  /// Conver to datetime
  ///
  DateTime? get toDateTime {
    if (this.isEmptyOrNull) return null;
    try {
      var date = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(this!, true);
      return date;
    } catch (err) {
      return null;
    }
  }

  DateTime get toInitialDateTime {
    if (this.isEmptyOrNull) return DateTime.now();

    try {
      var date = DateFormat("dd-MM-yyyy").parse(this!, true);
      print("Date: $date");
      print(this);
      return date;
    } catch (err) {
      print("Error: $err");
      return DateTime.now();
    }
  }

  int? get toTimeStamp {
    if (this.isEmptyOrNull) return null;
    try {
      DateFormat format = DateFormat('dd-MM-yyyy');
      DateTime dateTime = format.parse(this!);
      int unixTimestamp = dateTime.millisecondsSinceEpoch ~/ 1000;
      return unixTimestamp;
    } catch (err) {
      return null;
    }
  }

  String? get toDatetimeApi {
    if (this.isEmptyOrNull) return null;
    try {
      DateFormat format = DateFormat('dd-MM-yyyy');
      DateTime dateTime = format.parse(this!);
      return DateFormat("yyyy-MM-ddTHH:mm:ss").format(dateTime);
    } catch (err) {
      return null;
    }
  }

  String get hardCoded => this ?? "";

  String get debug => "DEBUG: ===> ${this ?? ""}";
}
