import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/app_data.dart';
import 'package:pbl5/models/application_position/application_position.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/models/language/language.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/services/service_repositories/apply_position_repository.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/services/service_repositories/company_repository.dart';
import 'package:pbl5/services/service_repositories/language_repository.dart';
import 'package:pbl5/services/service_repositories/system_constant_repository.dart';
import 'package:pbl5/shared_customization/extensions/date_time_ext.dart';
import 'package:pbl5/shared_customization/extensions/list_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/storages.dart';
import 'package:pbl5/view_models/base_view_model.dart';

//git commit -m "PBL-696 <message>"
//git commit -m "PBL-540 <message>"
//git commit -m "PBL-541 <message>"
//git commit -m "PBL-576 <message>"
//git commit -m "PBL-577 <message>"
//git commit -m "PBL-535 <message>"
//git commit -m "PBL-554 <message>"
//git commit -m "PBL-555 <message>"
//git commit -m "PBL-533 <message>"
//git commit -m "PBL-531 <message>"
//git commit -m "PBL-550 <message>"
class ProfileViewModel extends BaseViewModel {
  final AuthenticationRepositoty authRepositoty;
  final LanguageRepository languageRepository;
  final ApplyPositionRepository applyPositionRepository;
  final CompanyRepository companyRepository;
  final SystemConstantRepository systemConstantRepository;
  final CustomSharedPreferences customSharedPreferences;
  final addressController = TextEditingController()..text = '';
  final phoneController = TextEditingController()..text = '';
  final companyNameController = TextEditingController()..text = '';
  final companyUrlController = TextEditingController()..text = '';
  final establishedDateController = TextEditingController()..text = '';
  File? avatar;
  Company? company;

  //for update language
  List<SystemConstant> updateLanguageSystemConstant = [];
  final List<TextEditingController> languageIdControllers = [];
  final List<TextEditingController> updateLanguageScoreControllers = [];
  final List<TextEditingController> updateCertifiedDateControllers = [];

  //for add language
  SystemConstant? addSelectedLanguageSystemConstant;
  final addLanguageScoreController = TextEditingController();
  final addCertifiedDateController = TextEditingController();

  ProfileViewModel({
    required this.authRepositoty,
    required this.customSharedPreferences,
    required this.systemConstantRepository,
    required this.companyRepository,
    required this.languageRepository,
    required this.applyPositionRepository,
  });

  Future<void> updateBasicInfo({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      company = (await companyRepository.updateCompanyBasicInfo(
        Company(
          id: company?.id,
          phoneNumber: phoneController.text,
          address: addressController.text,
          establishedDate: establishedDateController.text.toDatetimeApi,
          companyName: companyNameController.text,
          companyUrl: companyUrlController.text,
          accountStatus: company?.accountStatus,
        ),
      ))
          .data;

      getIt.get<AppData>().company = company;
      updateUI();
      onSuccess?.call();
    } catch (error) {
      onFailure?.call(parseError(error));
    }
  }

  Future<void> updateAvatar({
    required File file,
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      await companyRepository.updateAvatar(avatar: await file);
      getProfile();
      updateUI();
      onSuccess?.call();
    } catch (error) {
      onFailure?.call(parseError(error));
    }
  }

  Future<void> updateLanguage({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      var updatedLanguages = (await languageRepository.updateLanguages(
        languages: languageIdControllers
            .map((e) => Language(
                  id: e.text,
                  languageConstant: updateLanguageSystemConstant[
                      languageIdControllers.indexOf(e)],
                  score: updateLanguageScoreControllers[
                          languageIdControllers.indexOf(e)]
                      .text,
                  certificateDate: updateCertifiedDateControllers[
                          languageIdControllers.indexOf(e)]
                      .text
                      .toDatetimeApi,
                ))
            .toList(),
      ));

      if (company != null) {
        company = company!
            .copyWith(languages: updatedLanguages.data ?? company!.languages);
        getIt.get<AppData>().company = company;
        updateUI();
      }

      onSuccess?.call();
    } catch (error) {
      onFailure?.call(parseError(error));
    }
  }

