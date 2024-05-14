import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/application_position/application_position.dart';
import 'package:pbl5/models/language/language.dart';
import 'package:pbl5/routes.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/edit_profile/edit_application_position.dart';
import 'package:pbl5/screens/edit_profile/edit_basic_profile_screen.dart';
import 'package:pbl5/screens/edit_profile/edit_language.dart';
import 'package:pbl5/screens/profile/edit_email.dart';
import 'package:pbl5/screens/profile/edit_phone.dart';
import 'package:pbl5/screens/profile/widgets/display_image_widget.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/date_time_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/image_helper.dart';
import 'package:pbl5/view_models/profile_view_model.dart';

//git commit -m "PBL-539 <message>"
//git commit -m "PBL-540 <message>"
//git commit -m "PBL-541 <message>"
//git commit -m "PBL-576 <message>"
//git commit -m "PBL-577 <message>"
//git commit -m "PBL-535 <message>"
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

//git commit -m "PBL-696 <message>"
class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModel viewModel;

  @override
  void initState() {
    viewModel = getIt.get<ProfileViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      canPop: false,
      viewModel: viewModel,
      appBar: AppBar(
        backgroundColor: orangePink,
        title: const Text(
          'JobSwipe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        elevation: 0,
      ),
      mobileBuilder: (context) {
        return RefreshIndicator(
          color: orangePink,
          onRefresh: () async {
            viewModel.getProfile();
          },
          child: Container(
            color: orangePink,
            child: Column(
              children: [
                buildAvatarImage(),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.only(top: 30.h, left: 15.w, right: 15.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildCustomRoundedContainer(
                            onEditPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditBasicProfileScreen(
                                    viewModel: viewModel,
                                  ),
                                ),
                              ).then((value) {
                                if (value == 'updateProfile') {
                                  viewModel.getProfile();
                                }
                              });
                            },
                            child: Column(
                              children: [
                                buildCompanyName(),
                                buildCompanyUrl(),
                                buildEmail(),
                                buildAddress(),
                                buildPhone(),
                                buildEstablishedDate(),
                              ],
                            ),
                          ),
                          _buildCustomRoundedContainer(
                            onEditPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditLanguageScreen(
                                    viewModel: viewModel,
                                  ),
                                ),
                              ).then((value) {
                                if (value == 'updateLanguage') {
                                  viewModel.getProfile();
                                }
                              });
                            },
                            child: buildLanguage(),
                          ),
                          _buildCustomRoundedContainer(
                            onEditPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditApplyPositionScreen(
                                    viewModel: viewModel,
                                  ),
                                ),
                              ).then((value) {
                                if (value == 'updateApplyPosition') {
                                  viewModel.getProfile();
                                }
                              });
                            },
                            child: buildApplicationPositions(),
                          ),
                          _buildCustomRoundedContainer(
                            child: InkWell(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoAlertDialog(
                                    title: Text('LOG OUT'),
                                    scrollController: ScrollController(),
                                    content: Text(
                                        'Are you sure you want to log out?'),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          viewModel.logOut(onSuccess: () {
                                            setState(() {
                                              context.popAndPushNamed(
                                                Routes.integratedAuth,
                                              );
                                            });
                                          });
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 13.w,
                                  ),
                                  Text("LOG OUT",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomRoundedContainer({
    required Widget child,
    VoidCallback? onEditPressed,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        gradient: LinearGradient(
          end: Alignment.topLeft,
          begin: Alignment.bottomRight,
          stops: [-0.5, 1.3],
          colors: [
            Color(0xFFFFEBB2),
            Colors.white,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 25.h,
              bottom: 20.h,
              right: 30.w,
              left: 30.w,
            ),
            child: child,
          ),
          onEditPressed != null
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: onEditPressed,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Builder buildAvatarImage() {
    return Builder(
      builder: (context) {
        final userImage = context
            .select<ProfileViewModel, String?>((vm) => vm.company?.avatar);
        return InkWell(
          onTap: () async {
            final List<File> file = await ImagePickerHelper.showImagePicker(
                context: context,
                multiSelection: false,
                withCameraOption: true);
            viewModel.updateAvatar(file: file.first);
          },
          child: DisplayImage(
            urlPath: userImage,
            gender: true,
            onPressed: () {},
          ),
        );
      },
    );
  }

  Builder buildEstablishedDate() {
    return Builder(
      builder: (context) {
        final dob = context.select<ProfileViewModel, String?>(
            (vm) => vm.company?.establishedDate);
        return buildUserInfoDisplay(
          getValue: dob != null ? dob.toDateTime.toDayMonthYear() : 'N/A',
          title: 'Date of Birth',
          editPage: const EditPhoneFormPage(),
          detailContent: Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                      dob != null ? dob.toDateTime.toDayMonthYear() : 'N/A'))),
          dialogTitle: const Text('Date of Birth'),
        );
      },
    );
  }

  Builder buildPhone() {
    return Builder(builder: (context) {
      final userPhone = context
          .select<ProfileViewModel, String?>((vm) => vm.company?.phoneNumber);
      return buildUserInfoDisplay(
        getValue: userPhone ?? '',
        title: 'Phone',
        editPage: const EditPhoneFormPage(),
        detailContent: Card(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(userPhone ?? ''))),
        dialogTitle: const Text('Phone number'),
      );
    });
  }

  Builder buildAddress() {
    return Builder(builder: (context) {
      final address = context
          .select<ProfileViewModel, String?>((vm) => vm.company?.address);
      return buildUserInfoDisplay(
        getValue: address ?? '',
        title: 'Address',
        editPage: const EditPhoneFormPage(),
        detailContent: Card(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(address ?? ''))),
        dialogTitle: const Text('Address'),
      );
    });
  }

  Builder buildCompanyName() {
    return Builder(
      builder: (context) {
        final companyName = context
            .select<ProfileViewModel, String?>((vm) => vm.company?.companyName);

        return buildUserInfoDisplay(
          getValue: companyName ?? '',
          title: 'Company Name',
          editPage: const EditEmailFormPage(),
          detailContent: Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(companyName ?? ''))),
          dialogTitle: const Text('Company Name'),
        );
      },
    );
  }

  Builder buildCompanyUrl() {
    return Builder(
      builder: (context) {
        final companyUrl = context
            .select<ProfileViewModel, String?>((vm) => vm.company?.companyUrl);

        return buildUserInfoDisplay(
          getValue: companyUrl ?? '',
          title: 'Company URL',
          editPage: const EditEmailFormPage(),
          detailContent: Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(companyUrl ?? ''))),
          dialogTitle: const Text('Company URL'),
        );
      },
    );
  }

  Builder buildEmail() {
    return Builder(
      builder: (context) {
        final userEmail = context
            .select<ProfileViewModel, String?>((vm) => vm.company?.email);

        return buildUserInfoDisplay(
          getValue: userEmail ?? '',
          title: 'Email',
          editPage: const EditEmailFormPage(),
          detailContent: Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(userEmail ?? ''))),
          dialogTitle: const Text('Email'),
        );
      },
    );
  }

  Builder buildApplicationPositions() {
    return Builder(
      builder: (context) {
        final applicationPositions =
            context.select<ProfileViewModel, List<ApplicationPosition>?>(
                (vm) => vm.company?.applicationPositions);
        final allApplicationPositionName = applicationPositions
            ?.map((e) => e.applyPosition?.constantName ?? '')
            .join(', ');

        final applicationCards =
            applicationPositions?.map((applicationPosition) {
                  final positionSkills = applicationPosition.skills;
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Position: ${applicationPosition.applyPosition?.constantName}'),
                          Row(
                            children: [
                              Text('Skills: '),
                              Expanded(
                                child: Wrap(
                                  children: positionSkills == null
                                      ? []
                                      : positionSkills.map((skill) {
                                          return Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                  '${skill.skill?.constantName}'),
                                            ),
                                          );
                                        }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList() ??
                [];
        return buildUserInfoDisplay(
          getValue: allApplicationPositionName ?? '',
          title: 'Application Positions',
          editPage: const EditPhoneFormPage(),
          dialogTitle: Text("Application Position"),
          detailContent: Column(children: applicationCards),
        );
      },
    );
  }

  Builder buildLanguage() {
    return Builder(
      builder: (context) {
        final listLanguages = context.select<ProfileViewModel, List<Language>?>(
            (vm) => vm.company?.languages);
        final allLanguageNames = listLanguages
            ?.map((e) => e.languageConstant?.constantName ?? '')
            .join(', ');

        final allLanguageDetail = listLanguages
            ?.map(
              (e) => Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRichKeyValue(context, 'Language: ',
                          e.languageConstant?.constantName ?? ''),
                      buildRichKeyValue(context, 'Score: ', e.score.toString()),
                      buildRichKeyValue(context, 'Certificate Date: ',
                          e.certificateDate.toDateTime.toDayMonthYear()),
                    ],
                  ),
                ),
              ),
            )
            .toList();
        return buildUserInfoDisplay(
          getValue: allLanguageNames ?? '',
          title: 'Languages',
          editPage: const EditPhoneFormPage(),
          detailContent: Column(
            children: allLanguageDetail ?? [],
          ),
          dialogTitle: const Text('Languages'),
        );
      },
    );
  }

  Builder buildApplyPositions() {
    return Builder(
      builder: (context) {
        final listApplyPositions =
            context.select<ProfileViewModel, List<ApplicationPosition>?>(
                (vm) => vm.company?.applicationPositions);
        final allLanguageNames = listApplyPositions
            ?.map((e) => e.applyPosition?.constantName ?? '')
            .join(', ');

        final allLanguageDetail = listApplyPositions
            ?.map(
              (e) => Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRichKeyValue(context, 'Position: ',
                          e.applyPosition?.constantName ?? ''),
                      buildRichKeyValue(context, 'Salary: ',
                          e.salaryRange?.constantName ?? ''),
                      buildRichKeyValue(
                          context,
                          'Skills: ',
                          e.skills
                                  ?.map((e) => e.skill?.constantName ?? '')
                                  .join(', ') ??
                              ''),
                    ],
                  ),
                ),
              ),
            )
            .toList();
        return buildUserInfoDisplay(
          getValue: allLanguageNames ?? '',
          title: 'Apply Positions',
          editPage: const EditPhoneFormPage(),
          detailContent: Column(
            children: allLanguageDetail ?? [],
          ),
          dialogTitle: const Text('Apply Positions'),
        );
      },
    );
  }

  RichText buildRichKeyValue(
      BuildContext context, String title, String content) {
    return RichText(
      text: TextSpan(
        text: title,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: content,
            style: DefaultTextStyle.of(context).style,
          ),
        ],
      ),
    );
  }

  Widget buildUserInfoDisplay({
    required String getValue,
    required String title,
    required Widget editPage,
    Text? dialogTitle,
    Widget? detailContent,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title + ": ",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              child: InkWell(
                onTap: () {
                  navigateSecondPage(
                    detailContent: detailContent ?? Text("CONTENT"),
                    editForm: editPage,
                    dialogTitle: dialogTitle,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        getValue,
                        style: const TextStyle(
                            fontSize: 16,
                            height: 1.4,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void navigateSecondPage(
      {required Widget detailContent,
      required Widget editForm,
      Widget? dialogTitle}) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: dialogTitle ?? Text('Choose an option'),
        scrollController: ScrollController(),
        content: detailContent,
      ),
    );
  }
}
