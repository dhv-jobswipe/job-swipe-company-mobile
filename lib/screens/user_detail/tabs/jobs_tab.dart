import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/models/application_position/application_position.dart'; // Import the ApplicationPosition model

class JobsTab extends StatelessWidget {
  final List<ApplicationPosition> positions; // Add a positions parameter

  const JobsTab({Key? key, required this.positions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Opening position",
            style: TextStyle(
              fontSize: 19,
              color: Colors.black87,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              itemCount: positions.length,
              itemBuilder: (context, index) {
                final position = positions[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.work),
                    title: Text(position.applyPosition?.constantName ?? ''),
                    subtitle: Text(
                        'Salary: ${position.salaryRange?.constantName ?? ''}\nSkills: ${position.skills?.map((s) => s.skill?.constantName ?? '').join(', ')}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
