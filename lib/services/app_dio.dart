import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/storages.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '/app_common_data/common_data/global_key_variable.dart';
import '/generated/translations.g.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/helpers/dialogs/dialog_helper.dart';
import '/shared_customization/helpers/utilizations/dio_parse_error.dart';
import '/app_common_data/common_data/common_data.dart';

class AppDio with DioMixin implements Dio {
  late CustomSharedPreferences sp;

  AppDio() {
    options = BaseOptions(
      connectTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
      },
    );
    sp = getIt.get<CustomSharedPreferences>();
    if (kDebugMode) {
      interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: false,
          responseHeader: false,
        ),
      );
    }

    interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final String? token = sp.prefs.getString(AppStrings.ACCESS_TOKEN);
        if (token != null && token.isNotEmpty) {
          options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        debugPrint("DIO ERROR DATA: ${error.response?.data}".debug);
        try {
          if (sp.accessToken.isNotEmptyOrNull &&
              error.response != null &&
              error.requestOptions.headers.containsKey('Authorization') &&
              error.response?.data is Map<String, dynamic>) {
            String errorCode = error.response?.data["error"]["code"];
            switch (errorCode) {
              case AppStrings.INVALID_TOKEN_ERROR_CODE:
              case AppStrings.REVOKED_TOKEN_ERROR_CODE:
              case AppStrings.EXPIRED_TOKEN_ERROR_CODE:
                if (sp.refreshToken.isNotEmptyOrNull) {
                  bool isRefreshed = await _refreshToken(sp.refreshToken);
                  if (!isRefreshed) {
                    throw Exception(
                        "Invalid refresh token! Please login again.");
                  }
                  var response = await request(
                      error.requestOptions.baseUrl + error.requestOptions.path,
                      data: error.requestOptions.data,
                      queryParameters: error.requestOptions.queryParameters,
                      options: Options(
                          method: error.requestOptions.method,
                          headers: error.requestOptions.headers
                            ..['Authorization'] = 'Bearer ${sp.accessToken}'));
                  handler.resolve(response);
                }
                return;
              case AppStrings.INVALID_REFRESH_TOKEN_ERROR_CODE:
              case AppStrings.EXPIRED_REFRESH_TOKEN_ERROR_CODE:
              case AppStrings.REVOKED_REFRESH_TOKEN_ERROR_CODE:
                throw errorCode;
              default:
                return handler.next(error);
            }
          }
        } catch (err) {
          GlobalKeyVariable.futureCurrentContext.then((context) {
            if (error.response?.data['error'] != null) {
              showErrorDialog(
                context,
                title: tr(LocaleKeys.CommonData_Error),
                content: parseError(error),
              ).then((value) {
                sp.prefs.clear();
              });
            } else {
              showErrorDialog(
                context,
                title: tr(LocaleKeys.CommonData_Error),
                content: err.toString(),
              ).then((value) {
                sp.prefs.clear();
              });
            }
          });
        }
        return handler.next(error);
      },
    ));

    httpClientAdapter = HttpClientAdapter();
  }

  Future<bool> _refreshToken(String? refreshToken) async {
    try {
      if (refreshToken.isEmptyOrNull) return false;
      await sp.clear();
      var authRepo = getIt.get<AuthenticationRepositoty>();
      var newCredential = await authRepo.refreshToken(refreshToken!);
      if (newCredential != null) {
        await sp.setToken(
            newCredential.accessToken ?? '', newCredential.refreshToken ?? '');
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
