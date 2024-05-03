import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/user_awards/user_awards.dart';
import 'package:pbl5/models/user_educations/user_educations.dart';
import 'package:pbl5/models/user_experiences/user_experiences.dart';
import 'package:pbl5/routes.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/edit_profile/edit_award_screen.dart';
import 'package:pbl5/screens/edit_profile/edit_basic_profile_screen.dart';
import 'package:pbl5/screens/edit_profile/edit_education_screen.dart';
import 'package:pbl5/screens/edit_profile/edit_experience_screen.dart';
import 'package:pbl5/screens/profile/edit_email.dart';
import 'package:pbl5/screens/profile/edit_image.dart';
import 'package:pbl5/screens/profile/edit_name.dart';
import 'package:pbl5/screens/profile/edit_phone.dart';
import 'package:pbl5/screens/profile/widgets/display_image_widget.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/date_time_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/view_models/profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModel viewModel;

  @override
  void initState() {
    viewModel = getIt.get<ProfileViewModel>();
    // getIt.get<ProfileViewModel>().getProfile();
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
                    padding: EdgeInsets.only(
                        top: 30.h, bottom: 80.h, left: 15.w, right: 15.w),
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
                                buildFullname(),
                                buildSummaryIntro(),
                                buildEmail(),
                                buildSocialMediaLink(),
                                buildAddress(),
                                buildPhone(),
                                buildDOB(),
                              ],
                            ),
                          ),
                          _buildCustomRoundedContainer(
                            onAddPressed: () {},
                            onEditPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditEducationScreen(
                                    viewModel: viewModel,
                                  ),
                                ),
                              ).then((value) {
                                if (value == 'updateEducation') {
                                  viewModel.getProfile();
                                }
                              });
                            },
                            child: buildEducation(),
                          ),
                          _buildCustomRoundedContainer(
                            onAddPressed: () {},
                            onEditPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAwardScreen(
                                    viewModel: viewModel,
                                  ),
                                ),
                              ).then((value) {
                                if (value == 'updateEducation') {
                                  viewModel.getProfile();
                                }
                              });
                            },
                            child: buildAward(),
                          ),
                          _buildCustomRoundedContainer(
                            onAddPressed: () {},
                            onEditPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditExperienceScreen(
                                    viewModel: viewModel,
                                  ),
                                ),
                              ).then((value) {
                                if (value == 'updateEducation') {
                                  viewModel.getProfile();
                                }
                              });
                            },
                            child: buildExperience(),
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
                            height: 40.h,
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
    VoidCallback? onAddPressed,
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
          end: Alignment.topCenter,
          begin: Alignment.bottomCenter,
          stops: [0.0, 1.3],
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
          onAddPressed != null
              ? Positioned(
                  top: 0,
                  right: 46,
                  child: IconButton(
                    onPressed: onAddPressed,
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 27,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
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

  Builder buildSocialMediaLink() {
    return Builder(
      builder: (context) {
        final socialMediaLinks =
            context.select<ProfileViewModel, List<String>?>(
                (vm) => vm.user?.socialMediaLink);
        final allSocialMediaLinks = socialMediaLinks?.join(', ');

        final allSocialMediaDetail = socialMediaLinks
            ?.map(
              (link) => Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    link,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
            .toList();

        return buildUserInfoDisplay(
          getValue: allSocialMediaLinks ?? '',
          title: 'Social Media Links',
          editPage: EditNameFormPage(
            viewModel: viewModel,
          ),
          detailContent: Column(
            children: allSocialMediaDetail ?? [],
          ),
          dialogTitle: Text('Social Media Links'),
        );
      },
    );
  }

  Builder buildAvatarImage() {
    return Builder(
      builder: (context) {
        final userImage =
            context.select<ProfileViewModel, String?>((vm) => vm.user?.avatar);
        final gender =
            context.select<ProfileViewModel, bool?>((vm) => vm.user?.gender);
        return InkWell(
          onTap: () {
            navigateSecondPage(
              editForm: const EditImagePage(),
              detailContent: const Text("CONTENT"),
            );
          },
          child: DisplayImage(
            urlPath: userImage,
            gender: gender,
            onPressed: () {},
          ),
        );
      },
    );
  }

  Builder buildExperience() {
    return Builder(
      builder: (context) {
        final listUserExperiences =
            context.select<ProfileViewModel, List<UserExperiences>?>(
                (vm) => vm.user?.experiences);
        final allJobTitles = listUserExperiences
            ?.map(
              (e) => (e.position ?? '') + ' at ' + (e.workPlace ?? ''),
            )
            .join(', ');
        final allExperienceDetail = listUserExperiences
            ?.map((e) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRichKeyValue(
                            context, 'Position: ', e.position ?? ''),
                        buildRichKeyValue(
                            context, 'Work Place: ', e.workPlace ?? ''),
                        buildRichKeyValue(
                            context,
                            'Start date: ',
                            e.experienceStartTime.toDateTime.toDayMonthYear() ??
                                ''),
                        buildRichKeyValue(
                            context,
                            'End date: ',
                            e.experienceEndTime.toDateTime.toDayMonthYear() ??
                                ''),
                        buildRichKeyValue(context, 'Type: ',
                            e.experienceType?.constantName ?? ''),
                        buildRichKeyValue(context, 'Note: ', e.note ?? ''),
                      ],
                    ),
                  ),
                ))
            .toList();

        return buildUserInfoDisplay(
          getValue: allJobTitles ?? '',
          title: 'Experiences',
          editPage: const EditPhoneFormPage(),
          dialogTitle: Text("Experiences"),
          detailContent: Column(children: allExperienceDetail ?? []),
        );
      },
    );
  }

  Builder buildAward() {
    return Builder(
      builder: (context) {
        final listUserAwards =
            context.select<ProfileViewModel, List<UserAwards>?>(
                (vm) => vm.user?.awards);
        final allAwardName =
            listUserAwards?.map((e) => e.certificateName ?? '').join(', ');

        final allAwardDetail = listUserAwards
            ?.map((a) => Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRichKeyValue(context, 'Certificate Name: ',
                            a.certificateName ?? ''),
                        buildRichKeyValue(
                            context,
                            'Certificate Time: ',
                            a.certificateTime.toDateTime.toDayMonthYear() ??
                                ''),
                        buildRichKeyValue(context, 'Note: ', a.note ?? ''),
                      ],
                    ),
                  ),
                ))
            .toList();

        return buildUserInfoDisplay(
          getValue: allAwardName ?? '',
          title: 'Awards',
          editPage: const EditPhoneFormPage(),
          dialogTitle: Text("Awards"),
          detailContent: Column(children: allAwardDetail ?? []),
        );
      },
    );
  }

  Builder buildDOB() {
    return Builder(
      builder: (context) {
        final dob =
            context.select<ProfileViewModel, String?>((vm) => vm.user?.dob);
        return buildUserInfoDisplay(
          getValue: dob != null ? dob.toDateTime.toDayMonthYear() ?? '' : 'N/A',
          title: 'Date of Birth',
          editPage: const EditPhoneFormPage(),
          detailContent: Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(dob != null
                      ? dob.toDateTime.toDayMonthYear() ?? ''
                      : 'N/A'))),
          dialogTitle: const Text('Date of Birth'),
        );
      },
    );
  }

  Builder buildPhone() {
    return Builder(builder: (context) {
      final userPhone = context
          .select<ProfileViewModel, String?>((vm) => vm.user?.phoneNumber);
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
      final address =
          context.select<ProfileViewModel, String?>((vm) => vm.user?.address);
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

  Builder buildEmail() {
    return Builder(
      builder: (context) {
        final userEmail =
            context.select<ProfileViewModel, String?>((vm) => vm.user?.email);

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

  Builder buildSummaryIntro() {
    return Builder(
      builder: (context) {
        final userSI = context.select<ProfileViewModel, String?>(
            (vm) => vm.user?.summaryIntroduction);

        return buildUserInfoDisplay(
          getValue: userSI ?? '',
          title: 'Summary Introduction',
          editPage: const EditEmailFormPage(),
          detailContent: Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(userSI ?? ''))),
          dialogTitle: const Text('Summary Introduction'),
        );
      },
    );
  }

  Builder buildFullname() {
    return Builder(builder: (context) {
      final userFirstName =
          context.select<ProfileViewModel, String?>((vm) => vm.user?.firstName);
      final userLastName =
          context.select<ProfileViewModel, String?>((vm) => vm.user?.lastName);
      return buildUserInfoDisplay(
        getValue: (userLastName ?? '') + " " + (userFirstName ?? ''),
        title: 'Name',
        editPage: EditNameFormPage(
          viewModel: viewModel,
        ),
        detailContent: Card(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                    Text((userLastName ?? '') + " " + (userFirstName ?? '')))),
        dialogTitle: const Text('Name'),
      );
    });
  }

  Builder buildEducation() {
    return Builder(
      builder: (context) {
        final listEducation =
            context.select<ProfileViewModel, List<UserEducations>?>(
                (vm) => vm.user?.educations);
        final allStudyPlaces =
            listEducation?.map((e) => e.studyPlace ?? '').join(', ');

        final allStudyDetail = listEducation
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
                      buildRichKeyValue(
                          context, 'Study place: ', e.studyPlace ?? ''),
                      buildRichKeyValue(
                          context, 'Majority: ', e.majority ?? ''),
                      buildRichKeyValue(context, 'Start date: ',
                          e.studyStartTime.toDateTime.toDayMonthYear() ?? ''),
                      buildRichKeyValue(context, 'End date: ',
                          e.studyEndTime.toDateTime.toDayMonthYear() ?? ''),
                      buildRichKeyValue(
                          context, 'CPA: ', e.cpa.toString() ?? ''),
                      buildRichKeyValue(context, 'Note: ', e.note ?? ''),
                    ],
                  ),
                ),
              ),
            )
            .toList();
        return buildUserInfoDisplay(
          getValue: allStudyPlaces ?? '',
          title: 'Education',
          editPage: const EditPhoneFormPage(),
          detailContent: Column(
            children: allStudyDetail ?? [],
          ),
          dialogTitle: const Text('Education'),
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
