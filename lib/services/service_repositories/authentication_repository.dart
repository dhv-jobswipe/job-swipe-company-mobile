import 'package:pbl5/models/account/account.dart';
import 'package:pbl5/models/credential/credential.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';

import '/services/apis/api_client.dart';

//git commit -m "PBL-627 <message>"
//git commit -m "PBL-635 <message>"
class AuthenticationRepositoty {
  final ApiClient apis;

  const AuthenticationRepositoty({required this.apis});

  Future<ApiResponse<Credential>> login(String email, String password) =>
      apis.login({
        "email": email,
        "password": password,
      });

  Future<ApiResponse<User>> register({required User user}) =>
      apis.register(user.toJson());

  Future<SystemRolesResponse> getSystemRole() => apis.getSystemRoles();

  Future<ApiResponse<Account>> getAccount() => apis.getAccount();

  Future<ApiResponse<Account>> getAccountById(String id) =>
      apis.getAccountById(id);

  Future logOut() => apis.logout();

  Future<Credential?> refreshToken(String refreshToken) async {
    try {
      return (await apis.refreshToken({"refresh_token": refreshToken})).data;
    } catch (err) {
      return null;
    }
  }

  Future<bool> forgotPassword(String email) async =>
      (await apis.forgotPassword({"email": email})).status == "success";

  Future<bool> resetPassword(
    String resetPwdCode,
    String email,
    String pwd,
    String confirmPwd,
  ) async =>
      (await apis.resetPassword({
        "reset_password_code": resetPwdCode,
        "email": email,
        "new_password": pwd,
        "new_password_confirmation": confirmPwd
      }))
          .status ==
      "success";

// Future<bool> changePassword({
//   required String oldPwd,
//   required String newPwd,
//   required String confirmNewPwd,
// }) async {
//   try {
//     return (await apis.changePassword({
//           "old_password": oldPwd,
//           "new_password": newPwd,
//           "confirm_new_password": confirmNewPwd
//         }))
//             .status ==
//         "success";
//   } catch (e) {
//     rethrow;
//   }
// }
}
