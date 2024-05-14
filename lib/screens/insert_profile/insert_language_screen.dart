import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/app_common_data/enums/system_constant_prefix.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/app_data.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/login/components/sign_in_form.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/widgets/custom_drop_down_button.dart';
import 'package:pbl5/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

//git commit -m "PBL-555 <message>"
//git commit -m "PBL-554 <message>"
class InsertLanguageScreen extends StatefulWidget {
  final ProfileViewModel viewModel;

  InsertLanguageScreen({super.key, required this.viewModel});

  @override
  State<InsertLanguageScreen> createState() => _InsertLanguageScreenState();
}

class _InsertLanguageScreenState extends State<InsertLanguageScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  late SMITrigger confetti;

  void onAddExperience(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        await widget.viewModel.insertLanguage(
          onSuccess: () {
            check.fire();
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                isShowLoading = false;
              });
              confetti.fire();
            }).then(
              (e) => Future.delayed(Duration(seconds: 1), () async {
                await widget.viewModel
                    .getProfile()
                    .then((value) => context.pop('addLanguage'));
              }),
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
          'Add Education',
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
            context.pop();
          },
        ),
      ),
      mobileBuilder: (context) {
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
                  child: Column(
                    children: [
                      TextFormField(
                        controller: widget.viewModel.addCertifiedDateController,
                        decoration: InputDecoration(
                          labelText: 'Certificate Date',
                        ),
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: widget
                                .viewModel
                                .addCertifiedDateController
                                .text
                                .toInitialDateTime,
                            firstDate: DateTime(1900, 1),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null)
                            widget.viewModel.addCertifiedDateController.text =
                                DateFormat('dd-MM-yyyy').format(picked);
                        },
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Builder(
                        builder: (context) {
                          final value = context.select((ProfileViewModel vm) =>
                              vm.addSelectedLanguageSystemConstant);
                          return CustomDropdownButton(
                            placeholder: "Select Experience Type",
                            onChanged: (value) {
                              if (value != null) {
                                widget.viewModel
                                    .addSelectedLanguageSystemConstant = value;
                                widget.viewModel.updateUI();
                              }
                            },
                            value: value,
                            items: getIt
                                .get<AppData>()
                                .systemConstants[SystemConstantPrefix.LANGUAGE]!
                                .map((e) => DropdownItemModel(
                                    label: e.constantName!, value: e))
                                .toList(),
                            selectedCondition: (item) =>
                                item?.constantId == value?.constantId,
                            borderColor: Colors.transparent,
                            contentPadding: EdgeInsets.zero,
                          );
                        },
                      ),
                      TextFormField(
                        controller: widget.viewModel.addLanguageScoreController,
                        decoration: InputDecoration(
                          labelText: 'Score',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter score';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            onAddExperience(context);
                          },
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
