import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/models/user_experiences/user_experiences.dart';
import 'package:pbl5/shared_customization/extensions/date_time_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';

class ExperienceTab extends StatelessWidget {
  final List<UserExperiences> experiences;
  const ExperienceTab({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final allExperienceDetail = experiences
          .map((e) => Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRichKeyValue(
                          context, 'Position: ', e.position ?? ''),
                      buildRichKeyValue(
                          context, 'Work Place: ', e.workPlace ?? ''),
                      buildRichKeyValue(context, 'Start date: ',
                          e.experienceStartTime.toDateTime.toDayMonthYear()),
                      buildRichKeyValue(context, 'End date: ',
                          e.experienceEndTime.toDateTime.toDayMonthYear()),
                      buildRichKeyValue(context, 'Type: ',
                          e.experienceType?.constantName ?? ''),
                      buildRichKeyValue(context, 'Note: ', e.note ?? ''),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ))
          .toList();
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: allExperienceDetail,
        ),
      );
    });
  }
}

RichText buildRichKeyValue(BuildContext context, String title, String content) {
  return RichText(
    text: TextSpan(
      text: title,
      style: DefaultTextStyle.of(context)
          .style
          .copyWith(fontWeight: FontWeight.bold),
      children: <TextSpan>[
        TextSpan(
          text: content,
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 15.sp),
        ),
      ],
    ),
  );
}
