// SHARED BETWEEN PROJECTS - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import '/shared_customization/data/basic_types.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, required this.child});
  final FormChildWidgetBuilder child;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: widget.child(_formKey),
    );
  }
}
