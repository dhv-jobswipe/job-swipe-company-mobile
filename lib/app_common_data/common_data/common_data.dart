// ignore_for_file: constant_identifier_names

class AppStrings {
  AppStrings._();

  static const String NOT_HAVE_PERMISSION_ERROR_CODE = 'ERR_AUTH0102';
  static const String INVALID_TOKEN_ERROR_CODE = 'ERR_TOK0101';
  static const String REVOKED_TOKEN_ERROR_CODE = 'ERR_TOK0103';
  static const String EXPIRED_TOKEN_ERROR_CODE = 'ERR_TOK0102';
  static const String INVALID_REFRESH_TOKEN_ERROR_CODE = 'ERR_TOK0201';
  static const String EXPIRED_REFRESH_TOKEN_ERROR_CODE = 'ERR_TOK0202';
  static const String REVOKED_REFRESH_TOKEN_ERROR_CODE = 'ERR_TOK0203';

  ///
  /// Storage
  ///
  static const String ACCESS_TOKEN = 'access_token';
  static const String REFRESH_TOKEN = 'refresh_token';
  static const String KEEP_LOGIN = 'keep_login';
  static const String LOGGED_BEFORE = 'logged_before';
  static const String THEME = 'theme';
}
