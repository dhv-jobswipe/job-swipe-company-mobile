extension IntExt on int? {
  String toCurrency({String separatedPattern = ","}) {
    if (this == null) return "";
    String str = this!.toString();
    if (str.length <= 3) return str;
    return "${((this! ~/ 1000).toCurrency())}$separatedPattern${str.substring(str.length - 3, str.length)}";
  }

  DateTime? get toDateTimeFromMilliseconds =>
      this != null ? DateTime.fromMillisecondsSinceEpoch(this!) : null;
}
