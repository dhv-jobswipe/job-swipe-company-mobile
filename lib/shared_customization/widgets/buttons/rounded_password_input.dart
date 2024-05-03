import 'package:flutter/material.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/shared_customization/widgets/buttons/input_container.dart';

class RoundedPasswordInput extends StatelessWidget {
  const RoundedPasswordInput({
    Key? key,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        child: TextFormField(
      controller: controller,
      cursorColor: kPrimaryColor,
      obscureText: true,
      validator: (String? e) {
        print(e);
      },
      decoration: InputDecoration(
          icon: Icon(Icons.lock, color: kPrimaryColor),
          hintText: hint,
          border: InputBorder.none),
    ));
  }
}
