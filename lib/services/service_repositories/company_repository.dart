import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';
import 'package:pbl5/services/apis/api_client.dart';
import 'package:pbl5/shared_customization/extensions/file_ext.dart';

//git commit -m "PBL-539 <message>"
//git commit -m "PBL-540 <message>"
//git commit -m "PBL-541 <message>"
class CompanyRepository {
  final ApiClient apis;

  const CompanyRepository({required this.apis});

  Future<ApiResponse<Company>> getCompanyProfile() => apis.getCompanyProfile();

  Future<ApiResponse> updateAvatar({required File avatar}) async =>
      apis.updateCompanyAvatar(FormData.fromMap({
        "file": await avatar.toMultipartFile,
      }));

  Future<ApiResponse<Company>> updateCompanyBasicInfo(Company company) =>
      apis.updateCompanyBasicInfo(company.toJson());
}
