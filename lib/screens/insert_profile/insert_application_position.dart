import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/app_common_data/enums/system_constant_prefix.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/app_data.dart';
import 'package:pbl5/models/application_position/application_position.dart';
import 'package:pbl5/models/skill/skill.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/login/components/sign_in_form.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/list_ext.dart';
import 'package:pbl5/shared_customization/helpers/dialogs/dialog_helper.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_button.dart';
import 'package:pbl5/shared_customization/widgets/custom_drop_down_button.dart';
import 'package:pbl5/view_models/profile_view_model.dart';
import 'package:rive/rive.dart';
import 'package:uuid/uuid.dart';

//git commit -m "PBL-535 <message>"
class InsertApplicationPositionScreen extends StatefulWidget {
  final ProfileViewModel viewModel;

  InsertApplicationPositionScreen({super.key, required this.viewModel});

  @override
  State<InsertApplicationPositionScreen> createState() =>
      _InsertApplicationPositionScreenState();
}

class _InsertApplicationPositionScreenState
    extends State<InsertApplicationPositionScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;

  final positionDropdownModels = getIt
      .get<AppData>()
      .systemConstants[SystemConstantPrefix.APPLY_POSITION]!
      .map((e) => DropdownItemModel(label: e.constantName!, value: e))
      .toList();

  final salaryDropdownModels = getIt
      .get<AppData>()
      .systemConstants[SystemConstantPrefix.SALARY_RANGES]!
      .map((e) => DropdownItemModel(label: e.constantName!, value: e))
      .toList();

  final skillDropdownModels = getIt
      .get<AppData>()
      .systemConstants[SystemConstantPrefix.SKILL]!
      .map((e) => DropdownItemModel(label: e.constantName!, value: e))
      .toList();

  ApplicationPosition currentData = ApplicationPosition.empty;

  void onAddApplyPosition(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        await widget.viewModel.insertApplyPosition(
          currentData,
          onSuccess: () {
            check.fire();
            Future.delayed(Duration(seconds: 2), () {
              setState(() => isShowLoading = false);
              confetti.fire();
            }).then(
              (e) => Future.delayed(Duration(seconds: 1), () async {
                await widget.viewModel
                    .getProfile()
                    .then((value) => context.pop('addApplyPosition'));
              }),
            );
          },
          onFailure: (e) {
            showErrorDialog(context, content: e);
            error.fire();
            Future.delayed(Duration(seconds: 2), () {
              setState(() => isShowLoading = false);
            });
          },
        );
      } else {
        error.fire();
        Future.delayed(Duration(seconds: 2), () {
          setState(() => isShowLoading = false);
          confetti.fire();
        });
      }
    });
  }

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: widget.viewModel,
      backgroundColor: Colors.white,
      canPop: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Add Apply Positions',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: orangePink),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 30),
          onPressed: context.pop,
        ),
      ),
      mobileBuilder: (context) {
        return Stack(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropdownButton<SystemConstant>(
                        label: "Apply Position",
                        placeholder: "Select apply position",
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            currentData =
                                currentData.copyWith(applyPosition: value);
                          });
                        },
                        value: currentData.applyPosition,
                        items: positionDropdownModels,
                        selectedCondition: (item) =>
                            item?.constantId ==
                            currentData.applyPosition?.constantId,
                        borderColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                      ),
                      CustomDropdownButton<SystemConstant>(
                        label: "Salary Range",
                        placeholder: "Select salary range",
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            currentData =
                                currentData.copyWith(salaryRange: value);
                          });
                        },
                        value: currentData.salaryRange,
                        items: salaryDropdownModels,
                        selectedCondition: (item) =>
                            item?.constantId ==
                            currentData.salaryRange?.constantId,
                        borderColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                      ),
                      ...(currentData.skills ?? [])
                          .asMap()
                          .entries
                          .map(
                            (skillEntry) =>
                                CustomDropdownButton<SystemConstant>(
                              label: "Skill ${skillEntry.key + 1}",
                              placeholder: "Select skill ${skillEntry.key + 1}",
                              isShowDeleteIcon: skillEntry.value.isGenerated,
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() {
                                  currentData = currentData.copyWith(
                                      skills: currentData.skills.update(
                                          (e) => e.copyWith(skill: value),
                                          (e) => e.id == skillEntry.value.id));
                                });
                              },
                              onDeleteTap: () {
                                setState(() {
                                  currentData = currentData.copyWith(
                                      skills: currentData.skills
                                          .deleteAt(skillEntry.key));
                                });
                              },
                              value: skillEntry.value.skill,
                              items: skillDropdownModels,
                              selectedCondition: (item) =>
                                  item?.constantId ==
                                  skillEntry.value.skill?.constantId,
                              borderColor: Colors.transparent,
                              contentPadding: EdgeInsets.zero,
                            ),
                          )
                          .toList(),
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            currentData = currentData.copyWith(
                                skills: currentData.skills.insertLast(
                                    Skill(id: Uuid().v4(), isGenerated: true)));
                          });
                        },
                        label: "Add Skill",
                        color: const Color(0xFFF77D8E),
                        margin: const EdgeInsets.only(top: 12),
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 0),
                        child: ElevatedButton.icon(
                          onPressed: () => onAddApplyPosition(context),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF77D8E),
                              minimumSize: const Size(double.infinity, 56),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(25)))),
                          icon: const Icon(CupertinoIcons.arrow_right,
                              color: Colors.white),
                          label: Text(
                            "ADD",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              wordSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isShowLoading
                ? CustomPositioned(
                    child: RiveAnimation.asset(
                    "assets/RiveAssets/check.riv",
                    onInit: (artboard) {
                      StateMachineController controller =
                          getRiveController(artboard);
                      check = controller.findSMI("Check") as SMITrigger;
                      error = controller.findSMI("Error") as SMITrigger;
                      reset = controller.findSMI("Reset") as SMITrigger;
                    },
                  ))
                : const SizedBox(),
            isShowConfetti
                ? CustomPositioned(
                    child: Transform.scale(
                    scale: 6,
                    child: RiveAnimation.asset(
                      "assets/RiveAssets/confetti.riv",
                      onInit: (artboard) {
                        StateMachineController controller =
                            getRiveController(artboard);
                        confetti = controller.findSMI("Trigger explosion")
                            as SMITrigger;
                      },
                    ),
                  ))
                : const SizedBox()
          ],
        );
      },
    );
  }
}
