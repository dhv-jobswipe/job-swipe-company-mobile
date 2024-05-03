import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedRoundedContainer extends StatefulWidget {
  final Widget child;

  const CustomizedRoundedContainer({super.key, required this.child});

  @override
  State<CustomizedRoundedContainer> createState() =>
      _CustomizedRoundedContainerState();
}

class _CustomizedRoundedContainerState
    extends State<CustomizedRoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 10.w,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 4.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
