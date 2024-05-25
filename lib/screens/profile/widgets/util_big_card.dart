import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UtilBigCard extends StatelessWidget {
  final String title;
  final Color color;
  final String iconSrc;
  final Widget? child;
  final ScrollController scrollController;

  UtilBigCard({
    this.title = "title",
    this.color = const Color(0xFF7553F6),
    this.iconSrc = "assets/icons/ios.svg",
    required this.child,
    required this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          height: 240.h,
          width: 250.w,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(
              20.r,
            )),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Expanded(
                      child: child == null
                          ? Container()
                          : RawScrollbar(
                              thumbColor: Colors.white70,
                              trackVisibility: true,
                              radius: Radius.circular(10.r),
                              controller: scrollController,
                              thumbVisibility: true,
                              padding: EdgeInsets.symmetric(
                                vertical: 25.h,
                              ),
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: child,
                              ),
                            ),
                    ),

                    //const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 17.5,
          top: 22,
          child: SvgPicture.asset(
            iconSrc,
            height: 30.h,
            width: 30.w,
          ),
        ),
      ],
    );
  }
}
