import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';
import 'package:pbl5/services/apis/api_client.dart';
import 'package:pbl5/shared_customization/extensions/file_ext.dart';

class CompanyRepository {
  final ApiClient apis;

  const CompanyRepository({required this.apis});

  Future<ApiResponse<Company>> getCompanyProfile() => apis.getCompanyProfile();

  Future<ApiResponse> updateAvatar({required File avatar}) async =>
      apis.updateAvatar(FormData.fromMap({
        "file": await avatar.toMultipartFile,
      }));

  Future<ApiResponse<Company>> updateCompanyBasicInfo(Company company) =>
      apis.updateCompanyBasicInfo({
        "company_name": company.companyName,
        "company_url": company.companyUrl,
        "established_date": company.establishedDate,
        "address": company.address,
        "phone_number": company.phoneNumber,
        "account_status": company.accountStatus,
        "others": company.others // Optional
      });
}