  Future<void> updateApplyPosition({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      if (company?.applicationPositions == null) return;
      var response = (await applyPositionRepository.updateApplyPositions(
          applicationPositions: company!.applicationPositions));
      if (response.data != null) {
        getProfile();
        updateUI();
        onSuccess?.call();
      }
    } catch (error) {
      onFailure?.call(parseError(error));
    }
  }

  // insert language
  Future<void> insertLanguage({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      var insertedLanguages = (await languageRepository.insertLanguages(
        languages: [
          Language(
            languageConstant: addSelectedLanguageSystemConstant,
            score: addLanguageScoreController.text,
            certificateDate: addCertifiedDateController.text.toDatetimeApi,
          )
        ],
      ));

      if (company != null) {
        company = company!
            .copyWith(languages: insertedLanguages.data ?? company!.languages);
        getIt.get<AppData>().company = company;
        updateUI();
      }

      onSuccess?.call();
    } catch (error) {
      onFailure?.call(parseError(error));
    }
  }

  Future<void> insertApplyPosition(
    ApplicationPosition applyPosition, {
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      var response = (await applyPositionRepository.insertApplyPositions(
          applicationPositions: [applyPosition.copyWith(status: true)]));

      if (company != null) {
        company = company!.copyWith(
            applicationPositions:
                (response.data ?? company!.applicationPositions)
                    .insertList(response.data!));
        getIt.get<AppData>().company = company;
        updateUI();
      }

      onSuccess?.call();
    } catch (error) {
      onFailure?.call(parseError(error));
    }
  }

  Future<void> deleteLanguage({
    VoidCallback? onSuccess,
    required int index,
    Function(String)? onFailure,
  }) async {
    try {
      await languageRepository
          .deleteLanguage(ids: [languageIdControllers[index].text]);
      getProfile();
      updateUI();
      onSuccess?.call();
    } catch (error) {
      onFailure?.call(parseError(error));
    }
  }

  Future<void> deleteApplyPosition({
    VoidCallback? onSuccess,
    required String? id,
    Function(String)? onFailure,
  }) async {
    try {
      if (id.isEmptyOrNull) return;
      await applyPositionRepository.deleteApplyPositions(ids: [id!]);
      getProfile();
      updateUI();
      onSuccess?.call();
    } catch (error) {
      onFailure?.call(parseError(error));
    }
  }

  Future<void> getProfile({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
    bool isShowLoading = true,
  }) async {
    final cancel = showLoading();
    try {
      company = (await companyRepository.getCompanyProfile()).data;
      //basic profile
      getIt.get<AppData>().company = company;
      phoneController.text = company?.phoneNumber ?? '';
      addressController.text = company?.address ?? '';
      companyNameController.text = company?.companyName ?? '';
      companyUrlController.text = company?.companyUrl ?? '';
      establishedDateController.text =
          company?.establishedDate?.toDateTime?.toDayMonthYear() ?? '';

      //update language
      languageIdControllers.clear();
      updateLanguageScoreControllers.clear();
      updateCertifiedDateControllers.clear();

      //add language
      addLanguageScoreController.clear();
      addCertifiedDateController.clear();

      //create Controller for each language
      company?.languages.forEach((language) {
        languageIdControllers.add(TextEditingController(text: language.id));
        updateLanguageSystemConstant.add(
            language.languageConstant ?? updateLanguageSystemConstant.first);
        updateLanguageScoreControllers
            .add(TextEditingController(text: language.score));
        updateCertifiedDateControllers.add(TextEditingController(
            text: language.certificateDate.toDateTime.toDayMonthYear()));
      });

      onSuccess?.call();
      updateUI();
    } catch (error) {
      onFailure?.call(parseError(error));
    } finally {
      if (isShowLoading) {
        cancel();
      }
    }
  }

  Future<void> logOut({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    final cancel = showLoading();
    try {
      await authRepositoty.logOut();
      customSharedPreferences.clear();
      getIt.get<AppData>().clear();
      updateUI();
      onSuccess?.call();
    } catch (error) {
      onFailure?.call(parseError(error));
    } finally {
      cancel();
    }
  }
}
