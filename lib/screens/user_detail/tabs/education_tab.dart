import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/models/user_educations/user_educations.dart';
import 'package:pbl5/shared_customization/extensions/date_time_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';

class EducationTab extends StatelessWidget {
  final List<UserEducations> educations;
  const EducationTab({super.key, required this.educations});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder : (context){

        final allStudyPlaces =
        educations.map((e) => e.studyPlace ?? '').join(', ');

        final allStudyDetail = educations
            .map(
              (e) => Container(

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRichKeyValue(
                      context, 'Study place: ', e.studyPlace ?? ''),
                  buildRichKeyValue(
                      context, 'Majority: ', e.majority ?? ''),
                  buildRichKeyValue(context, 'Start date: ',
                      e.studyStartTime?.toDateTime?.toDayMonthYear() ?? ''),
                  buildRichKeyValue(context, 'End date: ',
                      e.studyEndTime?.toDateTime?.toDayMonthYear() ?? ''),
                  buildRichKeyValue(
                      context, 'CPA: ', e.cpa?.toString() ?? ''),
                  buildRichKeyValue(context, 'Note: ', e.note ?? ''),
                  SizedBox(height: 15,),
                  Divider(),
                ],
              ),
            ),
          ),
        )
            .toList();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: allStudyDetail,),
        );
      }
    );
  }
}

RichText buildRichKeyValue(
    BuildContext context, String title, String content) {
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