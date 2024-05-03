import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl5/constants.dart';

class ConfirmDialogAlert extends StatefulWidget {
  final VoidCallback onConfirm;
  final String title;
  final String content;
  final String confirmText;

  const ConfirmDialogAlert(
      {super.key,
      required this.onConfirm,
      required this.title,
      required this.content,
      required this.confirmText});

  @override
  State<ConfirmDialogAlert> createState() => _ConfirmDialogAlertState();
}

class _ConfirmDialogAlertState extends State<ConfirmDialogAlert> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        widget.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          color: orangePink,
        ),
      ),
      content: Text(
        widget.content,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(
            widget.confirmText,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            widget.onConfirm();
          },
        ),
        CupertinoDialogAction(
          child: Text(
            'Cancel',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
