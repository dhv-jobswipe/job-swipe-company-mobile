import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/app_common_data/enums/system_constant_prefix.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/app_data.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/insert_profile/insert_experience_screen.dart';
import 'package:pbl5/screens/login/components/sign_in_form.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/widgets/confirm_dialog_alert.dart';
import 'package:pbl5/shared_customization/widgets/custom_drop_down_button.dart';
import 'package:pbl5/shared_customization/widgets/custom_rounded_container.dart';
import 'package:pbl5/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class EditExperienceScreen extends StatefulWidget {
  final ProfileViewModel viewModel;

  EditExperienceScreen({super.key, required this.viewModel});

  @override
  State<EditExperienceScreen> createState() => _EditExperienceScreenState();
}

class _EditExperienceScreenState extends State<EditExperienceScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  late SMITrigger confetti;

  void onUpdateExperience(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        await widget.viewModel.updateExperience(
          onSuccess: () {
            check.fire();
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                isShowLoading = false;
              });
              confetti.fire();
            }).then(
              (e) => Future.delayed(
                Duration(seconds: 1),
                () => Navigator.of(context).pop(),
              ),
            );
          },
          onFailure: (e) {
            debugPrint("Failed: $e");
            error.fire();
            Future.delayed(
              Duration(seconds: 2),
              () {
                setState(() {
                  isShowLoading = false;
                });
              },
            );
          },
        );
      } else {
        error.fire();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
          confetti.fire();
        });
      }
    });
  }

  void onDeleteExperience(BuildContext context, {required int index}) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        await widget.viewModel.deleteExperience(
          index: index,
          onSuccess: () {
            check.fire();
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                isShowLoading = false;
              });
              confetti.fire();
            }).then(
              (e) => Future.delayed(
                Duration(seconds: 1),
                () => {},
              ),
            );
          },
          onFailure: (e) {
            debugPrint("Failed: $e");
            error.fire();
            Future.delayed(
              Duration(seconds: 2),
              () {
                setState(() {
                  isShowLoading = false;
                });
              },
            );
          },
        );
      } else {
        error.fire();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
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
          'Edit Experience',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: orangePink,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
          ),
          onPressed: () {
            context.pop('updateProfile');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InsertExperienceScreen(
                    viewModel: widget.viewModel,
                  ),
                ),
              ).then((value) {
                if (value == 'addExperience') {
                  setState(() {
                    widget.viewModel.getProfile();
                  });
                }
              });
            },
          ),
        ],
      ),
      mobileBuilder: (context) {
        debugPrint(widget.viewModel.studyEndTimeControllers.toString() ?? '');
        return Stack(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: widget.viewModel.user?.experiences == []
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            ...List.generate(
                              widget.viewModel.user?.experiences.length ?? 0,
                              (index) => CustomizedRoundedContainer(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Experience " +
                                              (index + 1).toString() +
                                              ": ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            showCupertinoDialog(
                                                context: context,
                                                builder: (context) {
                                                  return ConfirmDialogAlert(
                                                    title: 'Delete Experience',
                                                    content:
                                                        "Are you sure you want to delete this experience?",
                                                    confirmText: 'Delete',
                                                    onConfirm: () {
                                                      onDeleteExperience(
                                                          context,
                                                          index: index);
                                                    },
                                                  );
                                                });
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    TextFormField(
                                      controller: widget.viewModel
                                          .expStartTimeControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Experience Start Time',
                                      ),
                                      onTap: () async {
                                        final DateTime? picked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: widget
                                              .viewModel
                                              .expStartTimeControllers[index]
                                              .text
                                              .toInitialDateTime,
                                          firstDate: DateTime(1900, 1),
                                          lastDate: DateTime.now(),
                                        );
                                        if (picked != null)
                                          widget
                                              .viewModel
                                              .expStartTimeControllers[index]
                                              .text = DateFormat(
                                                  'dd-MM-yyyy')
                                              .format(picked);
                                      },
                                      readOnly: true,
                                    ),
                                    TextFormField(
                                      controller: widget.viewModel
                                          .expEndTimeControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Experience End Time',
                                      ),
                                      onTap: () async {
                                        final DateTime? picked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: widget
                                              .viewModel
                                              .expEndTimeControllers[index]
                                              .text
                                              .toInitialDateTime,
                                          firstDate: DateTime(1900, 1),
                                          lastDate: DateTime.now(),
                                        );
                                        if (picked != null)
                                          widget
                                                  .viewModel
                                                  .expEndTimeControllers[index]
                                                  .text =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(picked);
                                      },
                                      readOnly: true,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final value = context.select(
                                            (ProfileViewModel vm) =>
                                                vm.selectedSystemConstants[
                                                    index]);
                                        return CustomDropdownButton(
                                          label: "Experience Type",
                                          placeholder: "Select Experience Type",
                                          onChanged: (value) {
                                            if (value != null) {
                                              widget.viewModel
                                                      .selectedSystemConstants[
                                                  index] = value;
                                              widget.viewModel.updateUI();
                                            }
                                          },
                                          value: value,
                                          items: getIt
                                              .get<AppData>()
                                              .systemConstants[
                                                  SystemConstantPrefix
                                                      .EXPERIENCE_TYPE]!
                                              .map((e) => DropdownItemModel(
                                                  label: e.constantName!,
                                                  value: e))
                                              .toList(),
                                          selectedCondition: (item) =>
                                              item?.constantId ==
                                              value.constantId,
                                          borderColor: Colors.transparent,
                                          contentPadding: EdgeInsets.zero,
                                        );
                                      },
                                    ),
                                    TextFormField(
                                      controller: widget.viewModel
                                          .workPlaceControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Work Place',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: widget
                                          .viewModel.positionControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Position',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: widget
                                          .viewModel.expNoteControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Note',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            buildSaveButton(context, onPressed: () {
                              onUpdateExperience(context);
                            }),
                            SizedBox(
                              height: 60.h,
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

Padding buildSaveButton(BuildContext context,
    {required VoidCallback onPressed}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 0),
    child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF77D8E),
            minimumSize: const Size(double.infinity, 56),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)))),
        icon: const Icon(
          CupertinoIcons.arrow_right,
          color: Colors.white,
        ),
        label: Text(
          "SAVE",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            wordSpacing: 1.2,
          ),
        )),
  );
}
