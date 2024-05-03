import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/login/components/sign_in_form.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/widgets/confirm_dialog_alert.dart';
import 'package:pbl5/shared_customization/widgets/custom_rounded_container.dart';
import 'package:pbl5/view_models/profile_view_model.dart';
import 'package:rive/rive.dart';

class EditEducationScreen extends StatefulWidget {
  final ProfileViewModel viewModel;

  EditEducationScreen({super.key, required this.viewModel});

  @override
  State<EditEducationScreen> createState() => _EditEducationScreenState();
}

class _EditEducationScreenState extends State<EditEducationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  late SMITrigger confetti;

  void onUpdateEducation(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        await widget.viewModel.updateEducation(
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

  void onDeleteEducation(BuildContext context, {required int index}) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        await widget.viewModel.deleteEducation(
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
                () => context.pop(),
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
          'Edit Education',
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
                  child: widget.viewModel.user?.educations == []
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            ...List.generate(
                              widget.viewModel.user?.educations.length ?? 0,
                              (index) => CustomizedRoundedContainer(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Education " +
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
                                                      onDeleteEducation(context,
                                                          index: index);
                                                    },
                                                  );
                                                });
                                          },
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      controller: widget.viewModel
                                          .studyPlaceControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Study Place',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: widget.viewModel
                                          .studyStartTimeControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Study Start Time',
                                      ),
                                      onTap: () async {
                                        final DateTime? picked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900, 1),
                                          lastDate: DateTime.now(),
                                        );
                                        if (picked != null)
                                          widget
                                              .viewModel
                                              .studyStartTimeControllers[index]
                                              .text = DateFormat(
                                                  'dd-MM-yyyy')
                                              .format(picked);
                                      },
                                      readOnly: true,
                                    ),
                                    TextFormField(
                                      controller: widget.viewModel
                                          .studyEndTimeControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Study End Time',
                                      ),
                                      onTap: () async {
                                        final DateTime? picked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900, 1),
                                          lastDate: DateTime.now(),
                                        );
                                        if (picked != null)
                                          widget
                                              .viewModel
                                              .studyEndTimeControllers[index]
                                              .text = DateFormat(
                                                  'dd-MM-yyyy')
                                              .format(picked);
                                      },
                                      readOnly: true,
                                    ),
                                    TextFormField(
                                      controller: widget
                                          .viewModel.majorityControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Majority',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: widget
                                          .viewModel.cpaControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'CPA',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: widget
                                          .viewModel.eduNoteControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Note',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            buildSaveButton(context, onPressed: () {
                              onUpdateEducation(context);
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

  Column buildGenderSelector() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 4.h,
        ),
        Text('Gender', style: TextStyle(fontSize: 13, color: Colors.black87)),
        Row(
          children: <bool>[true, false].map((bool value) {
            return Row(
              children: [
                Radio<bool>(
                  value: value,
                  groupValue: widget.viewModel.gender,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.viewModel.gender = value!;
                    });
                  },
                ),
                Text(value ? 'Male' : 'Female'),
              ],
            );
          }).toList(),
        ),
        Divider(
          color: Colors.black54,
        ),
      ],
    );
  }
}
