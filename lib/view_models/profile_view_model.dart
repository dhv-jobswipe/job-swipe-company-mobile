import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/app_data.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/models/language/language.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/models/user_awards/user_awards.dart';
import 'package:pbl5/models/user_educations/user_educations.dart';
import 'package:pbl5/models/user_experiences/user_experiences.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/services/service_repositories/company_repository.dart';
import 'package:pbl5/services/service_repositories/system_constant_repository.dart';
import 'package:pbl5/services/service_repositories/user_repository.dart';
import 'package:pbl5/shared_customization/extensions/date_time_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/storages.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class ProfileViewModel extends BaseViewModel {
  final AuthenticationRepositoty authRepositoty;
  final UserRepository userRepository;
  final CompanyRepository companyRepository;
  final SystemConstantRepository systemConstantRepository;
  final CustomSharedPreferences customSharedPreferences;
  User? user;
  final emailController = TextEditingController()..text = '';
  final passwordController = TextEditingController()..text = '';
  final addressController = TextEditingController()..text = '';
  final phoneController = TextEditingController()..text = '';
  final firstNameController = TextEditingController()..text = '';
  final lastNameController = TextEditingController()..text = '';
  final dobController = TextEditingController()..text = '';
  final summaryIntroductionController = TextEditingController()
    ..text = 'I am a developer';
  bool gender = true;
  List<String> socialMediaLinks = [];
  File? avatar;

  //for education
  final List<TextEditingController> eduIdControllers = [];
  final List<TextEditingController> studyPlaceControllers = [];
  final List<TextEditingController> studyStartTimeControllers = [];
  final List<TextEditingController> studyEndTimeControllers = [];
  final List<TextEditingController> majorityControllers = [];
  final List<TextEditingController> cpaControllers = [];
  final List<TextEditingController> eduNoteControllers = [];

  //for add education
  final addStudyPlaceController = TextEditingController();
  final addStudyStartTimeController = TextEditingController();
  final addStudyEndTimeController = TextEditingController();
  final addMajorityController = TextEditingController();
  final addCpaController = TextEditingController();
  final addEduNoteController = TextEditingController();

  //for experience
  List<SystemConstant> selectedSystemConstants = [];
  final List<TextEditingController> expIdControllers = [];
  final List<TextEditingController> workPlaceControllers = [];
  final List<TextEditingController> positionControllers = [];
  final List<TextEditingController> expStartTimeControllers = [];
  final List<TextEditingController> expEndTimeControllers = [];
  final List<TextEditingController> expNoteControllers = [];

  //for add experience
  SystemConstant? addSelectedSystemConstants;
  final addWorkPlaceController = TextEditingController();
  final addPositionController = TextEditingController();
  final addExpStartTimeController = TextEditingController();
  final addExpEndTimeController = TextEditingController();
  final addExpNoteController = TextEditingController();

  //for award
  final List<TextEditingController> awardIdControllers = [];
  final List<TextEditingController> awardNameControllers = [];
  final List<TextEditingController> awardTimeControllers = [];
  final List<TextEditingController> awardNoteControllers = [];

  //for add award
  final addAwardNameController = TextEditingController();
  final addAwardTimeController = TextEditingController();
  final addAwardNoteController = TextEditingController();

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
    required this.userRepository,
    required this.customSharedPreferences,
    required this.systemConstantRepository,
    required this.companyRepository,
  });

  Future<void> updateBasicInfo({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      debugPrint(User(
        id: user?.id,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        address: addressController.text,
        dob: dobController.text.toDatetimeApi,
        gender: gender,
        accountStatus: user?.accountStatus,
        summaryIntroduction: summaryIntroductionController.text,
        socialMediaLink: socialMediaLinks,
      ).toString());
      user = (await userRepository.updateBasicInfo(
        user: User(
          id: user?.id,
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneController.text,
          address: addressController.text,
          dob: dobController.text.toDatetimeApi,
          gender: gender,
          accountStatus: user?.accountStatus,
          summaryIntroduction: summaryIntroductionController.text,
          socialMediaLink: socialMediaLinks,
        ),
      ))
          .data;

      getIt.get<AppData>().updateUser(user);
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  Future<void> updateAvatar({
    required File file,
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      await userRepository.updateAvatar(
        avatar: await file,
      );
      getProfile();
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  Future<void> updateEducation({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      user = (await userRepository.updateEducation(
        userEducations: eduIdControllers
            .map((e) => UserEducations(
                  id: e.text,
                  studyPlace:
                      studyPlaceControllers[eduIdControllers.indexOf(e)].text,
                  studyStartTime:
                      studyStartTimeControllers[eduIdControllers.indexOf(e)]
                          .text
                          .toDatetimeApi,
                  studyEndTime:
                      studyEndTimeControllers[eduIdControllers.indexOf(e)]
                          .text
                          .toDatetimeApi,
                  majority:
                      majorityControllers[eduIdControllers.indexOf(e)].text,
                  cpa: double.tryParse(
                          cpaControllers[eduIdControllers.indexOf(e)].text) ??
                      0,
                  note: eduNoteControllers[eduIdControllers.indexOf(e)].text,
                ))
            .toList(),
      ))
          .data;
      getIt.get<AppData>().updateUser(user);
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  //update award
  Future<void> updateAward({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    var cancel = showLoading();
    try {
      user = (await userRepository.updateAward(
        userAwards: awardIdControllers
            .map((e) => UserAwards(
                  id: e.text,
                  certificateName:
                      awardNameControllers[awardIdControllers.indexOf(e)].text,
                  certificateTime:
                      awardTimeControllers[awardIdControllers.indexOf(e)]
                          .text
                          .toDatetimeApi,
                  note:
                      awardNoteControllers[awardIdControllers.indexOf(e)].text,
                ))
            .toList(),
      ))
          .data;
      getIt.get<AppData>().updateUser(user);
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    } finally {
      cancel();
    }
  }

  //update experience
  Future<void> updateExperience({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      user = (await userRepository.updateExperience(
        userExperiences: expIdControllers
            .map((e) => UserExperiences(
                  id: e.text,
                  workPlace:
                      workPlaceControllers[expIdControllers.indexOf(e)].text,
                  position:
                      positionControllers[expIdControllers.indexOf(e)].text,
                  experienceType:
                      selectedSystemConstants[expIdControllers.indexOf(e)],
                  experienceStartTime:
                      expStartTimeControllers[expIdControllers.indexOf(e)]
                          .text
                          .toDatetimeApi,
                  experienceEndTime:
                      expEndTimeControllers[expIdControllers.indexOf(e)]
                          .text
                          .toDatetimeApi,
                  note: expNoteControllers[expIdControllers.indexOf(e)].text,
                ))
            .toList(),
      ))
          .data;
      getIt.get<AppData>().updateUser(user);
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  Future<void> updateLanguage({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      var updatedLanguages = (await userRepository.updateLanguages(
        languages: languageIdControllers
            .map((e) => Language(
                  id: e.text,
                  languageConstant: updateLanguageSystemConstant[
                      languageIdControllers.indexOf(e)],
                  score: updateLanguageScoreControllers[
                              languageIdControllers.indexOf(e)]
                          .text ??
                      "0",
                  certificateDate: updateCertifiedDateControllers[
                          languageIdControllers.indexOf(e)]
                      .text
                      .toDatetimeApi,
                ))
            .toList(),
      ));

      if (user != null) {
        user!.copyWith(languages: updatedLanguages.data ?? user!.languages);
        getIt.get<AppData>().updateUser(user);
        updateUI();
      }

      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  // clear add Education controller
  void clearAddEducationController() {
    addStudyPlaceController.clear();
    addStudyStartTimeController.clear();
    addStudyEndTimeController.clear();
    addMajorityController.clear();
    addCpaController.clear();
    addEduNoteController.clear();
  }

  //add education
  Future<void> insertEducation({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      user = (await userRepository.insertEducation(
        userEducations: [
          UserEducations(
            studyPlace: addStudyPlaceController.text,
            studyStartTime: addStudyStartTimeController.text.toDatetimeApi,
            studyEndTime: addStudyEndTimeController.text.toDatetimeApi,
            majority: addMajorityController.text,
            cpa: double.tryParse(addCpaController.text) ?? 0,
            note: addEduNoteController.text,
          )
        ],
      ))
          .data;
      getIt.get<AppData>().updateUser(user);
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  //clear add award controller
  void clearAddAwardController() {
    addAwardNameController.clear();
    addAwardTimeController.clear();
    addAwardNoteController.clear();
  }

  //add award
  Future<void> insertAward({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      user = (await userRepository.insertAward(
        userAwards: [
          UserAwards(
            certificateName: addAwardNameController.text,
            certificateTime: addAwardTimeController.text.toDatetimeApi,
            note: addAwardNoteController.text,
          )
        ],
      ))
          .data;
      getIt.get<AppData>().updateUser(user);
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  //clear add experience controller
  void clearAddExperienceController() {
    addWorkPlaceController.clear();
    addPositionController.clear();
    addExpStartTimeController.clear();
    addExpEndTimeController.clear();
    addExpNoteController.clear();
  }

  //insert experience
  Future<void> insertExperience({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      user = (await userRepository.insertExperience(
        userExperiences: [
          UserExperiences(
            workPlace: addWorkPlaceController.text,
            position: addPositionController.text,
            experienceType: addSelectedSystemConstants,
            experienceStartTime: addExpStartTimeController.text.toDatetimeApi,
            experienceEndTime: addExpEndTimeController.text.toDatetimeApi,
            note: addExpNoteController.text,
          )
        ],
      ))
          .data;
      getIt.get<AppData>().updateUser(user);
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  // insert language
  Future<void> insertLanguage({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      var insertedLanguages = (await userRepository.insertLanguages(
        languages: [
          Language(
            languageConstant: addSelectedLanguageSystemConstant,
            score: addLanguageScoreController.text,
            certificateDate: addCertifiedDateController.text.toDatetimeApi,
          )
        ],
      ));

      if (user != null) {
        user!.copyWith(languages: insertedLanguages.data ?? user!.languages);
        getIt.get<AppData>().updateUser(user);
        updateUI();
      }

      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  Future<void> deleteExperience({
    VoidCallback? onSuccess,
    required int index,
    Function(String)? onFailure,
  }) async {
    try {
      await userRepository.deleteExperience(
        ids: [expIdControllers[index].text],
      );
      getProfile();
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  Future<void> deleteEducation({
    VoidCallback? onSuccess,
    required int index,
    Function(String)? onFailure,
  }) async {
    try {
      await userRepository.deleteEducation(
        ids: [eduIdControllers[index].text],
      );
      getProfile();
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  Future<void> deleteLanguage({
    VoidCallback? onSuccess,
    required int index,
    Function(String)? onFailure,
  }) async {
    try {
      await userRepository.deleteLanguage(
        ids: [languageIdControllers[index].text],
      );
      getProfile();
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  Future<void> deleteAward({
    VoidCallback? onSuccess,
    required int index,
    Function(String)? onFailure,
  }) async {
    try {
      await userRepository.deleteAward(
        ids: [awardIdControllers[index].text],
      );
      getProfile();
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }

  Future<void> getCompanyProfile({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    final cancel = showLoading();
    try {
      var company = (await companyRepository.getCompanyProfile()).data;
      getIt.get<AppData>().company = company;
    } catch (e) {
      onFailure?.call(parseError(e));
    } finally {
      cancel();
    }
  }

  Future<void> getProfile({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
    bool isShowLoading = true,
  }) async {
    final cancel = showLoading();
    try {
      user = (await userRepository.getProfile()).data;
      //basic profile
      getIt.get<AppData>().updateUser(user);
      emailController.text = user?.email ?? '';
      firstNameController.text = user?.firstName ?? '';
      lastNameController.text = user?.lastName ?? '';
      phoneController.text = user?.phoneNumber ?? '';
      addressController.text = user?.address ?? '';
      dobController.text = user?.dob.toDateTime.toDayMonthYear() ?? '';
      summaryIntroductionController.text = user?.summaryIntroduction ?? '';
      socialMediaLinks = user?.socialMediaLink ?? [];
      //education
      eduIdControllers.clear();
      studyPlaceControllers.clear();
      studyStartTimeControllers.clear();
      studyEndTimeControllers.clear();
      majorityControllers.clear();
      cpaControllers.clear();
      eduNoteControllers.clear();
      //add education
      addStudyPlaceController.clear();
      addStudyStartTimeController.clear();
      addStudyEndTimeController.clear();
      addMajorityController.clear();
      addCpaController.clear();
      addEduNoteController.clear();

      //experience
      expIdControllers.clear();
      workPlaceControllers.clear();
      positionControllers.clear();
      expStartTimeControllers.clear();
      expEndTimeControllers.clear();
      expNoteControllers.clear();
      selectedSystemConstants.clear();

      //add experience
      addWorkPlaceController.clear();
      addPositionController.clear();
      addExpStartTimeController.clear();
      addExpEndTimeController.clear();
      addExpNoteController.clear();

      //award
      awardIdControllers.clear();
      awardNameControllers.clear();
      awardTimeControllers.clear();
      awardNoteControllers.clear();

      //add award
      addAwardNameController.clear();
      addAwardTimeController.clear();
      addAwardNoteController.clear();

      //update language
      languageIdControllers.clear();
      updateLanguageScoreControllers.clear();
      updateCertifiedDateControllers.clear();

      //add language
      addLanguageScoreController.clear();
      addCertifiedDateController.clear();

      // create Controller for each education
      user?.educations.forEach((education) {
        eduIdControllers.add(TextEditingController(text: education.id));
        studyPlaceControllers
            .add(TextEditingController(text: education.studyPlace));
        studyStartTimeControllers.add(TextEditingController(
            text: education.studyStartTime.toDateTime.toDayMonthYear()));
        studyEndTimeControllers.add(TextEditingController(
            text: education.studyEndTime.toDateTime.toDayMonthYear()));
        majorityControllers
            .add(TextEditingController(text: education.majority));
        cpaControllers
            .add(TextEditingController(text: education.cpa.toString()));
        eduNoteControllers.add(TextEditingController(text: education.note));
      });

      //create Controller for each experience
      user?.experiences.forEach((experience) {
        expIdControllers.add(TextEditingController(text: experience.id));
        workPlaceControllers
            .add(TextEditingController(text: experience.workPlace));
        positionControllers
            .add(TextEditingController(text: experience.position));
        expStartTimeControllers.add(TextEditingController(
            text: experience.experienceStartTime.toDateTime.toDayMonthYear()));
        expEndTimeControllers.add(TextEditingController(
            text: experience.experienceEndTime.toDateTime.toDayMonthYear()));
        expNoteControllers.add(TextEditingController(text: experience.note));
        selectedSystemConstants
            .add(experience.experienceType ?? selectedSystemConstants.first);
      });
      //create Controller for each award

      user?.awards.forEach((award) {
        awardIdControllers.add(TextEditingController(text: award.id));
        awardNameControllers
            .add(TextEditingController(text: award.certificateName));
        awardTimeControllers.add(TextEditingController(
            text: award.certificateTime.toDateTime.toDayMonthYear()));
        awardNoteControllers.add(TextEditingController(text: award.note));
      });

      //create Controller for each language
      user?.languages.forEach((language) {
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
    } on Exception catch (error) {
      onFailure?.call(error.toString());
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
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    } finally {
      cancel();
    }
  }
}
