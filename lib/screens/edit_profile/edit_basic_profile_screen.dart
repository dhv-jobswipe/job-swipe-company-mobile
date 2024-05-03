import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/login/components/sign_in_form.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/view_models/profile_view_model.dart';
import 'package:rive/rive.dart';

class EditBasicProfileScreen extends StatefulWidget {
  final ProfileViewModel viewModel;

  EditBasicProfileScreen({super.key, required this.viewModel});

  @override
  State<EditBasicProfileScreen> createState() => _EditBasicProfileScreenState();
}

class _EditBasicProfileScreenState extends State<EditBasicProfileScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  late SMITrigger confetti;

  void onUpdateInfo(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        await widget.viewModel.updateBasicInfo(
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

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      widget.viewModel.dobController.text =
          DateFormat('dd-MM-yyyy').format(picked);
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
          'Edit profile',
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
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: widget.viewModel.firstNameController,
                              decoration:
                                  InputDecoration(labelText: 'First Name'),
                            ),
                          ),
                          SizedBox(width: 10),
                          // Add some spacing between the fields
                          Expanded(
                            child: TextFormField(
                              controller: widget.viewModel.lastNameController,
                              decoration:
                                  InputDecoration(labelText: 'Last Name'),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller:
                            widget.viewModel.summaryIntroductionController,
                        decoration:
                            InputDecoration(labelText: 'Summary Introduction'),
                      ),
                      TextFormField(
                        controller: widget.viewModel.emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        controller: widget.viewModel.addressController,
                        decoration: InputDecoration(labelText: 'Address'),
                      ),
                      TextFormField(
                        controller: widget.viewModel.phoneController,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                      ),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: widget.viewModel.dobController,
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                            ),
                          ),
                        ),
                      ),
                      buildGenderSelector(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.viewModel.socialMediaLinks.length,
                        itemBuilder: (context, index) {
                          return TextFormField(
                            initialValue:
                                widget.viewModel.socialMediaLinks[index],
                            decoration: InputDecoration(
                                labelText: 'Social Media Link ${index + 1}'),
                            onChanged: (value) {
                              setState(() {
                                widget.viewModel.socialMediaLinks[index] =
                                    value;
                              });
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 0),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              onUpdateInfo(context);
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
                              "SAVE",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                                wordSpacing: 1.2,
                              ),
                            )),
                      )
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
