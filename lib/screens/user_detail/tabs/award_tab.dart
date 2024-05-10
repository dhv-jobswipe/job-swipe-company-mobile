import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/models/user_awards/user_awards.dart';
import 'package:pbl5/models/user_educations/user_educations.dart';
import 'package:pbl5/shared_customization/extensions/date_time_ext.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';

class AwardTab extends StatelessWidget {
  final List<UserAwards> awards;
  const AwardTab({super.key, required this.awards});

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder : (context){

          final allAwardName =
          awards.map((e) => e.certificateName ?? '').join(', ');

          final allAwardDetail = awards
              .map((a) => Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRichKeyValue(context, 'Certificate Name: ',
                      a.certificateName ?? ''),
                  buildRichKeyValue(context, 'Certificate Time: ',
                      a.certificateTime.toDateTime.toDayMonthYear()),
                  buildRichKeyValue(context, 'Note: ', a.note ?? ''),
                  SizedBox(height: 15,),
                  Divider(),
                ],
              ),
            ),
          ))
              .toList();

          return SingleChildScrollView(
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: allAwardDetail,),
            
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