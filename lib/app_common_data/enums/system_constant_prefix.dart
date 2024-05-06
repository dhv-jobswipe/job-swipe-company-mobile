enum SystemConstantPrefix {
  SYSTEM_ROLE._("01"),
  APPLY_POSITION._("02"),
  SKILL._("03"),
  EXPERIENCE_TYPE._("04"),
  NOTIFICATION_TYPE._("05"),
  LANGUAGE._("06");

  final String prefix;
  const SystemConstantPrefix._(this.prefix);
}

enum SystemRole {
  ADMIN._("10000"),
  USER._("11001"),
  COMPANY._("11002");

  final String value;
  const SystemRole._(this.value);

  static SystemRole fromValue(String systemRole) {
    String value =
        systemRole.substring(SystemConstantPrefix.SYSTEM_ROLE.prefix.length);
    for (var type in SystemRole.values) {
      if (type.value == value) return type;
    }
    throw Exception("Invalid system role");
  }
}
