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
import 'package:pbl5/screens/profile/widgets/display_image_widget.dart';
import 'package:pbl5/screens/profile/widgets/secondary_card.dart';
import 'package:pbl5/screens/profile/widgets/util_big_card.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/date_time_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/helpers/image_helper.dart';
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
    if (viewModel.company == null) {
      viewModel.getProfile();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      canPop: false,
      viewModel: viewModel,
      appBar: AppBar(
        title: const Text(
          'JobSwipe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.pink,
          ),
        ),
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        elevation: 0,
      ),
      mobileBuilder: (context) {
        return RefreshIndicator(
          color: Colors.pink,
          onRefresh: () async {
            viewModel.getProfile();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildAvatarImage(),
                              SizedBox(width: 5.w),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditBasicProfileScreen(
                                          viewModel: viewModel,
                                        ),
                                      ),
                                    ).then((value) {
                                      if (value == 'updateProfile') {
                                        viewModel.getProfile();
                                      }
                                    });
                                  },
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        _buildCompanyName(),
                                        _buildEmail(),
                                        _buildDOB(),
                                        _buildPhone(),
                                        _buildAdress(),
                                        _buildCompanyUrl(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // _buildTitle(title: 'Overview'),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => EditBasicProfileScreen(
                        //           viewModel: viewModel,
                        //         ),
                        //       ),
                        //     ).then((value) {
                        //       if (value == 'updateProfile') {
                        //         viewModel.getProfile();
                        //       }
                        //     });
                        //   },
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width,
                        //     margin: EdgeInsets.symmetric(
                        //       vertical: 10.h,
                        //       horizontal: 10.w,
                        //     ),
                        //     padding: EdgeInsets.symmetric(
                        //       vertical: 16.h,
                        //       horizontal: 10.w,
                        //     ),
                        //     decoration: BoxDecoration(
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.grey.withOpacity(0.5),
                        //           spreadRadius: 2,
                        //           blurRadius: 3,
                        //           offset: Offset(0, 3),
                        //         ),
                        //       ],
                        //       gradient: LinearGradient(
                        //         end: Alignment.topLeft,
                        //         begin: Alignment.bottomRight,
                        //         stops: [0.0, 1.3],
                        //         colors: [
                        //           Color(0xFFFFEBB2),
                        //           Colors.white,
                        //         ],
                        //       ),
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(15.r)),
                        //     ),
                        //     child: _buildSummaryInfo(),
                        //   ),
                        // ),
                        _buildTitle(title: 'Information'),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildPositionCard(),
                              _buildLanguageCard(),
                            ],
                          ),
                        ),
                        _buildTitle(title: 'Setting'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            children: [
                              _buildChangePasswordButton(),
                              _buildLogoutButton(context),
                            ],
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
        );
      },
    );
  }

  InkWell _buildChangePasswordButton() {
    return InkWell(
      onTap: () {},
      child: SecondaryCard(
        title: 'Change Password',
        icondata: Icons.key,
        color: Color(0xFFFFADA5),
      ),
    );
    //#f77d8e, #ff8d77, #fca463, #edbc5a, #d4d462
  }

  Builder _buildLanguageCard() {
    return Builder(builder: (context) {
      final listLanguages = context.select<ProfileViewModel, List<Language>?>(
          (vm) => vm.company?.languages);
      final allLanguageNames = listLanguages
          ?.map((e) => e.languageConstant?.constantName ?? '')
          .join(', ');

      final allLanguageDetail = listLanguages
          ?.map(
            (e) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRichKeyValue(context, 'Language: ',
                      e.languageConstant?.constantName ?? ''),
                  buildRichKeyValue(context, 'Score: ', e.score.toString()),
                  buildRichKeyValue(context, 'Certificate Date: ',
                      e.certificateDate.toDateTime.toDayMonthYear()),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
          .toList();
      return InkWell(
        onTap: () {
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
        child: UtilBigCard(
          scrollController: ScrollController(),
          color: lightPink.withOpacity(0.8),
          title: "Language",
          child: Column(
            children: allLanguageDetail ?? [],
          ),
        ),
      );
    });
  }

  Builder _buildPositionCard() {
    return Builder(builder: (context) {
      final applicationPositions =
          context.select<ProfileViewModel, List<ApplicationPosition>?>(
              (vm) => vm.company?.applicationPositions);
      final allApplicationPositionName = applicationPositions
          ?.map((e) => e.applyPosition?.constantName ?? '')
          .join(', ');

      final applicationCards = applicationPositions?.map((applicationPosition) {
            final positionSkills = applicationPosition.skills;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRichKeyValue(context, 'Position: ',
                      applicationPosition.applyPosition?.constantName ?? ''),
                  Row(
                    children: [
                      Text(
                        'Skills: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                      Expanded(
                        child: Wrap(
                          children: positionSkills == null
                              ? []
                              : positionSkills.map((skill) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child:
                                          Text('${skill.skill?.constantName}'),
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            );
          }).toList() ??
          [];
      return InkWell(
        onTap: () {
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
        child: UtilBigCard(
          scrollController: ScrollController(),
          color: lightBlue,
          title: "Opening Position",
          child: Column(
            children: applicationCards,
          ),
        ),
      );
    });
  }

  InkWell _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('LOG OUT'),
            scrollController: ScrollController(),
            content: Text('Are you sure you want to log out?'),
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
      child: SecondaryCard(
        title: 'Log out',
        icondata: Icons.logout_outlined,
      ),
    );
  }

  RichText buildRichKeyValue(
      BuildContext context, String title, String content) {
    return RichText(
      text: TextSpan(
        text: title,
        style: DefaultTextStyle.of(context).style.copyWith(
              fontSize: 15.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
        children: <TextSpan>[
          TextSpan(
              text: content,
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: 15.sp,
                    color: Colors.white,
                  )),
        ],
      ),
    );
  }

  // Builder _buildSummaryInfo() {
  //   return Builder(builder: (context) {
  //     final userSI = context.select<ProfileViewModel, String?>(
  //         (vm) => vm.company?.summaryIntroduction);
  //
  //     return Padding(
  //       padding: EdgeInsets.symmetric(
  //         horizontal: 16.w,
  //       ),
  //       child: Text(
  //         '\t\t\t' + (userSI ?? ''),
  //         style: TextStyle(
  //           fontSize: 13.sp,
  //           color: Colors.black87,
  //         ),
  //       ),
  //     );
  //   });
  // }

  Padding _buildTitle({
    required String title,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 7.h,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17.sp,
          color: Colors.pinkAccent.shade700,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Builder _buildAdress() {
    return Builder(builder: (context) {
      final address = context
          .select<ProfileViewModel, String?>((vm) => vm.company?.address);
      return Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: Row(
          children: [
            Icon(
              Icons.location_on_rounded,
              color: Colors.pinkAccent.shade700,
              size: 18.r,
            ),
            SizedBox(width: 15.w),
            Flexible(
              child: Text(
                address ?? '',
                style: TextStyle(
                  fontSize: 13.sp,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Builder _buildPhone() {
    return Builder(builder: (context) {
      final companyPhone = context
          .select<ProfileViewModel, String?>((vm) => vm.company?.phoneNumber);
      return Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: Row(
          children: [
            Icon(
              Icons.phone,
              color: Colors.pinkAccent.shade700,
              size: 18.r,
            ),
            SizedBox(width: 15.w),
            Flexible(
              child: Text(
                companyPhone ?? '',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Builder _buildDOB() {
    return Builder(builder: (context) {
      final establishedDate = context.select<ProfileViewModel, String?>(
          (vm) => vm.company?.establishedDate);
      return Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: Row(
          children: [
            Icon(
              Icons.date_range,
              color: Colors.pinkAccent.shade700,
              size: 18.r,
            ),
            SizedBox(width: 15.w),
            Flexible(
              child: Text(
                establishedDate != null
                    ? establishedDate.toDateTime.toDayMonthYear()
                    : '',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Builder _buildCompanyUrl() {
    return Builder(builder: (context) {
      final companyUrl = context
          .select<ProfileViewModel, String?>((vm) => vm.company?.companyUrl);
      return Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: Row(
          children: [
            Icon(
              Icons.link,
              color: Colors.pinkAccent.shade700,
              size: 18.r,
            ),
            SizedBox(width: 15.w),
            Flexible(
              child: Text(
                companyUrl ?? '',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Builder _buildEmail() {
    return Builder(builder: (context) {
      final email =
          context.select<ProfileViewModel, String?>((vm) => vm.company?.email);

      return Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: Row(
          children: [
            Icon(
              Icons.mail,
              color: Colors.pinkAccent.shade700,
              size: 18.r,
            ),
            SizedBox(width: 15.h),
            Flexible(
              child: Text(
                email ?? '',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Builder _buildCompanyName() {
    return Builder(builder: (context) {
      final companyName = context
          .select<ProfileViewModel, String?>((vm) => vm.company?.companyName);
      return Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: Row(
          children: [
            Icon(
              Icons.location_city,
              color: Colors.pinkAccent.shade700,
              size: 18.r,
            ),
            SizedBox(width: 15.h),
            Flexible(
              child: Text(
                (companyName ?? ''),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      );
    });
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
}
