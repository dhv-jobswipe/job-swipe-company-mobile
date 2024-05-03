import 'package:flutter/material.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/shared_customization/widgets/buttons/input_container.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput(
      {Key? key,
      required this.icon,
      required this.hint,
      required this.controller})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        child: TextField(
      controller: controller,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor),
          hintText: hint,
          border: InputBorder.none),
    ));
  }
}
