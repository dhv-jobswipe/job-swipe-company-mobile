import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pbl5/constants.dart';

class SecondaryCard extends StatelessWidget {
  final Color color;
  final String title;
  final String content;
  final IconData? icondata;

  SecondaryCard({
    super.key,
    this.color = const Color(0xFF7553F6),
    this.title = "title",
    this.content = "",
    this.icondata,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.h),
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
        color: skinColor.withOpacity(0.8),
        // gradient: LinearGradient(
        //   end: Alignment.centerLeft,
        //   begin: Alignment.centerRight,
        //   stops: [-0.5, 0],
        //   colors: [
        //     Colors.white,
        //     Color(0xFFFFEBB2),
        //   ],
        // ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            7.r,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    letterSpacing: 1.3,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              thickness: 2,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 8),
          icondata != null
              ? Icon(
                  icondata,
                  color: Colors.white70,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
