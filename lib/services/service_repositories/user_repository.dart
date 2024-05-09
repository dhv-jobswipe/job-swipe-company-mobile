import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/models/user_awards/user_awards.dart';
import 'package:pbl5/models/user_educations/user_educations.dart';
import 'package:pbl5/models/user_experiences/user_experiences.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';
import 'package:pbl5/services/apis/api_client.dart';
import 'package:pbl5/shared_customization/extensions/file_ext.dart';

class UserRepository {
  final ApiClient apis;
  const UserRepository({required this.apis});

  Future<ApiResponse<User>> getProfile() => apis.getProfile();

  Future<ApiResponse<User>> getProfileById(String userId) => apis.getProfileById(userId);


  Future<ApiResponse> updateAvatar({required File avatar}) async =>
      apis.updateAvatar(FormData.fromMap({
        "file": await avatar.toMultipartFile,
      }));

  Future<ApiResponse<User>> updateBasicInfo({required User user}) =>
      apis.updateBasicInfo({
        "first_name": user.firstName,
        "last_name": user.lastName,
        "date_of_birth": user.dob,
        "phone_number": user.phoneNumber,
        "address": user.address,
        "gender": user.gender,
        "account_status": user.accountStatus,
        "summary_introduction": user.summaryIntroduction,
        "social_media_link": user.socialMediaLink,
      });

  Future<ApiResponse<User>> updateEducation(
          {required List<UserEducations> userEducations}) =>
      apis.updateEducation(userEducations);

  Future<ApiResponse<User>> insertEducation(
          {required List<UserEducations> userEducations}) =>
      apis.insertEducation(userEducations);

  Future<ApiResponse> deleteEducation({required List<String> ids}) =>
      apis.deleteEducation(ids);

  Future<ApiResponse<User>> updateExperience(
          {required List<UserExperiences> userExperiences}) =>
      apis.updateExperience(userExperiences);

  Future<ApiResponse<User>> insertExperience(
          {required List<UserExperiences> userExperiences}) =>
      apis.insertExperience(userExperiences);

  Future<ApiResponse> deleteExperience({required List<String> ids}) =>
      apis.deleteExperience(ids);

  Future<ApiResponse<User>> updateAward(
          {required List<UserAwards> userAwards}) =>
      apis.updateAward(userAwards);

  Future<ApiResponse<User>> insertAward(
          {required List<UserAwards> userAwards}) =>
      apis.insertAward(userAwards);

  Future<ApiResponse> deleteAward({required List<String> ids}) =>
      apis.deleteAward(ids);
}
